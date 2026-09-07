// Defining the delays in terms of ns with a precision of 1ns
`timescale 1 ns/1 ns

// Natalie Ko (nko@g.hmc.edu)
// Created on 3 Sept 2026
// The module lab1_nk_topdiodelogic_tb is a testbench testing the LED combinational logic at the top level and the connection between the top-level module and the 7-segment submodule.
// This tests whether the output signals of the combinational logic of the LEDs and the 7-segment at the top-level match the expected outputs based on the 4 switch inputs.
module lab1_nk_topdiodelogic_tb();
	logic clk;				// System clock
	logic reset;			// System reset
	logic [3:0] s;			// 4-bit input switches
	logic [2:0] led;		// LEDs
	logic [6:0] seg;		// 7-segment display output
	
	// Instantiate lab1_nk under test
	lab1_nk dut (reset, s, led, seg, clk);
	
	initial begin
		// test 1 - testing LED 1 and LED 0 and 7-segment output with switches set to 0000
		s = 4'b0000;
		#10;
		assert ((led[1] == 0) && (led[0] == 0))
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		
		assert (seg == 7'b0000001)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
		
		// test 2 - testing LED 1 and LED 0 and 7-segment output with  switches set to 0001
		s = 4'b0001;
		#10;
		assert ((led[1] == 0) && (led[0] == 1))
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
			
		assert (seg == 7'b1001111)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
			
		// test 3 - testing LED 1 and LED 0 and 7-segment output with  switches set to 0010
		s = 4'b0010;
		#10;
		assert ((led[1] == 0) && (led[0] == 1))
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		
		assert (seg == 7'b0010010)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
			
		// test 4 - testing LED 1 and LED 0 and 7-segment output with  switches set to 0011
		s = 4'b0011;
		#10;
		assert ((led[1] == 0) && (led[0] == 0))
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		
		assert (seg == 7'b0000110)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
		
		// test 5 - testing LED 1 and LED 0 and 7-segment output with  switches set to 0100
		s = 4'b0100;
		#10;
		assert ((led[1] == 0) && (led[0] == 0))
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		
		assert (seg == 7'b1001100)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
		
		// test 6 - testing LED 1 and LED 0 and 7-segment output with  switches set to 0101
		s = 4'b0101;
		#10;
		assert ((led[1] == 0) && (led[0] == 1))
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		
		assert (seg == 7'b0100100)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
		
		// test 7 - testing LED 1 and LED 0 and 7-segment output with  switches set to 0110
		s = 4'b0110;
		#10;
		assert ((led[1] == 0) && (led[0] == 1))
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
			
		assert (seg == 7'b0100000)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
		
		// test 8 - testing LED 1 and LED 0 and 7-segment output with  switches set to 0111
		s = 4'b0111;
		#10;
		assert ((led[1] == 0) && (led[0] == 0))
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
			
		assert (seg == 7'b0001111)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
		
		// test 9 - testing LED 1 and LED 0 and 7-segment output with  switches set to 1000
		s = 4'b1000;
		#10;
		assert ((led[1] == 0) && (led[0] == 0))
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
			
		assert (seg == 7'b0000000)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
		
		// test 10 - testing LED 1 and LED 0 and 7-segment output with  switches set to 1001
		s = 4'b1001;
		#10;
		assert ((led[1] == 0) && (led[0] == 1))
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
			
		assert (seg == 7'b0001100)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
		
		// test 11 - testing LED 1 and LED 0 and 7-segment output with  switches set to 1010
		s = 4'b1010;
		#10;
		assert ((led[1] == 0) && (led[0] == 1))
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
			
		assert (seg == 7'b0001000)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
		
		// test 12 - testing LED 1 and LED 0 and 7-segment output with  switches set to 1011
		s = 4'b1011;
		#10;
		assert ((led[1] == 0) && (led[0] == 0))
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
			
		assert (seg == 7'b1100000)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
		
		// test 13 - testing LED 1 and LED 0 and 7-segment output with  switches set to 1100
		s = 4'b1100;
		#10;
		assert ((led[1] == 1) && (led[0] == 0))
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
			
		assert (seg == 7'b0110001)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
		
		// test 14 - testing LED 1 and LED 0 and 7-segment output with  switches set to 1101
		s = 4'b1101;
		#10;
		assert ((led[1] == 1) && (led[0] == 1))
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
			
		assert (seg == 7'b1000010)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
		
		// test 15 - testing LED 1 and LED 0 and 7-segment output with  switches set to 1110
		s = 4'b1110;
		#10;
		assert ((led[1] == 1) && (led[0] == 1))
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
			
		assert (seg == 7'b0110000)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
		
		// test 16 - testing LED 1 and LED 0 and 7-segment output with  switches set to 1111
		s = 4'b1111;
		#10;
		assert ((led[1] == 1) && (led[0] == 0))
			$display("PASS, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
		else
			$display("FAIL, led[1] is %b and led[0] is %b for switches %b", led[1], led[0], s);
			
		assert (seg == 7'b0111000)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);

		#10 $stop;
	end
endmodule