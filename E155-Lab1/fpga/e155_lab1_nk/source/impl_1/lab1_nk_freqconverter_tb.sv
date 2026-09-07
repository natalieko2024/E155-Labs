`timescale 1 ns/1 ns

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

		// test 1 - testing LED at max count time, should have just turned on
		#28;
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
		#4;
		reset = 1;
		#4;
		
		// test 3 - testing LED at max count time after reset, should have just turned on
		#28;
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
			
		// toggle enable
		enable = 0;
		#4
		
		// test 5 - testing LED at max count time without enable, should constantly be off
		#20;
		assert (led2 == 0)
			$display("PASS LED is off without enable at time %t", $time);
		else
			$display("FAIL LED is on without enable at time %t", $time);
			
		// test 6 - testing LED at 2nd max count time without enable, should still constantly be off
		#20;
		assert (led2 == 0)
			$display("PASS LED is off without enable at time %t", $time);
		else
			$display("FAIL LED is on without enable at time %t", $time);
		
		
		// toggle reset at an irregular interval
		reset = 0;
		#4;
		reset = 1;
		#4;
		
		// test 7 - testing LED at max count time after reset without enable, should still constantly be off
		#28;
		assert (led2 == 0)
			$display("PASS LED is off after reset without enable at time %t", $time);
		else
			$display("FAIL LED is on after reset without enable at time %t", $time);
			
		// test 8 - testing LED at 2nd max count time after reset without enable, should still constantly be off
		#20;
		assert (led2 == 0)
			$display("PASS LED is off after reset without enable at time %t", $time);
		else
			$display("FAIL LED is on after reset without enable at time %t", $time);
	
		#10 $stop;
	end
	
endmodule