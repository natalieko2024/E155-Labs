// Natalie Ko (nko@g.hmc.edu)
// Created on 2 Sept 2026
// The module switch_7seg maps the switch inputs (s) to the 7 segment display.
module switch_7seg( input logic [3:0] s,
					output logic [6:0] seg );
		
	// Using a case statement to map segment ON/OFF. Because of the common anode, sending 1 will turn the segment off.
	always_comb
		case(s)
		//		   ABCDEFG	  (segment definitions)
		0: seg = 7'b0000001; // 0x0
		1: seg = 7'b1001111; // 0x1
		2: seg = 7'b0010010; // 0x2
		3: seg = 7'b0000110; // 0x3
		4: seg = 7'b1001100; // 0x4
		5: seg = 7'b0100100; // 0x5
		6: seg = 7'b0100000; // 0x6
		7: seg = 7'b0001111; // 0x7
		8: seg = 7'b0000000; // 0x8
		9: seg = 7'b0001100; // 0x9
		10: seg = 7'b0001000; // 0xa
		11: seg = 7'b1100000; // 0xb
		12: seg = 7'b0110001; // 0xc
		13: seg = 7'b1000010; // 0xd
		14: seg = 7'b0110000; // 0xe
		15: seg = 7'b0111000; // 0xf
		default: seg = 7'b1111111; // Default value, everything off
		endcase

endmodule