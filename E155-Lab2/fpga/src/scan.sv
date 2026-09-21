// Natalie Ko (nko@g.hmc.edu)
// Created on 8 Sept 2026
// The module scan steps down the 24MHz HSOSC clock signal to 1Hz and sets the bits of the scanning signal so each bit of the row output oscillates every 2Hz.
module scan #(parameter COUNTWIDTH = 24, COUNTMAX = 12000000) (input logic clk, reset, enable,
																output logic [3:0] rows);
		
	logic stepDownClk;
	logic [COUNTWIDTH+3-1:0] countUp;
	
	// Use my counter module to step down 24MHz to 1Hz
	freqconverter #(.WIDTH(COUNTWIDTH+3), .MAX(COUNTMAX)) counter(clk, reset, enable, stepDownClk, countUp);
	
	// Assign statements based on the counter output to shift the bits of rows every 1/8 clock cycle so they end up oscillating at 2Hz
	assign rows[3] = (countUp >= 0) && (countUp <= ((COUNTMAX >> 2)-1));
	assign rows[2] = (countUp >= (COUNTMAX >> 2)) && (countUp <= (((COUNTMAX << 1) >> 2)-1));
	assign rows[1] = (countUp >= ((COUNTMAX << 1) >> 2) && (countUp <= ((((COUNTMAX << 1) + COUNTMAX) >> 2)-1)));
	assign rows[0] = (countUp >= (((COUNTMAX << 1) + COUNTMAX) >> 2) && (countUp <= (COUNTMAX-1)));

endmodule