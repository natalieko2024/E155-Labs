module keyMap(input clk, reset,
                input logic [3:0] rows, cols,
                output logic [15:0] keyMap);

	// Make the keymap
	flop #(4) readRow0(clk, reset, (rows[0] & sample), ~cols, keyMap[3:0]);
	flop #(4) readRow1(clk, reset, (rows[1] & sample), ~cols, keyMap[7:4]);
	flop #(4) readRow2(clk, reset, (rows[2] & sample), ~cols, keyMap[11:8]);
	flop #(4) readRow3(clk, reset, (rows[3] & sample), ~cols, keyMap[15:12]);

	// Sample during the period where a row is active
	freqconverter #(9, 500) countScan(clk, reset, 1'b1, badClk, count);
	assign sample = (count == 9'd200);

endmodule


// s_next is next segment to write
// press is press signal on state machine -> only 1 key is pressed
// seven_seg_input module is the thing that shifts displays 