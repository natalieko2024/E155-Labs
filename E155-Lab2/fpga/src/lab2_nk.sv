module lab2_nk();
	
	// Internal HSOSC to provide a 24MHz oscillation frequency output
	HSOSC #(.CLKHF_DIV("0b01")
		hf_osc(.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));
	
	// 7-segment module
	mux7seg mux7seg(s, anode, segLeft, segRight);
	
	// multiplexing counter module
	
	// scanning module
	scan scan(clk, reset, enable, rows);
	
	//assign statements to implement multiplexing and scanning
endmodule