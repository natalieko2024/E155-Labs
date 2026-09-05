// Natalie Ko (nko@g.hmc.edu)
// Created on 2 Sept 2026
// The module lab1_nk initializes the 24MHz HSOSC signal, and finalizes the LED and 7-segment display outputs based on switch inputs and modules oscillator and switch_7seg.
module lab1_nk( input logic reset,
				input logic [3:0] s,
				output logic [2:0] led,
				output logic [6:0] seg,
				output clk);
	
	// Initialize a clock signal for the oscillation
	logic clk;
	
	// Set up the internal HSOSC to provide a 24MHz oscillation frequency output
	HSOSC #(.CLKHF_DIV(2'b01)) 
		hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));
	
	// Combinational logic to convert switch inputs to LED signals 0 and 1
	// XOR
	assign led[0] = s[0] ^ s[1];
	// AND
	assign led[1] = s[2] & s[3];
	
	// Calling other modules to set the third LED and the 7 segment display
	oscillator		oscillator_module(clk, reset, led[2]);
	switch_7seg		switch_7seg(s, seg);

endmodule