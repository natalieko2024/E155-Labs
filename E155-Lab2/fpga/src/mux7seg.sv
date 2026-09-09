module mux7seg(input logic [4:0] s,
			   output logic [1:0] anode,
			   output logic [6:0] segLeft, segRight);

	always_comb
		if (s[0]) begin
			anode[1] = 1;
			anode[0] = 0;
			case(s)
				//		   ABCDEFG	  (segment definitions)
				0: segLeft = 7'b0000001; // 0x0
				1: segLeft = 7'b1001111; // 0x1
				2: segLeft = 7'b0010010; // 0x2
				3: segLeft = 7'b0000110; // 0x3
				4: segLeft = 7'b1001100; // 0x4
				5: segLeft = 7'b0100100; // 0x5
				6: segLeft = 7'b0100000; // 0x6
				7: segLeft = 7'b0001111; // 0x7
				8: segLeft = 7'b0000000; // 0x8
				9: segLeft = 7'b0001100; // 0x9
				10: segLeft = 7'b0001000; // 0xa
				11: segLeft = 7'b1100000; // 0xb
				12: segLeft = 7'b0110001; // 0xc
				13: segLeft = 7'b1000010; // 0xd
				14: segLeft = 7'b0110000; // 0xe
				15: segLeft = 7'b0111000; // 0xf
				default: segLeft = 7'b1111111; // Default value, everything off
			endcase
		end
		else begin
			anode[1] = 0;
			anode[0] = 1;
			case(s)
				//		   ABCDEFG	  (segment definitions)
				0: segRight = 7'b0000001; // 0x0
				1: segRight = 7'b1001111; // 0x1
				2: segRight = 7'b0010010; // 0x2
				3: segRight = 7'b0000110; // 0x3
				4: segRight = 7'b1001100; // 0x4
				5: segRight = 7'b0100100; // 0x5
				6: segRight = 7'b0100000; // 0x6
				7: segRight = 7'b0001111; // 0x7
				8: segRight = 7'b0000000; // 0x8
				9: segRight = 7'b0001100; // 0x9
				10: segRight = 7'b0001000; // 0xa
				11: segRight = 7'b1100000; // 0xb
				12: segRight = 7'b0110001; // 0xc
				13: segRight = 7'b1000010; // 0xd
				14: segRight = 7'b0110000; // 0xe
				15: segRight = 7'b0111000; // 0xf
				default: segRight = 7'b1111111; // Default value, everything off
			endcase
		end

endmodule