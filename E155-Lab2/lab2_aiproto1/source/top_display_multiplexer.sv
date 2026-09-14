module top_display_multiplexer #(
    parameter integer CLK_FREQ_HZ = 50_000_000, // 50 MHz input clock
    parameter integer REFRESH_HZ  = 200          // Overall refresh frequency
)(
    input  logic       clk,
    input  logic       rst_n,      // Active-low asynchronous reset
    input  logic [3:0] in_digit0,  // First 4-bit nibble
    input  logic [3:0] in_digit1,  // Second 4-bit nibble
    output logic [6:0] seg,        // Seven segment outputs {g, f, e, d, c, b, a}
    output logic [1:0] anode       // Digit select lines (active-low)
);

    // Calculate clock divider threshold for multiplexing rate
    // Toggles every half-period of total refresh cycle
    localparam integer CNT_MAX = CLK_FREQ_HZ / (REFRESH_HZ * 2);

    logic [$clog2(CNT_MAX)-1:0] clk_cnt;
    logic                       digit_sel; // 0 = Digit 0, 1 = Digit 1
    logic [3:0]                 mux_nibble;

    // ------------------------------------------------------------------------
    // 1. Clock Divider / Mux Selector
    // ------------------------------------------------------------------------
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            clk_cnt   <= '0;
            digit_sel <= 1'b0;
        end else if (clk_cnt == CNT_MAX - 1) begin
            clk_cnt   <= '0;
            digit_sel <= ~digit_sel; // Toggle active digit
        end else begin
            clk_cnt   <= clk_cnt + 1'b1;
        end
    end

    // ------------------------------------------------------------------------
    // 2. Data Multiplexer & Anode Controller (Active-Low)
    // ------------------------------------------------------------------------
    always_comb begin
        case (digit_sel)
            1'b0: begin
                mux_nibble = in_digit0;
                anode      = 2'b10; // Enable Digit 0 (active-low)
            end
            1'b1: begin
                mux_nibble = in_digit1;
                anode      = 2'b01; // Enable Digit 1 (active-low)
            end
            default: begin
                mux_nibble = 4'h0;
                anode      = 2'b11; // Turn off both
            end
        endcase
    end

    // ------------------------------------------------------------------------
    // 3. Shared Seven-Segment Decoder Instance
    // ------------------------------------------------------------------------
    sev_seg_decoder u_decoder (
        .nibble (mux_nibble),
        .seg    (seg)
    );

endmodule


