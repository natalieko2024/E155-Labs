// Defining the delays in terms of ns with a precision of 1ns
`timescale 1 ns/1 ns

// Natalie Ko (nko@g.hmc.edu)
// Created on 18 Sept 2026
// Test all state transitions and outputs are correct
module keypadFSM_tb();

    logic clk, reset, displayEN;
    logic [15:0] keyMap;

    keypadFSM dut(clk, reset, keyMap, displayEN);

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

        // Testing if multi key pressed
        keyMap = 16'b0001000000000001;

        // Start at START
        assert(displayEN == 1'b0)
            $display("PASS output is correct at %t", $time);
        else
            $display("FAIL output is incorrect at %t", $time);
        #2

        // Keep at START
        assert(displayEN == 1'b0)
            $display("PASS output is correct at %t", $time);
        else
            $display("FAIL output is incorrect at %t", $time);
        
        // Testing if single key pressed
        keyMap = 16'b0000000000000001;
        #2

        // Go to DISPLAY
        assert(displayEN == 1'b1)
            $display("PASS output is correct at %t", $time);
        else
            $display("FAIL output is incorrect at %t", $time);
        #2

        // HOLD
        assert(displayEN == 1'b0)
            $display("PASS output is correct at %t", $time);
        else
            $display("FAIL output is incorrect at %t", $time);
        #2

        // Stay at HOLD
        assert(displayEN == 1'b0)
            $display("PASS output is correct at %t", $time);
        else
            $display("FAIL output is incorrect at %t", $time);
        
        // Multi key press
        keyMap = 16'b0001001000000001;
        #2

        // Go to MULTI
        assert(displayEN == 1'b0)
            $display("PASS output is correct at %t", $time);
        else
            $display("FAIL output is incorrect at %t", $time);
        #2

        // Stay at MULTI
        assert(displayEN == 1'b0)
            $display("PASS output is correct at %t", $time);
        else
            $display("FAIL output is incorrect at %t", $time);
        
        // key press is same as initial saved
        keyMap = 16'b0000000000000001;
        #2

        // Go to HOLD
        assert(displayEN == 1'b0)
            $display("PASS output is correct at %t", $time);
        else
            $display("FAIL output is incorrect at %t", $time);
        
        // multi press
        keyMap = 16'b0001100000000001;
        #2

        // Go to MULTI
        assert(displayEN == 1'b0)
            $display("PASS output is correct at %t", $time);
        else
            $display("FAIL output is incorrect at %t", $time);
        
        // single press that isnt initial
        keyMap = 16'b0000100000000000;
        #2

        // Go to DISPLAY
        assert(displayEN == 1'b1)
            $display("PASS output is correct at %t", $time);
        else
            $display("FAIL output is incorrect at %t", $time);
        #2

        // Go to HOLD
        assert(displayEN == 1'b0)
            $display("PASS output is correct at %t", $time);
        else
            $display("FAIL output is incorrect at %t", $time);
        
        //multi press
        keyMap = 16'b0000110000000000;
        #2

        // Go to MULTI
        assert(displayEN == 1'b0)
            $display("PASS output is correct at %t", $time);
        else
            $display("FAIL output is incorrect at %t", $time);
        
        // no keys held
        keyMap = 16'b0000000000000000;
        #2

        // Go to START
        assert(displayEN == 1'b0)
            $display("PASS output is correct at %t", $time);
        else
            $display("FAIL output is incorrect at %t", $time);
        
        // one key
        keyMap = 16'b0010000000000000;
        #2

        // Go to DISPLAY
        assert(displayEN == 1'b1)
            $display("PASS output is correct at %t", $time);
        else
            $display("FAIL output is incorrect at %t", $time);
        #2

        // Go to HOLD
        assert(displayEN == 1'b0)
            $display("PASS output is correct at %t", $time);
        else
            $display("FAIL output is incorrect at %t", $time);
        
        // no keys
        keyMap = 16'b0000000000000000;
        #2

        // Go to START
        assert(displayEN == 1'b0)
            $display("PASS output is correct at %t", $time);
        else
            $display("FAIL output is incorrect at %t", $time);

        // one key
        keyMap = 16'b0000000100000000;
        #2

        // Go to DISPLAY
        assert(displayEN == 1'b1)
            $display("PASS output is correct at %t", $time);
        else
            $display("FAIL output is incorrect at %t", $time);
        
        // toggle reset
        reset = 1'b0;
        #2

        // Go to START
        assert(displayEN == 1'b0)
            $display("PASS output is correct at %t", $time);
        else
            $display("FAIL output is incorrect at %t", $time);
        #2
        $stop;
    end

endmodule