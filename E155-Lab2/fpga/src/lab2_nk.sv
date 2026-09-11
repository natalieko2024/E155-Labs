module lab2_nk(input logic reset, 
				input logic [7:0] s,
				input logic [3:0] cols,
				output logic anodeLeft, anodeRight,
				output logic [6:0] segWrite,
				output logic [3:0] rows,
				output logic [3:0] leds);
	
	logic clk;
	logic [6:0] seg;
	
	// Internal HSOSC to provide a 24MHz oscillation frequency output
	HSOSC #(.CLKHF_DIV("0b01"))
		hf_osc(.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));
	
	// scanning module
	scan scan(clk, reset, 1'b1, rows);

	// multiplexing counter module to write outputs at a frequency
	muxCounter muxCounter(clk, reset, 1'b1, s, anodeLeft, anodeRight, switchWrite);
	
	// 7-segment module
	switch_7seg switch7seg(switchWrite, segWrite);

	// assign statements to implement multiplexing and scanning
	assign leds = cols;

endmodule