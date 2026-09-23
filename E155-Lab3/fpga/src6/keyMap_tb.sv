// Defining the delays in terms of ns with a precision of 1ns
`timescale 1 ns/1 ns

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
        cols = 4'b0010;
        #200
        assert(keyMap == 16'0010000000000000)
            $display("PASS keyMap is correct at %t", $time);
        else
            $display("FAIL keyMap is incorrect at %t", $time);

        rows = 4'b0100;
        cols = 4'b0100;
        #200
        assert(keyMap == 16'0010010000000000)
            $display("PASS keyMap is correct at %t", $time);
        else
            $display("FAIL keyMap is incorrect at %t", $time);

        rows = 4'b0010;
        cols = 4'b1000;
        #200
        assert(keyMap == 16'0010010010000000)
            $display("PASS keyMap is correct at %t", $time);
        else
            $display("FAIL keyMap is incorrect at %t", $time);

        rows = 4'b0001;
        cols = 4'b1010;
        #200
        assert(keyMap == 16'0010010010001010)
            $display("PASS keyMap is correct at %t", $time);
        else
            $display("FAIL keyMap is incorrect at %t", $time);
        #200

        // toggle reset
        reset = 1'b1;
        #4
        assert(keyMap == 16'b0000000000000000)
            $display("PASS keyMap is reset at %t", $time);
        else
            $display("FAIL keyMap is not reset at %t", $time);

    end

endmodule