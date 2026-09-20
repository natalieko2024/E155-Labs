module findHighBit(input logic [15:0] map,
					output logic [4:0] position);

	always_comb begin
		
		case(map)
			16'b1000000000000000: position = 15;
			16'b0100000000000000: position = 14;
			16'b0010000000000000: position = 13;
			16'b0001000000000000: position = 12;
			16'b0000100000000000: position = 11;
			16'b0000010000000000: position = 10;
			16'b0000001000000000: position = 9;
			16'b0000000100000000: position = 8;
			16'b0000000010000000: position = 7;
			16'b0000000001000000: position = 6;
			16'b0000000000100000: position = 5;
			16'b0000000000010000: position = 4;
			16'b0000000000001000: position = 3;
			16'b0000000000000100: position = 2;
			16'b0000000000000010: position = 1;
			16'b0000000000000001: position = 0;
			default: position = 0;
		endcase
		
	end

    //assign cols[0] = (map[0] | map[4] | map[8] | map[12]);
    //assign cols[1] = (map[1] | map[5] | map[9] | map[13]);
    //assign cols[2] = (map[2] | map[6] | map[10] | map[14]);
    //assign cols[3] = (map[3] | map[7] | map[11] | map[15]);
	
	//assign rows[0] = (map[3] | map[2] | map[1] | map[0]);
	//assign rows[1] = (map[7] | map[6] | map[5] | map[4]);
	//assign rows[2] = (map[11] | map[10] | map[9] | map[8]);
	//assign rows[3] = (map[15] | map[14] | map[13] | map[12]);
    
endmodule