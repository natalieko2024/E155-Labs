module keyMap(input clk, reset,
                input logic [3:0] rows, cols,
                output logic [15:0] keyMap);

	logic badClk, sample0;
	logic [8:0] count;

	// Make the keymap
	flipFlop #(4) readRow0(clk, reset, (rows[0] & sample0), ~cols, keyMap[3:0]);
	flipFlop #(4) readRow1(clk, reset, (rows[1] & sample0), ~cols, keyMap[7:4]);
	flipFlop #(4) readRow2(clk, reset, (rows[2] & sample0), ~cols, keyMap[11:8]);
	flipFlop #(4) readRow3(clk, reset, (rows[3] & sample0), ~cols, keyMap[15:12]);

	// Sample during the period where a row is active
	freqconverter #(9, 125) countScan(clk, reset, 1'b1, badClk, count);
	assign sample0 = (count == 9'd100);
	
endmodule