// Defining the delays in terms of ns with a precision of 1ns
`timescale 1 ns/1 ns

module enableFlipFlop_tb();

    logic clk, reset;
    logic [1:0] d, q;

    enableFlipFlop #(.WIDTH(2)) dut (clk, reset, d, q);

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
        enable = 1'b1;
        #4

        q = 2'b00;
        #2
        assert (d == 2'b00)
            $display("PASS output is correct at %t", $time);
		else
			$display("FAIL output is incorrect at %t", $time);
        
        q = 2'b01;
        #2
        assert (d == 2'b01)
            $display("PASS output is correct at %t", $time);
		else
			$display("FAIL output is incorrect at %t", $time);

        q = 2'b10;
        #2
        assert (d == 2'b10)
            $display("PASS output is correct at %t", $time);
		else
			$display("FAIL output is incorrect at %t", $time);

        q = 2'b11;
        #2
        assert (d == 2'b11)
            $display("PASS output is correct at %t", $time);
		else
			$display("FAIL output is incorrect at %t", $time);

        enable = 1'b0;
        q = 2'b00;
        #2
        assert (d == 2'b11)
            $display("PASS output is correct without enable at %t", $time);
		else
			$display("FAIL output is incorrect without enable at %t", $time);

        reset = 1'b0;
        #2
        assert (d == 2'b00)
            $display("PASS output is correct after reset at %t", $time);
		else
			$display("FAIL output is incorrect after reset at %t", $time);
    end

endmodule