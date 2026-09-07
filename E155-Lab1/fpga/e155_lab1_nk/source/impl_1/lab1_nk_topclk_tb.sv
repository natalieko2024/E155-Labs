`timescale 1 ns/1 ns

module lab1_nk_topclk_tb();
	logic clk;				// System clock
	logic reset;			// System reset
	logic [3:0] s;			// 4-bit input switches
	logic [2:0] led;		// LEDs
	logic [6:0] seg;		// 7-segment display output
	
	// Instantiate switch_7seg under test
	lab1_nk dut (reset, s, led, seg, clk);
	
	initial begin
		// if the new clock is successfully configured to 2.4Hz, I should see the clk signal every 1/2.4ns/2=208.5ps = about 21ns
		// Test 1 - testing if clk is actually off when it's supposed to be
		#21
		assert (~clk)
			$display("PASS, clock signal is low at time %t", $time);
		else
			$display("FAIL, clock signal is high at time %t", $time);
			
		// it will toggle on about 11ns after the low signal is first seen
		// Test 2 - testing if clk is actually on when it's supposed to be
		#11
		assert (clk)
			$display("PASS, clock signal is high at time %t", $time);
		else
			$display("FAIL, clock signal is low at time %t", $time);
			
		#10 $stop;
	end
endmodule