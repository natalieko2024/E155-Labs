// Defining the delays in terms of ns with a precision of 1ns
`timescale 1 ns/1 ns

// Natalie Ko (nko@g.hmc.edu)
// Created on 12 Sept 2026
// The module scan_tb is a testbench testing the bit-shifting behaviour for the row output. 
// This tests whether the row signal is as expected during normal operation, after a reset, and with/without enable. 
module scan_tb();
	logic clk;		// System clock
	logic reset;	// System reset
	logic enable;	// Counter enable
	logic [3:0] rows;		// Oscillating row output
	
	// Instantiate freqconverter under test
	scan dut (clk, reset, enable, rows);
	
	// Generate clock, each clock cycle is 2ns
    // This means the stepped down clock (1Hz) will have a cycle time of 
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

		// test 1 - testing rows at 1/8 clock cycle
		assert (rows == 4'b1000)
			$display("PASS row outputs are correct with enable at time %t", $time);
		else
			$display("FAIL row outputs are incorrect with enable at time %t", $time);
			
		// test 2 - testing rows at 2/8 clock cycle
		#6000000;
		assert (rows == 4'b0100)
			$display("PASS row outputs are correct with enable at time %t", $time);
		else
			$display("FAIL row outputs are incorrect with enable at time %t", $time);
		
        // test 3 - testing rows at 3/8 clock cycle
        #6000000;
		assert (rows == 4'b0010)
			$display("PASS row outputs are correct with enable at time %t", $time);
		else
			$display("FAIL row outputs are incorrect with enable at time %t", $time);

        // test 4 - testing rows at 4/8 clock cycle
        #6000000;
		assert (rows == 4'b0001)
			$display("PASS row outputs are correct with enable at time %t", $time);
		else
			$display("FAIL row outputs are incorrect with enable at time %t", $time);

		// toggle reset at an irregular interval
		reset = 0;
		#100000;
		reset = 1;
		#4z
		
		// test 5 - testing rows at 1/8 clock cycle
		assert (rows == 4'b1000)
			$display("PASS row outputs are correct with enable after reset at time %t", $time);
		else
			$display("FAIL row outputs are incorrect with enable after reset at time %t", $time);
			
		// test 6 - testing rows at 2/8 clock cycle
		#6000000;
		assert (rows == 4'b0100)
			$display("PASS row outputs are correct with enable after reset at time %t", $time);
		else
			$display("FAIL row outputs are incorrect with enable after reset at time %t", $time);
		
        // test 7 - testing rows at 3/8 clock cycle
        #6000000;
		assert (rows == 4'b0010)
			$display("PASS row outputs are correct with enable after reset at time %t", $time);
		else
			$display("FAIL row outputs are incorrect with enable after reset at time %t", $time);

        // test 8 - testing rows at 4/8 clock cycle
        #6000000;
		assert (rows == 4'b0001)
			$display("PASS row outputs are correct with enable after reset at time %t", $time);
		else
			$display("FAIL row outputs are incorrect with enable after reset at time %t", $time);
		
		// Toggle enable, rows should stay the same as output of 4/8 clock cycle
		enable = 0;
        #30
		
		// test 9 - testing rows at 1/8 clock cycle
		#6000000;	
		assert (rows == 4'b0001)
			$display("PASS row outputs are correct without enable at time %t", $time);
		else
			$display("FAIL row outputs are incorrect without enable at time %t", $time);
			
		// test 10 - testing rows at 2/8 clock cycle
		#6000000;
		assert (rows == 4'b0001)
			$display("PASS row outputs are correct without enable at time %t", $time);
		else
			$display("FAIL row outputs are incorrect without enable at time %t", $time);
		
		// toggle reset at an irregular interval
		reset = 0;
		#1000;
		reset = 1;
		#4
		
		// test 11 - testing rows at 1/8 clock cycle
		#6000000;	
		assert (rows == 4'b1000)
			$display("PASS row outputs are correct without enable after reset at time %t", $time);
		else
			$display("FAIL row outputs are incorrect without enable after reset at time %t", $time);
			
		// test 12 - testing rows at 2/8 clock cycle
		#6000000;
		assert (rows == 4'b1000)
			$display("PASS row outputs are correct without enable after reset at time %t", $time);
		else
			$display("FAIL row outputs are incorrect without enable after reset at time %t", $time);
	
		#10 $stop;
	end
	
endmodule