// Target Device: Lattice iCE40UP5K (UltraPlus)
// Description: Drives an LED at 2 Hz using the internal 48 MHz HSOSC oscillator.

module top (
    output logic led
);

    // Internal signals
    logic clk_48mhz;
    
    // Counter parameters
    localparam int CLK_FREQ = 48_000_000;              // 48 MHz nominal oscillator
    localparam int TOGGLE_LIMIT = (CLK_FREQ / 4) - 1;   // 12,000,000 cycles (0.25s)
    
    // 24-bit counter variable
    logic [23:0] counter = '0;

    // Instantiate Lattice iCE40 UltraPlus HSOSC Primitive
    // CLKHF_DIV: "0b00" = 48 MHz, "0b01" = 24 MHz, "0b10" = 12 MHz, "0b11" = 6 MHz
    HSOSC #(
        .CLKHF_DIV("0b00")
    ) hsn_osc_inst (
        .CLKHFEN(1'b1),      // Enable high-speed oscillator
        .CLKHFPU(1'b1),      // Power up high-speed oscillator
        .CLKHF(clk_48mhz)    // High-speed clock output
    );

    // 2 Hz Toggle Logic
    always_ff @(posedge clk_48mhz) begin
        if (counter >= TOGGLE_LIMIT) begin
            counter <= '0;
            led     <= ~led;
        end else begin
            counter <= counter + 1'b1;
        end
    end

endmodule