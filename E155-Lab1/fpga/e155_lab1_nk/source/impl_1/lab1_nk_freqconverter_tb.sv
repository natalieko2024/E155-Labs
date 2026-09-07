// Defining the delays in terms of ns with a precision of 1ns
`timescale 1 ns/1 ns

// Natalie Ko (nko@g.hmc.edu)
// Created on 3 Sept 2026
// The module lab1_nk_freqconverter_tb is a testbench testing the counter logic of the freqconverter submodule. 
// This tests whether the output signal is high or low at regular intervals (determined by the max counter value set), the ability of reset to force 0 value to restart the counter, and the enable holding counter values at its current state. 
module lab1_nk_freqconverter_tb();
	logic clk;		// System clock
	logic reset;	// System reset
	logic enable;	// Counter enable
	logic led2;		// Oscillating LED
	
	// Instantiate freqconverter under test
	freqconverter #(.WIDTH(4), .MAX(10)) dut (clk, reset, enable, led2);
	
	// Generate clock, each clock cycle is 2ns
	always begin
		clk = 0; 
		#1;
		clk = 1;
		#1;
	end
	
	initial begin
		// setup default conditions, enable is on and reset toggles to off
		enable = 1;
		reset = 0;
		#4 reset = 1;
		#4

		// test 1 - testing LED at max count time, should have just turned on
		#24;	// slightly more than 20 to account for setup time after reset
		assert (led2 == 1)
			$display("PASS LED is on with enable at time %t", $time);
		else
			$display("FAIL LED is off with enable on at time %t", $time);
			
		// test 2 - testing LED at 2nd max count time, should have just turned off
		#20;
		assert (led2 == 0)
			$display("PASS LED is off with enable at time %t", $time);
		else
			$display("FAIL LED is on with enable at time %t", $time);
		
		// toggle reset at an irregular interval
		reset = 0;
		#10;
		reset = 1;
		#4
		
		// test 3 - testing LED at max count time after reset, should have just turned on
		#24;	// slightly more than 20 to account for setup time after reset
		assert (led2 == 1)
			$display("PASS LED is on after reset with enable at time %t", $time);
		else
			$display("FAIL LED is off after reset with enable at time %t", $time);
			
		// test 4 - testing LED at 2nd max count time after reset, should have just turned off
		#20;
		assert (led2 == 0)
			$display("PASS LED is off after reset with enable at time %t", $time);
		else
			$display("FAIL LED is on after reset with enable at time %t", $time);
		
		// Delay until next clock high, then toggle enable
		#30
		enable = 0;
		
		// test 5 - testing LED at max count time without enable, should constantly be off
		#20;
		assert (led2 == 1)
			$display("PASS LED is on without enable at time %t", $time);
		else
			$display("FAIL LED is off without enable at time %t", $time);
			
		// test 6 - testing LED at 2nd max count time without enable, should still constantly be off
		#20;
		assert (led2 == 1)
			$display("PASS LED is on without enable at time %t", $time);
		else
			$display("FAIL LED is off without enable at time %t", $time);
		
		
		// toggle reset at an irregular interval
		reset = 0;
		#10;
		reset = 1;
		#4
		
		// test 7 - testing LED at max count time after reset after enable, should set to constantly be off
		#24;	// slightly more than 20 to account for setup time after reset
		assert (led2 == 0)
			$display("PASS LED is off after reset without enable at time %t", $time);
		else
			$display("FAIL LED is on after reset without enable at time %t", $time);
			
		// test 8 - testing LED at 2nd max count time after reset after enable, should set to constantly be off
		#20;
		assert (led2 == 0)
			$display("PASS LED is off after reset without enable at time %t", $time);
		else
			$display("FAIL LED is on after reset without enable at time %t", $time);
	
		#10 $stop;
	end
	
endmodule