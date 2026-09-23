// Defining the delays in terms of ns with a precision of 1ns
`timescale 1 ns/1 ns

module debounced_tb();

    logic clk, reset;
    logic [15:0] keyMap, debouncedKeyMap;

    debouncer dut(clk, reset, keyMap, debouncedKeyMap);

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

        // bouncing
        keyMap = 16'b1010101010101010;
        #1
        keyMap = 16'b1000100010001000;
        #1
        keyMap = 16'b1010101010101010;
        #1
        keyMap = 16'b1000100010001000;
        #1
        keyMap = 16'b1010101010101010;
        #1
        keyMap = 16'b1000100010001000;
        #1
        keyMap = 16'b1010101010101010;
        #1
        keyMap = 16'b1000100010001000;
        #1
        keyMap = 16'b1010101010101010;
        #1
        keyMap = 16'b1000100010001000;
        #1
        keyMap = 16'b1010101010101010;
        #1
        keyMap = 16'b1000100010001000;
        #1
        keyMap = 16'b1010101010101010;
        #1
        
        // stop bouncing
        keyMap = 16'b1000100010001000;
        #18
        assert(debouncedKeyMap == 16'b1000100010001000)
            $display("PASS output is debounced at %t", $time);
        else
            $display("FAIL output is not debounced at %t", $time);
        #2

        // toggle reset
        reset = 1'b0;
        #4

        // bouncing
        keyMap = 16'b1010101010101010;
        #1
        keyMap = 16'b1000100010001000;
        #1
        keyMap = 16'b1010101010101010;
        #1
        keyMap = 16'b1000100010001000;
        #1
        keyMap = 16'b1010101010101010;
        #1
        keyMap = 16'b1000100010001000;
        #1
        keyMap = 16'b1010101010101010;
        #1
        keyMap = 16'b1000100010001000;
        #1
        keyMap = 16'b1010101010101010;
        #1
        keyMap = 16'b1000100010001000;
        #1
        keyMap = 16'b1010101010101010;
        #1
        keyMap = 16'b1000100010001000;
        #1
        keyMap = 16'b1010101010101010;
        #18

        assert(debouncedKeyMap == 16'b0000000000000000)
            $display("PASS output is not debounced after reset at %t", $time);
        else
            $display("FAIL output is still debounced at %t", $time);
        #2

    end

endmodule