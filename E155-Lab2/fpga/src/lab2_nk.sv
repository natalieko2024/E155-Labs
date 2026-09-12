module lab2_nk(input logic reset, 
				input logic [7:0] s,
				input logic [3:0] cols,
				output logic anodeLeft, anodeRight,
				output logic [6:0] segWrite,
				output logic [3:0] rows,
				output logic [3:0] leds);
	
	logic clk;
	logic [3:0] switchWrite, switchLeft, switchRight;
	
	// Internal HSOSC to provide a 24MHz oscillation frequency output
	HSOSC #(.CLKHF_DIV("0b01"))
		hf_osc(.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));


	// multiplexing counter module to write outputs at a frequency
	muxCounter mc1(clk, reset, 1'b1, s, anodeLeft, anodeRight, switchLeft, switchRight);
	
	// 7-segment module
	switch_7seg ss1(switchWrite, segWrite);
	
	// Implement 7-segment mux for which side to write to
	assign switchWrite = anodeLeft? switchLeft : switchRight;
	
	// keypad guys
		
	// scanning module
	scan s1(clk, reset, 1'b1, rows);

	// assign statements to implement multiplexing and scanning
	assign leds = ~(cols);

endmodule