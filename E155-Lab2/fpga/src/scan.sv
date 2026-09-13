// Natalie Ko (nko@g.hmc.edu)
// Created on 8 Sept 2026
// The module scan steps down the 24MHz HSOSC clock signal to 1Hz and sets the bits of the scanning signal so each bit of the row output oscillates every 2Hz.
module scan(input logic clk, reset, enable,
			output logic [3:0] rows);
		
	logic stepDownClk;
	logic [23:0] countUp;
	
	// Use my counter module to step down 24MHz to 1Hz
	freqconverter #(.WIDTH(24), .MAX(12000000)) counter(clk, reset, enable, stepDownClk, countUp);
	
	// Assign statements based on the counter output to shift the bits of rows every 1/8 clock cycle so they end up oscillating at 2Hz
	assign rows[3] = (countUp >= 0) && (countUp <= 2999999);
	assign rows[2] = (countUp >= 3000000) && (countUp <= 5999999);
	assign rows[1] = (countUp >= 6000000) && (countUp <= 8999999);
	assign rows[0] = (countUp >= 9000000) && (countUp <= 11999999);
	
endmodule