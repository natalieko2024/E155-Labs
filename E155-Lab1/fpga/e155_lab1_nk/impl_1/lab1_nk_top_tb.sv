`timescale 1 ns/1 ns

module lab1_nk_top_tb();
	logic clk;				// System clock
	logic reset;			// System reset
	logic [3:0] s;			// 4-bit input switches
	logic [2:0] led;		// LEDs
	logic [6:0] seg;		// 7-segment display output
	
	// Instantiate switch_7seg under test
	lab1_nk dut (reset, s, led, seg. clk);
	
	initial begin
		// test 1 - testing switches set to 0000
		s = 4'b0000;
		#10;
		assert (led == 3'bx00)
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		
		// test 2 - testing switches set to 0001
		s = 4'b0001;
		#10;
		assert (led == 3'bx01)
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
			
		// test 3 - testing switches set to 0010
		s = 4'b0010;
		#10;
		assert (led == 3'bx01)
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		
		// test 4 - testing switches set to 0011
		s = 4'b0011;
		#10;
		assert (led == 3'bx00)
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		
		// test 5 - testing switches set to 0100
		s = 4'b0100;
		#10;
		assert (led == 3'bx00)
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		
		// test 6 - testing switches set to 0101
		s = 4'b0101;
		#10;
		assert (led == 3'bx01)
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		
		// test 7 - testing switches set to 0110
		s = 4'b0110;
		#10;
		assert (led == 3'bx01)
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		
		// test 8 - testing switches set to 0111
		s = 4'b0111;
		#10;
		assert (led == 3'bx00)
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		
		// test 9 - testing switches set to 1000
		s = 4'b1000;
		#10;
		assert (led == 3'bx00)
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		
		// test 10 - testing switches set to 1001
		s = 4'b1001;
		#10;
		assert (led == 3'bx01)
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		
		// test 11 - testing switches set to 1010
		s = 4'b1010;
		#10;
		assert (led == 3'bx01)
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		
		// test 12 - testing switches set to 1011
		s = 4'b1011;
		#10;
		assert (led == 3'bx00)
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		
		// test 13 - testing switches set to 1100
		s = 4'b1100;
		#10;
		assert (led == 3'bx10)
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		
		// test 14 - testing switches set to 1101
		s = 4'b1101;
		#10;
		assert (led == 3'bx11)
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		
		// test 15 - testing switches set to 1110
		s = 4'b1110;
		#10;
		assert (led == 3'bx11)
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		
		// test 16 - testing switches set to 1111
		s = 4'b1111;
		#10;
		assert (led == 3'bx10)
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		
	end
	
endmodule