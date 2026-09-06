`timescale 1 ns/1 ns

module lab1_nk_toposcillator_tb();
	logic clk;		// System clock
	logic reset;	// System reset
	logic [3:0] s;
	logic [2:0] led;		// Oscillating LED
	logic [6:0] seg;
	
	// Instantiate switch_7seg under test
	oscillator dut (reset, s, led, seg, clk);
	
	initial begin
		reset = 0;
		#22 reset = 1;

		// test 1 - testing LED after 0.5 new clock cycle, should have just turned on
		#208333350;
		assert (led[2] == 1)
			$display("PASS LED is on at time %t", $time);
		else
			$display("FAIL LED is off with reset on at time %t", $time);
			
		// test 2 - testing LED after 0.5 new clock cycle, should have just turned off
		#208333334;
		assert (led[2] == 0)
			$display("PASS LED is off at time %t", $time);
		else
			$display("FAIL LED is on at time %t", $time);
		
		
		// toggle reset at an irregular interval
		reset = 0;
		#40000;
		reset = 1;
		#40000;
		
		// test 3 - testing LED after 0.5 new clock cycle, should have just turned on
		#208333334;
		assert (led[2] == 1)
			$display("PASS LED is on after reset at time %t", $time);
		else
			$display("FAIL LED is off after reset at time %t", $time);
			
		// test 4 - testing LED after 0.5 new clock cycle, should have just turned off
		#208333334;
		assert (led[2] == 0)
			$display("PASS LED is off at time %t", $time);
		else
			$display("FAIL LED is on at time %t", $time);

		#100 $stop;
	end
	
endmodule