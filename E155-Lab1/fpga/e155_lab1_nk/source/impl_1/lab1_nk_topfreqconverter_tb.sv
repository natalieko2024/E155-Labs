// Defining the delays in terms of ns with a precision of 1ns
`timescale 1 ns/1 ns

// Natalie Ko (nko@g.hmc.edu)
// Created on 3 Sept 2026
// The module lab1_nk_topfreqconverter_tb is a testbench testing the connection of the freqconverter submodule to the top-level module. 
// Since the output signal of freqconverter is mapped to led[2] in the top-level, this tests whether led[2] is high or low at each half 2.4Hz clock cycle both before and after resetting at an irregular interval.
module lab1_nk_topfreqconverter_tb();
	logic clk;		// System clock
	logic reset;	// System reset
	logic [3:0] s;
	logic [2:0] led;		// Oscillating LED
	logic [6:0] seg;
	
	// Instantiate top level module under test
	lab1_nk dut (reset, s, led, seg, clk);
	
	initial begin
		// setup default conditions, reset toggles to off
		reset = 0;
		#22 reset = 1;

		// 1e9 ns per 2.4 blink cycles means about 208333334ns for 0.5 clock cycle
		// test 1 - testing LED at 0.5 new clock cycle, should have just turned on
		#208333334;
		assert (led[2] == 1)
			$display("PASS LED is on with enable at time %t", $time);
		else
			$display("FAIL LED is off with enable on at time %t", $time);
			
		// test 2 - testing LED at 0.5 new clock cycle, should have just turned off
		#208333334;
		assert (led[2] == 0)
			$display("PASS LED is off with enable at time %t", $time);
		else
			$display("FAIL LED is on with enable at time %t", $time);
		
		// toggle reset at an irregular interval
		reset = 0;
		#208333334;
		reset = 1;
		
		// test 3 - testing LED at 0.5 new clock cycle after reset, should have just turned on
		#208333334;
		assert (led[2] == 1)
			$display("PASS LED is on after reset with enable at time %t", $time);
		else
			$display("FAIL LED is off after reset with enable at time %t", $time);
			
		// test 4 - testing LED at 0.5 new clock cycle after reset, should have just turned off
		#208333334;
		assert (led[2] == 0)
			$display("PASS LED is off after reset with enable at time %t", $time);
		else
			$display("FAIL LED is on after reset with enable at time %t", $time);
			
			
		#100 $stop;
	end
	
endmodule