module findHighBit(input logic [15:0] map,
					output logic [3:0] position);

	always_comb begin
		
		case(map)
			16'b1000000000000000: position = 4'b1111;
			16'b0100000000000000: position = 4'b1110;
			16'b0010000000000000: position = 4'b1101;
			16'b0001000000000000: position = 4'b1100;
			16'b0000100000000000: position = 4'b1011;
			16'b0000010000000000: position = 4'b1010;
			16'b0000001000000000: position = 4'b1001;
			16'b0000000100000000: position = 4'b1000;
			16'b0000000010000000: position = 4'b0111;
			16'b0000000001000000: position = 4'b0110;
			16'b0000000000100000: position = 4'b0101;
			16'b0000000000010000: position = 4'b0100;
			16'b0000000000001000: position = 4'b0011;
			16'b0000000000000100: position = 4'b0010;
			16'b0000000000000010: position = 4'b0001;
			16'b0000000000000001: position = 4'b0000;
			default: position = 0;
		endcase
		
	end