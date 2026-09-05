`timescale 1 ns/1 ns

module lab1_nk_oscillator_tb();
	logic clk;		// System clock
	logic reset;	// System reset
	logic led2;		// Oscillating LED
	
	// Instantiate switch_7seg under test
	oscillator dut (clk, reset, led2);
	
	// Generate clock, each clock cycle is 2ns
	always begin
		clk = 0; 
		#1;
		clk = 1;
		#1;
	end
	
	initial begin
		reset = 0;
		#22 reset = 1;

		// test 1 - testing LED at max count time, should have just turned on
		#10000025;
		assert (led2 == 1)
			$display("PASS LED is on at time %t", $time);
		else
			$display("FAIL LED is off with reset on at time %t", $time);
			
		// test 2 - testing LED at 2nd max count time, should have just turned off
		#10000000;
		assert (led2 == 0)
			$display("PASS LED is off at time %t", $time);
		else
			$display("FAIL LED is on at time %t", $time);
		
		
		// toggle reset
		reset = 0;
		#40000;
		reset = 1;
		#40000;
		
		// test 3 - testing LED at max count time after reset, should have just turned on
		#10000000;
		assert (led2 == 1)
			$display("PASS LED is on after reset at time %t", $time);
		else
			$display("FAIL LED is off after reset at time %t", $time);
			
		// test 4 - testing LED at 2nd max count time after reset, should have just turned off
		#10000000;
		assert (led2 == 0)
			$display("PASS LED is off at time %t", $time);
		else
			$display("FAIL LED is on at time %t", $time);
	
		#100 $stop;
	end
	
endmodule