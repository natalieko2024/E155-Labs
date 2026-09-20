// Defining the delays in terms of ns with a precision of 1ns
`timescale 1 ns/1 ns

module findHighBit_tb();

    logic [15:0] map;
    logic [4:0] position;

    findHighBit dut(map, position);

    initial begin
        map = 16'b1000000000000000;
        #1

        assert(position == 5'b01111)
            $display("PASS position is correct for input map");
		else
			$display("FAIL position is incorrect for input map");
        #1

        map = 16'b0100000000000000;
        #1

        assert(position == 5'b01110)
            $display("PASS position is correct for input map");
		else
			$display("FAIL position is incorrect for input map");
        #1

        map = 16'b0010000000000000;
        #1

        assert(position == 5'b01101)
            $display("PASS position is correct for input map");
		else
			$display("FAIL position is incorrect for input map");
        #1

        map = 16'b0001000000000000;
        #1

        assert(position == 5'b01100)
            $display("PASS position is correct for input map");
		else
			$display("FAIL position is incorrect for input map");
        #1

        map = 16'b0000100000000000;
        #1

        assert(position == 5'b01011)
            $display("PASS position is correct for input map");
		else
			$display("FAIL position is incorrect for input map");
        #1

        map = 16'b0000010000000000;
        #1

        assert(position == 5'b01010)
            $display("PASS position is correct for input map");
		else
			$display("FAIL position is incorrect for input map");
        #1

        map = 16'b0000001000000000;
        #1

        assert(position == 5'b01001)
            $display("PASS position is correct for input map");
		else
			$display("FAIL position is incorrect for input map");
        #1

        map = 16'b0000000100000000;
        #1

        assert(position == 5'b01000)
            $display("PASS position is correct for input map");
		else
			$display("FAIL position is incorrect for input map");
        #1

        map = 16'b0000000010000000;
        #1

        assert(position == 5'b00111)
            $display("PASS position is correct for input map");
		else
			$display("FAIL position is incorrect for input map");
        #1

        map = 16'b0000000001000000;
        #1

        assert(position == 5'b00110)
            $display("PASS position is correct for input map");
		else
			$display("FAIL position is incorrect for input map");
        #1

        map = 16'b0000000000100000;
        #1

        assert(position == 5'b00101)
            $display("PASS position is correct for input map");
		else
			$display("FAIL position is incorrect for input map");
        #1

        map = 16'b0000000000010000;
        #1

        assert(position == 5'b00100)
            $display("PASS position is correct for input map");
		else
			$display("FAIL position is incorrect for input map");
        #1

        map = 16'b0000000000001000;
        #1

        assert(position == 5'b00011)
            $display("PASS position is correct for input map");
		else
			$display("FAIL position is incorrect for input map");
        #1

        map = 16'b0000000000000100;
        #1

        assert(position == 5'b00010)
            $display("PASS position is correct for input map");
		else
			$display("FAIL position is incorrect for input map");
        #1

        map = 16'b0000000000000010;
        #1

        assert(position == 5'b00001)
            $display("PASS position is correct for input map");
		else
			$display("FAIL position is incorrect for input map");
        #1

        map = 16'b0000000000000001;
        #1

        assert(position == 5'b00000)
            $display("PASS position is correct for input map");
		else
			$display("FAIL position is incorrect for input map");
        #1

    end
endmodule