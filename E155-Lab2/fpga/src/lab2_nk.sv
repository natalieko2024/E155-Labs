module lab2_nk(input logic reset, enable,
				input logic [4:0] s,
				input logic [3:0] cols,
				output logic [6:0] segWrite,
				output logic [3:0] rows
				output logic [3:0] leds);
	
	// Internal HSOSC to provide a 24MHz oscillation frequency output
	HSOSC #(.CLKHF_DIV("0b01")
		hf_osc(.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));
	
	// scanning module
	scan scan(clk, reset, enable, rows);

	// 7-segment module
	switch_7seg 7seg(s[3:0], seg);

	// multiplexing counter module to write outputs at a frequency
	muxCounter muxCounter(clk, reset, enable, s[4], seg, anodeLeft, anodeRight, segWrite);
	
	// assign statements to implement multiplexing and scanning
	assign leds = cols;



	
endmodule