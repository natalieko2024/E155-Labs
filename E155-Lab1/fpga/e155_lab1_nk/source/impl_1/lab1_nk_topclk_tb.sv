// Defining the delays in terms of ns with a precision of 1ns
`timescale 1 ns/1 ns

// Natalie Ko (nko@g.hmc.edu)
// Created on 3 Sept 2026
// The module lab1_nk_topclk_tb is a testbench testing the output clock signal from the HSOSC in the top-level module
// This checkes if the clock signal is high and low when expected based on the 24MHz configuration of the HSOSC
module lab1_nk_topclk_tb();
	logic clk;				// System clock
	logic reset;			// System reset
	logic [3:0] s;			// 4-bit input switches
	logic [2:0] led;		// LEDs
	logic [6:0] seg;		// 7-segment display output
	
	// Instantiate switch_7seg under test
	lab1_nk dut (reset, s, led, seg, clk);
	
	initial begin
		#9		// Small delay to set up
		
		// if the HSOSC is successfully configured to 24MHz, I should see the clk signal change every (10^2)/2.4ns/2=20.83ns = about 21ns
		// Test 1 - testing if clk is actually on when it's supposed to be
		#21
		assert (clk)
			$display("PASS, clock signal is high at time %t", $time);
		else
			$display("FAIL, clock signal is low at time %t", $time);
			
		// Test 2 - testing if clk is actually off when it's supposed to be
		#21
		assert (~clk)
			$display("PASS, clock signal is low at time %t", $time);
		else
			$display("FAIL, clock signal is high at time %t", $time);
			
		#10 $stop;
	end
endmodule