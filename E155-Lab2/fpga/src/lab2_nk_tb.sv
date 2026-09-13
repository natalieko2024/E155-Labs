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
		#1000 reset = 1;

		// test 1 - testing mux behaviour
		s = 8'b00001111;
		#10
		assert (segWrite == 7'b0111000)
			$display("PASS left segments are correct at time %t", $time);
		else
			$display("FAIL left segments are incorrect at time %t", $time);
		#8333334 	// this is how long the 120Hz clock should take
		assert (segWrite == 7'b0000001)
			$display("PASS right segments are correct at at time %t", $time);
		else
			$display("FAIL right segments are incorrect at at time %t", $time);

		// test 2 - testing column input to LED output
		cols = 4'b0000;
		#8333334
		assert (leds == 4'b1111)
			$display("PASS leds are inverted columns at time %t", $time);
		else
			$display("FAIL leds are incorrect at time %t", $time);

		cols = 4'b1010;
		#8333334
		assert (leds == 4'b0101)
			$display("PASS leds are inverted columns at time %t", $time);
		else
			$display("FAIL leds are incorrect at time %t", $time);

		//assert cols = 0 for each one and show led output
		#100 $stop;
	end
	
endmodule