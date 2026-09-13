// Defining the delays in terms of ns with a precision of 1ns
`timescale 1 ns/1 ns

// Natalie Ko (nko@g.hmc.edu)
// Created on 12 Sept 2026
// The module lab2_nk_tb is a testbench testing the multiplexing and LED driving functionalities 
module lab2_nk_tb();
	logic reset;
	logic [7:0] s;
	logic [3:0] cols;
	logic anodeLeft;
	logic anodeRight;
	logic [6:0] segWrite;
	logic [3:0] rows;
	logic [3:0] leds;
	
	lab2_nk dut (reset, s, cols, anodeLeft, anodeRight, segWrite, rows, leds);
	
	//assert cols = 0 and see if leds work when row is 1
	initial begin
		reset = 0;
		#4 reset = 1;
		#4
		s = 8'b00000000;
		// test 1 - testing rows at 1/8 clock cycle
		assert (segWrite == 4'b0000)
			$display("PASS row outputs are correct with enable at time %t", $time);
		else
			$display("FAIL row outputs are incorrect with enable at time %t", $time);
			
		// go through all of the switch inputs
		//assert cols = 0 for each one and show led output
		#1000000000 $stop;
	end
	
endmodule