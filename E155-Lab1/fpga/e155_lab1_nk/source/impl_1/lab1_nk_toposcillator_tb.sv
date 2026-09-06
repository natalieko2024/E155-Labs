`timescale 1 ns/1 ns

module lab1_nk_toposcillator_tb();
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

		// test 1 - testing LED at 0.5 new clock cycle, should have just turned on
		#104166667;
		assert (led[2] == 1)
			$display("PASS LED is on with enable at time %t", $time);
		else
			$display("FAIL LED is off with enable on at time %t", $time);
			
		// test 2 - testing LED at 0.5 new clock cycle, should have just turned off
		#104166667;
		assert (led[2] == 0)
			$display("PASS LED is off with enable at time %t", $time);
		else
			$display("FAIL LED is on with enable at time %t", $time);
		
		// toggle reset at an irregular interval
		reset = 0;
		#40000;
		reset = 1;
		#40000;
		
		// test 3 - testing LED at 0.5 new clock cycle after reset, should have just turned on
		#104166667;
		assert (led[2] == 1)
			$display("PASS LED is on after reset with enable at time %t", $time);
		else
			$display("FAIL LED is off after reset with enable at time %t", $time);
			
		// test 4 - testing LED at 0.5 new clock cycle after reset, should have just turned off
		#104166667;
		assert (led[2] == 0)
			$display("PASS LED is off after reset with enable at time %t", $time);
		else
			$display("FAIL LED is on after reset with enable at time %t", $time);
		
		#100 $stop;
	end
	
endmodule