`timescale 1 ns/1 ns

// Natalie Ko (nko@g.hmc.edu)
// Created on 3 Sept 2026
// The module lab1_nk_switch7seg_tb is a testbench testing the combinational logic of the switch_7seg submodule. 
// This tests whether the 7-segment outputs align as expected based on the 4 switch inputs.
module lab1_nk_switch7seg_tb();
	logic [3:0] s;			// 4-bit input switches
	logic [6:0] seg;		// 7-segment display output
	
	// Instantiate switch_7seg under test
	switch_7seg dut (s, seg);
	
	// Start of test
	initial begin
		// test 1 - testing 7-segment output for switches set to 0000
		s = 4'b0000;
		#10;
		assert (seg == 7'b0000001)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
			
		// test 2 - testing 7-segment output for switches set to 0001
		s = 4'b0001;
		#10;
		assert (seg == 7'b1001111)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
		
		// test 3 - testing 7-segment output for switches set to 0010
		s = 4'b0010;
		#10;
		assert (seg == 7'b0010010)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
			
		// test 4 - testing 7-segment output for switches set to 0011
		s = 4'b0011;
		#10;
		assert (seg == 7'b0000110)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
			
		// test 5 - testing 7-segment output for switches set to 0100
		s = 4'b0100;
		#10;
		assert (seg == 7'b1001100)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
			
		// test 6 - testing 7-segment output for switches set to 0101
		s = 4'b0101;
		#10;
		assert (seg == 7'b0100100)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
			
		// test 7 - testing 7-segment output for switches set to 0110
		s = 4'b0110;
		#10;
		assert (seg == 7'b0100000)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
			
		// test 8 - testing 7-segment output for switches set to 0111
		s = 4'b0111;
		#10;
		assert (seg == 7'b0001111)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
			
		// test 9 - testing 7-segment output for switches set to 1000
		s = 4'b1000;
		#10;
		assert (seg == 7'b0000000)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
			
		// test 10 - testing 7-segment output for switches set to 1001
		s = 4'b1001;
		#10;
		assert (seg == 7'b0001100)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
			
		// test 11 - testing 7-segment output for switches set to 1010
		s = 4'b1010;
		#10;
		assert (seg == 7'b0001000)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
			
		// test 12 - testing 7-segment output for switches set to 1011
		s = 4'b1011;
		#10;
		assert (seg == 7'b1100000)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
			
		// test 13 - testing 7-segment output for switches set to 1100
		s = 4'b1100;
		#10;
		assert (seg == 7'b0110001)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
			
		// test 14 - testing 7-segment output for switches set to 1101
		s = 4'b1101;
		#10;
		assert (seg == 7'b1000010)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
			
		// test 15 - testing 7-segment output for switches set to 1110
		s = 4'b1110;
		#10;
		assert (seg == 7'b0110000)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
			
		// test 16 - testing 7-segment output for switches set to 1111
		s = 4'b1111;
		#10;
		assert (seg == 7'b0111000)
			$display("PASS, 7 segment output correct for switches %b", s);
		else
			$display("FAIL, switch to 7 segment not mapped correctly for switches %b", s);
	
		#10 $stop;
	end
endmodule