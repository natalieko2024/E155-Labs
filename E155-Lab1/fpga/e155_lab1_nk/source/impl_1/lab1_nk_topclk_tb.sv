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
		// if the new clock is successfully configured to 2.4Hz, I should see the clk signal at 1/2.4ns=417ps
		#417
		assert (clk)
			$display("PASS, clock signal is high at time %t", $time);
		else
			$display("FAIL, clock signal is low at time %t", $time);
		#600
		assert (~clk)
			$display("PASS, clock signal is high at time %t", $time);
		else
			$display("FAIL, clock signal is low at time %t", $time);
			
		#100 $stop;
	end
endmodule