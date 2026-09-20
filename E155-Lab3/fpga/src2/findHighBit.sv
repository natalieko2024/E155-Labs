module findHighBit(input logic [15:0] map,
					output logic [4:0] position);

	always_comb begin
		
		case(map)
			16'b1000000000000000: position = 5'b01111;
			16'b0100000000000000: position = 5'b01110;
			16'b0010000000000000: position = 5'b01101;
			16'b0001000000000000: position = 5'b01100;
			16'b0000100000000000: position = 5'b01011;
			16'b0000010000000000: position = 5'b01010;
			16'b0000001000000000: position = 5'b01001;
			16'b0000000100000000: position = 5'b01000;
			16'b0000000010000000: position = 5'b00111;
			16'b0000000001000000: position = 5'b00110;
			16'b0000000000100000: position = 5'b00101;
			16'b0000000000010000: position = 5'b00100;
			16'b0000000000001000: position = 5'b00011;
			16'b0000000000000100: position = 5'b00010;
			16'b0000000000000010: position = 5'b00001;
			16'b0000000000000001: position = 5'b00000;
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