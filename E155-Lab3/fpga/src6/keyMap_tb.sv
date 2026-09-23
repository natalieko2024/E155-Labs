// Defining the delays in terms of ns with a precision of 1ns
`timescale 1 ns/1 ns

// Natalie Ko (nko@g.hmc.edu)
// Created on 18 Sept 2026
// Testing inputs are added to keymap
module keyMap_tb();
    
    logic clk, reset;
    logic [3:0] rows, cols;
    logic [15:0] keyMap;

    keyMap dut(clk, reset, rows, cols, keyMap);

    always begin
		clk = 0; 
		#1;
		clk = 1;
		#1;
	end

    initial begin
        reset = 1'b0;
        #4
        reset = 1'b1; 

        rows = 4'b1000;
        cols = 4'b1101;
        #210
        assert(keyMap == 16'b0010000000000000)
            $display("PASS keyMap is correct at %t", $time);
        else
            $display("FAIL keyMap is incorrect at %t", $time);

        rows = 4'b0100;
        cols = 4'b1011;
        #250
        assert(keyMap == 16'b0010010000000000)
            $display("PASS keyMap is correct at %t", $time);
        else
            $display("FAIL keyMap is incorrect at %t", $time);

        rows = 4'b0010;
        cols = 4'b0111;
        #250
        assert(keyMap == 16'b0010010010000000)
            $display("PASS keyMap is correct at %t", $time);
        else
            $display("FAIL keyMap is incorrect at %t", $time);

        rows = 4'b0001;
        cols = 4'b0101;
        #250
        assert(keyMap == 16'b0010010010001010)
            $display("PASS keyMap is correct at %t", $time);
        else
            $display("FAIL keyMap is incorrect at %t", $time);

        //overwrite first row saved
        rows = 4'b1000;
        cols = 4'b0101;
        #250
        assert(keyMap == 16'b1010010010001010)
            $display("PASS keyMap is correct at %t", $time);
        else
            $display("FAIL keyMap is incorrect at %t", $time);
        #250

        // toggle reset
        reset = 1'b0;
        #4
        assert(keyMap == 16'b0000000000000000)
            $display("PASS keyMap is reset at %t", $time);
        else
            $display("FAIL keyMap is not reset at %t", $time);
		#250 $stop;
    end

endmodule