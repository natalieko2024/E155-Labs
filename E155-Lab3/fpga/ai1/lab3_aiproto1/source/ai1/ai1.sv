// File: clk_gen.sv
// Generates single-cycle enable pulses from the HFOSC master clock.
module clk_gen #(
    parameter int CLK_FREQ = 24_000_000, // 24 MHz HFOSC clock
    parameter int SCAN_HZ  = 200,        // 200 Hz scan clock (~5ms period)
    parameter int MUX_HZ   = 1000        // 1 kHz multiplexing clock (~1ms period)
)(
    input  logic clk,
    input  logic rst_n,
    output logic scan_tick,              // Pulse active for 1 cycle at SCAN_HZ
    output logic mux_tick                // Pulse active for 1 cycle at MUX_HZ
);

    localparam int SCAN_LIMIT = CLK_FREQ / SCAN_HZ;
    localparam int MUX_LIMIT  = CLK_FREQ / MUX_HZ;

    int count_scan;
    int count_mux;

    // Scan tick generator (~200 Hz)
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count_scan <= 0;
            scan_tick  <= 1'b0;
        end else begin
            if (count_scan >= SCAN_LIMIT - 1) begin
                count_scan <= 0;
                scan_tick  <= 1'b1;
            end else begin
                count_scan <= count_scan + 1;
                scan_tick  <= 1'b0;
            end
        end
    end

    // Display multiplexing tick generator (~1 kHz)
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count_mux <= 0;
            mux_tick  <= 1'b0;
        end else begin
            if (count_mux >= MUX_LIMIT - 1) begin
                count_mux <= 0;
                mux_tick  <= 1'b1;
            end else begin
                count_mux <= count_mux + 1;
                mux_tick  <= 1'b0;
            end
        end
    end

endmodule

// File: keypad_scanner.sv
// Scans a 4x4 active-low keypad and emits a single-cycle valid pulse per press.
module keypad_scanner (
    input  logic       clk,
    input  logic       rst_n,
    input  logic       scan_tick,   // ~200 Hz pulse
    input  logic [3:0] rows,        // Active-low inputs from keypad
    output logic [3:0] cols,        // Active-low driven column outputs
    output logic [3:0] key_code,    // Decoded 4-bit Hex Value (0x0 - 0xF)
    output logic       key_valid    // 1-cycle pulse when key is registered
);

    typedef enum logic [1:0] {
        SCAN,       // Continuously scan columns
        REGISTER,   // Capture valid key code (1 cycle pulse)
        WAIT_RELEASE// Hold state until all keys are released
    } state_t;

    state_t state;

    logic [1:0] col_idx;
    logic [3:0] active_rows;
    logic [3:0] detected_key;
    logic       key_pressed;

    // Active-low column pattern: only one column is driven LOW at a time
    assign cols = ~(4'b0001 << col_idx);

    // Synchronize and invert rows (1 = pressed)
    assign active_rows = ~rows;

    // Determine if any key in the active column is pressed
    assign key_pressed = (active_rows != 4'b0000);

    // Row decoder logic
    always_comb begin
        case (active_rows)
            4'b0001: detected_key = {col_idx, 2'b00}; // Row 0 -> Hex offset 0
            4'b0010: detected_key = {col_idx, 2'b01}; // Row 1 -> Hex offset 1
            4'b0100: detected_key = {col_idx, 2'b10}; // Row 2 -> Hex offset 2
            4'b1000: detected_key = {col_idx, 2'b11}; // Row 3 -> Hex offset 3
            default: detected_key = 4'h0;             // Handle multi-key/invalid
        endcase
    end

    // FSM and Column Stepping Logic
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state     <= SCAN;
            col_idx   <= '0;
            key_code  <= '0;
            key_valid <= 1'b0;
        end else begin
            key_valid <= 1'b0; // Default pulse low

            if (scan_tick) begin
                case (state)
                    SCAN: begin
                        if (key_pressed) begin
                            key_code  <= detected_key;
                            key_valid <= 1'b1;
                            state     <= WAIT_RELEASE;
                        end else begin
                            col_idx <= col_idx + 1'b1; // Advance to next column
                        end
                    end

                    WAIT_RELEASE: begin
                        // Wait until all columns read zero active rows
                        if (!key_pressed) begin
                            col_idx <= col_idx + 1'b1;
                            // Check if we completed a full 4-col scan with no keys down
                            if (col_idx == 2'b11) begin
                                state <= SCAN;
                            end
                        end else begin
                            // Reset full release check if a key is still detected
                            col_idx <= col_idx + 1'b1;
                        end
                    end

                    default: state <= SCAN;
                endcase
            end
        end
    end

endmodule

// File: seven_seg_mux.sv
// Time-multiplexed driver for a dual 7-segment display (Common Anode).
module seven_seg_mux (
    input  logic       clk,
    input  logic       rst_n,
    input  logic       mux_tick,     // ~1 kHz refresh pulse
    input  logic [3:0] digit_high,   // Older hex digit (Left)
    input  logic [3:0] digit_low,    // Newest hex digit (Right)
    output logic [1:0] digit_sel,    // Active-low digit anode selects
    output logic [6:0] seg           // Active-low segments [a,b,c,d,e,f,g]
);

    logic       active_digit;
    logic [3:0] current_nibble;

    // Toggle active digit at 1 kHz
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            active_digit <= 1'b0;
        end else if (mux_tick) begin
            active_digit <= ~active_digit;
        end
    end

    // Select active nibble and digit strobe line
    always_comb begin
        if (active_digit == 1'b0) begin
            digit_sel      = 2'b10; // Enable Digit 0 (Right / Most recent)
            current_nibble = digit_low;
        end else begin
            digit_sel      = 2'b01; // Enable Digit 1 (Left / Older)
            current_nibble = digit_high;
        end
    end

    // Hex to 7-Segment Decoder (Active-LOW outputs: 0 = LED On)
    // Map order: [a, b, c, d, e, f, g]
    always_comb begin
        case (current_nibble)
            4'h0: seg = 7'b000_0001;
            4'h1: seg = 7'b100_1111;
            4'h2: seg = 7'b001_0010;
            4'h3: seg = 7'b000_0110;
            4'h4: seg = 7'b100_1100;
            4'h5: seg = 7'b010_0100;
            4'h6: seg = 7'b010_0000;
            4'h7: seg = 7'b000_1111;
            4'h8: seg = 7'b000_0000;
            4'h9: seg = 7'b000_0100;
            4'hA: seg = 7'b000_1000;
            4'hB: seg = 7'b110_0000;
            4'hC: seg = 7'b011_0001;
            4'hD: seg = 7'b100_0010;
            4'hE: seg = 7'b011_0000;
            4'hF: seg = 7'b011_1000;
            default: seg = 7'b111_1111; // Blank
        endcase
    end

endmodule

// File: top.sv
// Top-level module for Lattice iCE40 UP5K
module top (
    input  logic       ext_rst_n, // External active-low reset button
    input  logic [3:0] kp_rows,   // Keypad row inputs
    output logic [3:0] kp_cols,   // Keypad column outputs
    output logic [1:0] digit_sel, // Display digit selector (Active-low anode)
    output logic [6:0] seg        // Display segment driver (Active-low cathodic)
);

    // Internal High-Speed Oscillator Signal
    logic clk;

    // Instantiate Lattice iCE40 Primitive Oscillator
    // CLKF = 2'b00 configures output frequency to ~24 MHz
    HSOSC #(
    .CLKHF_DIV("0b01") // 0b00: 48MHz, 0b01: 24MHz, 0b10: 12MHz, 0b11: 6MHz
) hf_osc_inst (
    .CLKHFPU(1'b1),
    .CLKHFEN(1'b1),
    .CLKHF  (clk)
);

    // Control and Data Signals
    logic scan_tick;
    logic mux_tick;
    logic [3:0] new_key;
    logic       key_valid;

    // Shift Register for Key History
    logic [3:0] key_digit_recent;
    logic [3:0] key_digit_older;

    // Clock and Timing Generator
    clk_gen #(
        .CLK_FREQ(24_000_000),
        .SCAN_HZ(200),
        .MUX_HZ(1000)
    ) u_clk_gen (
        .clk       (clk),
        .rst_n     (ext_rst_n),
        .scan_tick (scan_tick),
        .mux_tick  (mux_tick)
    );

    // Matrix Keypad Controller
    keypad_scanner u_keypad (
        .clk       (clk),
        .rst_n     (ext_rst_n),
        .scan_tick (scan_tick),
        .rows      (kp_rows),
        .cols      (kp_cols),
        .key_code  (new_key),
        .key_valid (key_valid)
    );

    // Shift memory: Update history upon valid key registration
    always_ff @(posedge clk or negedge ext_rst_n) begin
        if (!ext_rst_n) begin
            key_digit_recent <= 4'h0;
            key_digit_older  <= 4'h0;
        end else if (key_valid) begin
            key_digit_older  <= key_digit_recent;
            key_digit_recent <= new_key;
        end
    end

    // Dual 7-Segment Display Driver
    seven_seg_mux u_display (
        .clk        (clk),
        .rst_n      (ext_rst_n),
        .mux_tick   (mux_tick),
        .digit_high (key_digit_older),
        .digit_low  (key_digit_recent),
        .digit_sel  (digit_sel),
        .seg        (seg)
    );

endmodule