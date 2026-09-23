// Target Device: Lattice iCE40 UP5K FPGA
// Function: 4x4 Keypad Scanner, Debouncer, and One-Shot Key Registration FSM

module keypad_one_shot #(
    parameter int CLK_FREQ_HZ   = 12_000_000, // Default SB_HFOSC / 4 (~12 MHz)
    parameter int DEBOUNCE_MS   = 10          // Debounce delay per scan step (~10 ms)
)(
    input  logic       clk,            // System clock
    input  logic       rst_n,          // Active-low asynchronous reset
    input  logic [3:0] col_pad,        // Inputs from Keypad Columns (active-low with pull-ups)
    output logic [3:0] row_pad,        // Outputs to Keypad Rows (driven low sequentially)
    output logic [3:0] key_code,       // Registered 4-bit hex value (0x0 - 0xF)
    output logic       new_key_valid   // 1-cycle strobe when a new key is captured
);

    // =========================================================================
    // 1. Clock Divider / Tick Generator for Debounce & Scan Speed
    // =========================================================================
    localparam int TICK_COUNT_MAX = (CLK_FREQ_HZ / 1000) * DEBOUNCE_MS;
    localparam int TICK_CNT_WIDTH = $clog2(TICK_COUNT_MAX);

    logic [TICK_CNT_WIDTH-1:0] tick_cnt;
    logic                      scan_tick;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tick_cnt  <= '0;
            scan_tick <= 1'b0;
        end else begin
            scan_tick <= 1'b0;
            if (tick_cnt >= TICK_COUNT_MAX - 1) begin
                tick_cnt  <= '0;
                scan_tick <= 1'b1;
            end else begin
                tick_cnt  <= tick_cnt + 1'b1;
            end
        end
    end

    // =========================================================================
    // 2. Row Scanning Logic (Active-Low Driving)
    // =========================================================================
    logic [1:0] row_idx;
    
    // Convert 2-bit counter into active-low 1-of-4 row drive pattern
    assign row_pad = ~(4'b0001 << row_idx);

    // =========================================================================
    // 3. Column Key Code Decoding
    // =========================================================================
    logic       col_active;
    logic [1:0] col_idx;

    // Detect if any key in the current scanned row is pressed (col input is LOW)
    always_comb begin
        case (col_pad)
            4'b1110: begin col_active = 1'b1; col_idx = 2'd0; end
            4'b1101: begin col_active = 1'b1; col_idx = 2'd1; end
            4'b1011: begin col_active = 1'b1; col_idx = 2'd2; end // 4'b1011
            4'b0111: begin col_active = 1'b1; col_idx = 2'd3; end
            default: begin col_active = 1'b0; col_idx = 2'd0; end
        endcase
    end

    // Hex Lookup Table mapping Matrix Position {Row, Col} to standard Hex Keypad values
    // [R0 C0..C3] -> 1, 2, 3, A
    // [R1 C0..C3] -> 4, 5, 6, B
    // [R2 C0..C3] -> 7, 8, 9, C
    // [R3 C0..C3] -> 0, F, E, D
    logic [3:0] decoded_key;
    always_comb begin
        case ({row_idx, col_idx})
            4'h0: decoded_key = 4'h1;
            4'h1: decoded_key = 4'h2;
            4'h2: decoded_key = 4'h3;
            4'h3: decoded_key = 4'hA;
            
            4'h4: decoded_key = 4'h4;
            4'h5: decoded_key = 4'h5;
            4'h6: decoded_key = 4'h6;
            4'h7: decoded_key = 4'hB;
            
            4'h8: decoded_key = 4'h7;
            4'h9: decoded_key = 4'h8;
            4'hA: decoded_key = 4'h9;
            4'hB: decoded_key = 4'hC;
            
            4'hC: decoded_key = 4'h0;
            4'hD: decoded_key = 4'hF;
            4'hE: decoded_key = 4'hE;
            4'hF: decoded_key = 4'hD;
        endcase
    end

    // =========================================================================
    // 4. One-Shot Debounce and Key-Lockout FSM
    // =========================================================================
    typedef enum logic [1:0] {
        ST_IDLE         = 2'b00,
        ST_DEBOUNCE     = 2'b01,
        ST_CAPTURE      = 2'b11,
        ST_WAIT_RELEASE = 2'b10
    } state_e;

    state_e state;
    logic [1:0] captured_row;
    logic [1:0] captured_col;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state         <= ST_IDLE;
            row_idx       <= '0;
            key_code      <= '0;
            new_key_valid <= 1'b0;
            captured_row  <= '0;
            captured_col  <= '0;
        end else begin
            // Default output strobe clear
            new_key_valid <= 1'b0;

            if (scan_tick) begin
                case (state)
                    // Continuous scanning state until a key press is detected
                    ST_IDLE: begin
                        if (col_active) begin
                            captured_row <= row_idx;
                            captured_col <= col_idx;
                            state        <= ST_DEBOUNCE;
                        end else begin
                            row_idx <= row_idx + 1'b1;
                        end
                    end

                    // Wait 1 scan tick period to verify stability
                    ST_DEBOUNCE: begin
                        // Check if the same key position is still active
                        if (col_active && (row_idx == captured_row) && (col_idx == captured_col)) begin
                            state <= ST_CAPTURE;
                        end else begin
                            // False trigger / bounce, return to scan
                            row_idx <= row_idx + 1'b1;
                            state   <= ST_IDLE;
                        end
                    end

                    // Assert single-cycle strobe output and save key code
                    ST_CAPTURE: begin
                        key_code      <= decoded_key;
                        new_key_valid <= 1'b1; // Glitch-free registered output
                        state         <= ST_WAIT_RELEASE;
                    end

                    // Multi-key lockout: Keep scanning rows, but refuse new input until ALL keys released
                    ST_WAIT_RELEASE: begin
                        row_idx <= row_idx + 1'b1;
                        if (!col_active) begin
                            // Check if a full scanning cycle across all 4 rows shows no active keys
                            if (row_idx == 2'd3) begin
                                state <= ST_IDLE;
                            end
                        end
                    end

                    default: state <= ST_IDLE;
                endcase
            end
        end
    end

endmodule

// Target Device: Lattice iCE40 UP5K FPGA
// Function: 4x4 Keypad Scanner and Row Sampler with Active-Low I/O

module keypad_scanner #(
    parameter int CLK_FREQ_HZ  = 12_000_000, // Default system clock frequency (12 MHz)
    parameter int SCAN_FREQ_HZ = 1_000       // Scan step frequency (1 kHz -> 1 ms per column)
)(
    input  logic       clk,           // System clock
    input  logic       rst_n,         // Active-low asynchronous reset
    input  logic [3:0] row_pad,       // Rows from Keypad (Inputs, Active-Low with Pull-ups)
    output logic [3:0] col_pad,       // Columns to Keypad (Outputs, Driven Active-Low)
    output logic [3:0] key_code,      // Decoded Hex Key Value (0x0 - 0xF)
    output logic       key_pressed    // High whenever a key is currently held down
);

    // =========================================================================
    // 1. Clock Divider for Column Scanning
    // =========================================================================
    localparam int CLK_DIV_MAX = CLK_FREQ_HZ / SCAN_FREQ_HZ;
    localparam int CLK_DIV_W   = $clog2(CLK_DIV_MAX);

    logic [CLK_DIV_W-1:0] clk_cnt;
    logic                 scan_tick;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            clk_cnt   <= '0;
            scan_tick <= 1'b0;
        end else begin
            scan_tick <= 1'b0;
            if (clk_cnt >= CLK_DIV_MAX - 1) begin
                clk_cnt   <= '0;
                scan_tick <= 1'b1;
            end else begin
                clk_cnt   <= clk_cnt + 1'b1;
            end
        end
    end

    // =========================================================================
    // 2. Input Synchronizer for Row Pads (Metastability Protection)
    // =========================================================================
    logic [3:0] row_sync_0, row_sync_1;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            row_sync_0 <= 4'b1111;
            row_sync_1 <= 4'b1111;
        end else begin
            row_sync_0 <= row_pad;
            row_sync_1 <= row_sync_0;
        end
    end

    // =========================================================================
    // 3. FSM State Definition & Keypad Scan Logic
    // =========================================================================
    typedef enum logic [1:0] {
        COL_0 = 2'd0,
        COL_1 = 2'd1,
        COL_2 = 2'd2,
        COL_3 = 2'd3
    } scan_state_e;

    scan_state_e col_state;

    // Active-Low Column Drive Pattern
    always_comb begin
        case (col_state)
            COL_0:   col_pad = 4'b1110;
            COL_1:   col_pad = 4'b1101;
            COL_2:   col_pad = 4'b1011;
            COL_3:   col_pad = 4'b0111;
            default: col_pad = 4'b1111;
        endcase
    end

    // Active-Low Row Detection
    logic       row_active;
    logic [1:0] active_row_idx;

    always_comb begin
        case (row_sync_1)
            4'b1110: begin row_active = 1'b1; active_row_idx = 2'd0; end
            4'b1101: begin row_active = 1'b1; active_row_idx = 2'd1; end
            4'b1011: begin row_active = 1'b1; active_row_idx = 2'd2; end
            4'b0111: begin row_active = 1'b1; active_row_idx = 2'd3; end
            default: begin row_active = 1'b0; active_row_idx = 2'd0; end
        endcase
    end

    // Standard 4x4 Keypad Decoding
    // [Row 0]: 1, 2, 3, A
    // [Row 1]: 4, 5, 6, B
    // [Row 2]: 7, 8, 9, C
    // [Row 3]: 0, F, E, D
    logic [3:0] decoded_hex;

    always_comb begin
        case ({active_row_idx, col_state})
            4'h0: decoded_hex = 4'h1;
            4'h1: decoded_hex = 4'h2;
            4'h2: decoded_hex = 4'h3;
            4'h3: decoded_hex = 4'hA;

            4'h4: decoded_hex = 4'h4;
            4'h5: decoded_hex = 4'h5;
            4'h6: decoded_hex = 4'h6;
            4'h7: decoded_hex = 4'hB;

            4'h8: decoded_hex = 4'h7;
            4'h9: decoded_hex = 4'h8;
            4'hA: decoded_hex = 4'h9;
            4'hB: decoded_hex = 4'hC;

            4'hC: decoded_hex = 4'h0;
            4'hD: decoded_hex = 4'hF;
            4'hE: decoded_hex = 4'hE;
            4'hF: decoded_hex = 4'hD;
        endcase
    end

    // =========================================================================
    // 4. Sequential State Machine and Key Latch
    // =========================================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            col_state   <= COL_0;
            key_code    <= 4'h0;
            key_pressed <= 1'b0;
        end else begin
            if (scan_tick) begin
                if (row_active) begin
                    // Key detected on current active column: capture code & stop cycling
                    key_code    <= decoded_hex;
                    key_pressed <= 1'b1;
                end else begin
                    // Advance to next column scan state
                    case (col_state)
                        COL_0:   col_state <= COL_1;
                        COL_1:   col_state <= COL_2;
                        COL_2:   col_state <= COL_3;
                        COL_3:   col_state <= COL_0;
                        default: col_state <= COL_0;
                    endcase

                    // Clear pressed status if completing full cycle with no active keys
                    if (col_state == COL_3) begin
                        key_pressed <= 1'b0;
                    end
                end
            end
        end
    end

endmodule

// Target Device: Lattice iCE40 UP5K FPGA
// Module: Top-Level Keypad Scanner & Dual 7-Segment Multiplexed Display

module top_keypad_display (
    input  logic       rst_n,        // Active-low external reset (e.g., pushbutton)
    input  logic [3:0] row_pad,      // Keypad row inputs (active-low with pull-ups)
    output logic [3:0] col_pad,      // Keypad column outputs (driven low sequentially)
    output logic [1:0] digit_select, // Digit select lines (active-low for PNP/P-FET drivers)
    output logic [6:0] segments     // 7-segment cathode drivers [a, b, c, d, e, f, g]
);

    // =========================================================================
    // 1. Lattice iCE40 UP5K Internal Oscillator Primitive (SB_HFOSC)
    // =========================================================================
    // Configured for 12 MHz default clock output (DIV = "0b10")
    logic clk;

    SB_HFOSC #(
        .CLKHF_DIV("0b10") // 48 MHz / 4 = 12 MHz
    ) u_hfosc (
        .CLKHFPU(1'b1),    // Power-up oscillator
        .CLKHFEN(1'b1),    // Enable clock output
        .CLKHF  (clk)      // Root clock signal (~12 MHz)
    );

    // =========================================================================
    // 2. Multiplexing Refresh Counter / Clock Divider (~200 Hz Display Refresh)
    // =========================================================================
    // Total refresh rate ~200 Hz across 2 digits (100 Hz per digit) ensures
    // zero visible flicker and uniform brightness.
    localparam int CLK_FREQ_HZ     = 12_000_000;
    localparam int MUX_FREQ_HZ     = 200;
    localparam int MUX_DIV_COUNT   = CLK_FREQ_HZ / MUX_FREQ_HZ;
    localparam int MUX_DIV_WIDTH   = $clog2(MUX_DIV_COUNT);

    logic [MUX_DIV_WIDTH-1:0] mux_cnt;
    logic                     mux_tick;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            mux_cnt  <= '0;
            mux_tick <= 1'b0;
        end else begin
            mux_tick <= 1'b0;
            if (mux_cnt >= MUX_DIV_COUNT - 1) begin
                mux_cnt  <= '0;
                mux_tick <= 1'b1;
            end else begin
                mux_cnt  <= mux_cnt + 1'b1;
            end
        end
    end

    // =========================================================================
    // 3. Keypad Scanner & One-Shot Instantiation
    // =========================================================================
    logic [3:0] current_key;
    logic       new_key_valid;

    keypad_one_shot #(
        .CLK_FREQ_HZ(CLK_FREQ_HZ),
        .DEBOUNCE_MS(10)
    ) u_keypad_one_shot (
        .clk          (clk),
        .rst_n        (rst_n),
        .col_pad      (col_pad),
        .row_pad      (row_pad),
        .key_code     (current_key),
        .new_key_valid(new_key_valid)
    );

    // =========================================================================
    // 4. Two-Digit Shift Register (Last Two Keys)
    // =========================================================================
    // digit_old (Digit 1 - Left) receives previous digit_recent
    // digit_recent (Digit 0 - Right) receives newest key press
    logic [3:0] digit_recent;
    logic [3:0] digit_old;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            digit_recent <= 4'h0;
            digit_old    <= 4'h0;
        end else if (new_key_valid) begin
            digit_old    <= digit_recent; // Shift previous key to left digit
            digit_recent <= current_key;  // Store new key in right digit
        end
    end

    // =========================================================================
    // 5. Display Multiplexer & Active-Low Digit Anode Driver
    // =========================================================================
    logic       active_digit; // 0 = Right Digit (Recent), 1 = Left Digit (Old)
    logic [3:0] mux_hex_val;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            active_digit <= 1'b0;
        end else if (mux_tick) begin
            active_digit <= ~active_digit;
        end
    end

    // Select which hex digit to feed into 7-segment decoder
    assign mux_hex_val = active_digit ? digit_old : digit_recent;

    // Active-Low digit select signal (drive low to activate digit transistor)
    // digit_select[0] = Right (Recent), digit_select[1] = Left (Old)
    assign digit_select = active_digit ? 2'b10 : 2'b01;

    // =========================================================================
    // 6. Seven Segment Decoder Instantiation
    // =========================================================================
    sevenSegment u_seven_seg (
        .hex_in  (mux_hex_val),
        .segments(segments)
    );

endmodule

// Standard Active-Low Common-Anode 7-Segment Decoder
// Segments layout: [a, b, c, d, e, f, g]
module sevenSegment (
    input  logic [3:0] hex_in,
    output logic [6:0] segments
);
    always_comb begin
        case (hex_in)
            4'h0: segments = 7'b000_0001; // 0
            4'h1: segments = 7'b100_1111; // 1
            4'h2: segments = 7'b001_0010; // 2
            4'h3: segments = 7'b000_0110; // 3
            4'h4: segments = 7'b100_1100; // 4
            4'h5: segments = 7'b010_0100; // 5
            4'h6: segments = 7'b010_0000; // 6
            4'h7: segments = 7'b000_1111; // 7
            4'h8: segments = 7'b000_0000; // 8
            4'h9: segments = 7'b000_0100; // 9
            4'hA: segments = 7'b000_1000; // A
            4'hB: segments = 7'b110_0000; // b
            4'hC: segments = 7'b011_0001; // C
            4'hD: segments = 7'b100_0010; // d
            4'hE: segments = 7'b011_0000; // E
            4'hF: segments = 7'b011_1000; // F
            default: segments = 7'b111_1111;
        endcase
    end
endmodule