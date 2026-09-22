// Defining the delays in terms of ns with a precision of 1ns
`timescale 1 ns/1 ns

module synchronizer_tb();

    logic clk;
    logic [1:0] d, q;

    synchronizer #(.WIDTH(2)) dut (clk, d, q);

    always begin
		clk = 0; 
		#1;
		clk = 1;
		#1;
	end

    initial begin
        d = 2'b00;
        #2

        d = 2'b01;
        #2

        assert(q == 2'b00)
            $display("PASS output is correct at %t", $time);
		else
			$display("FAIL output is incorrect at %t", $time);

        d = 2'b10;
        #2

        assert(q == 2'b01)
            $display("PASS output is correct at %t", $time);
		else
			$display("FAIL output is incorrect at %t", $time);

        d = 2'b11;
        #2

        assert(q == 2'b10)
            $display("PASS output is correct at %t", $time);
		else
			$display("FAIL output is incorrect at %t", $time);

        d = 2'b00;
        #2

        assert(q == 2'b11)
            $display("PASS output is correct at %t", $time);
		else
			$display("FAIL output is incorrect at %t", $time);

        d = 2'b01;
        #2

        assert(q == 2'b00)
            $display("PASS output is correct at %t", $time);
		else
			$display("FAIL output is incorrect at %t", $time);

    end
endmodule