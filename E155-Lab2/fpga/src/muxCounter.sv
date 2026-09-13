// Natalie Ko (nko@g.hmc.edu)
// Created on 8 Sept 2026
// The  module muxCounter switches which 7-segment display to write to on each positive edge of the clock cyle. The clock frequency was chosen to eliminate flickering and bleeding.

module muxCounter(input logic clk, reset, enable,
                  input logic [7:0] s,
                  output logic anodeLeft, anodeRight,
                  output logic [3:0] switchLeft, switchRight);

	logic stepDownClk, nextAnodeLeft, nextAnodeRight;
	logic [16:0] counter;

	// Use my counter module to step down 24MHz to 120Hz
    freqconverter #(.WIDTH(17), .MAX(100000)) oscillator(clk, reset, enable, stepDownClk, counter);

    // Switch which 7-seg to write to every rising clock edge and write to it
    always_ff @(posedge stepDownClk, negedge reset) begin
        if (~reset)	begin
			anodeLeft <= 1'b1;
			anodeRight <= 1'b0;
		end 
		else if (enable) begin 
			anodeLeft <= nextAnodeLeft;
			anodeRight <= nextAnodeRight;
		end
    end

    // Set up next state of anode toggle, always going to invert it
    // Save the 7-segment output for each side
    always_comb begin 
		nextAnodeLeft = anodeRight;
		nextAnodeRight = anodeLeft;
		switchLeft = s[7:4];
		switchRight = s[3:0];
	end
    
endmodule