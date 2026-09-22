module keyMap(input clk, reset,
                input logic [3:0] rows, cols,
                output logic [15:0] keyMap,
                output logic [3:0] switches,
                output logic press);

	logic badClk, sample;
	logic [8:0] count;

	// Make the keymap
	flop #(4) readRow0(clk, reset, (rows[0] & sample), ~cols, keyMap[3:0]);
	flop #(4) readRow1(clk, reset, (rows[1] & sample), ~cols, keyMap[7:4]);
	flop #(4) readRow2(clk, reset, (rows[2] & sample), ~cols, keyMap[11:8]);
	flop #(4) readRow3(clk, reset, (rows[3] & sample), ~cols, keyMap[15:12]);

	// Sample during the period where a row is active
	freqconverter #(9, 500) countScan(clk, reset, 1'b1, badClk, count);
	assign sample = (count == 9'd200);

    // get switch equivalents and whether 
    always_comb begin
        case(keyMap)
            16'b1000000000000000: begin switches = 4'b0001; press = 1;end  // row[3] and col[3] = 1
            16'b0100000000000000: begin switches = 4'b0010; press = 1; end   // row[3] and col[2] = 2
            16'b0010000000000000: begin switches = 4'b0011; press = 1; end   // row[3] and col[1] = 3
            16'b0001000000000000: begin switches = 4'b1010; press = 1; end   // row[3] and col[0] = A
            16'b0000100000000000: begin switches = 4'b0100; press = 1; end   // row[2] and col[3] = 4
            16'b0000010000000000: begin switches = 4'b0101; press = 1; end   // row[2] and col[2] = 5
            16'b0000001000000000: begin switches = 4'b0110; press = 1; end   // row[2] and col[1] = 6
            16'b0000000100000000: begin switches = 4'b1011; press = 1; end   // row[2] and col[0] = B
            16'b0000000010000000: begin switches = 4'b0111; press = 1; end   // row[1] and col[3] = 7
            16'b0000000001000000: begin switches = 4'b1000; press = 1; end   // row[1] and col[2] = 8
            16'b0000000000100000: begin switches = 4'b1001; press = 1; end   // row[1] and col[1] = 9
            16'b0000000000010000: begin switches = 4'b1100; press = 1; end   // row[1] and col[0] = C
            16'b0000000000001000: begin switches = 4'b1110; press = 1; end   // row[0] and col[3] = E
            16'b0000000000000100: begin switches = 4'b0000; press = 1; end   // row[0] and col[2] = 0
            16'b0000000000000010: begin switches = 4'b1111; press = 1; end   // row[0] and col[1] = F
            16'b0000000000000001: begin switches = 4'b1101; press = 1; end   // row[0] and col[0] = D
			default: begin switches = 4'b0000; press = 0; end
        endcase
    end

endmodule


// s_next is next segment to write
// press is press signal on state machine -> only 1 key is pressed
// seven_seg_input module is the thing that shifts displays 