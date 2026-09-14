// SystemVerilog module to time-multiplex a single seven-segment decoder
// across two 4-bit inputs using a single switch_7seg module and oscillator.

module display_multiplexer (
    input  logic       reset,
    input  logic [3:0] val0,
    input  logic [3:0] val1,
    output logic [6:0] seg0,
    output logic [6:0] seg1
);

    logic clk;
    logic select;
    logic [22:0] count;
    
    logic [3:0] current_val;
    logic [6:0] decoded_seg;

    // Instantiate high-speed oscillator (24MHz clock)[cite: 7]
    HSOSC #(.CLKHF_DIV("0b01")) hf_osc (
        .CLKHFPU(1'b1),
        .CLKHFEN(1'b1),
        .CLKHF(clk)
    );

    // Instantiate frequency converter to toggle select bit[cite: 1]
    // Default MAX/WIDTH creates a standard multiplexing toggle frequency.
    freqconverter #(.WIDTH(23), .MAX(5000000)) freq_divider (
        .clk(clk),
        .reset(reset),
        .enable(1'b1),
        .led2(select),
        .counter(count)
    );

    // Multiplexer selecting which input nibble goes to the decoder
    assign current_val = select ? val1 : val0;

    // Instantiate the single shared 7-segment decoder[cite: 8]
    switch_7seg decoder (
        .s(current_val),
        .seg(decoded_seg)
    );

    // Demultiplex / Latch decoded 7-segment output values
    always_ff @(posedge clk) begin
        if (~reset) begin
            seg0 <= 7'b1111111; // All OFF (common anode)[cite: 8]
            seg1 <= 7'b1111111;
        end else begin
            if (select == 1'b0)
                seg0 <= decoded_seg;
            else
                seg1 <= decoded_seg;
        end
    end

endmodule