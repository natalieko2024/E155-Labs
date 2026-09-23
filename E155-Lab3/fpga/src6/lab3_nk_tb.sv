// Defining the delays in terms of ns with a precision of 1ns
`timescale 1 ns/1 ns

module lab3_nk_tb();

    logic reset;
    logic [3:0] cols, rows;
    logic [1:0] anodes;
    logic [6:0] segWrite;

    lab3_nk dut(reset, cols, rows, anodes, segWrite);

    initial begin
        reset = 1'b0;
        #100
        reset = 1'b1;
		
		// single press - bounce for 10ms
		
		cols = 4'b0111;
		#100
		cols = 4'b0000;
		#100
		cols = 4'b0111;
		#100
		cols = 4'b0000;
		#100
		cols = 4'b0111;
		#100
		cols = 4'b0000;
		#100
		cols = 4'b0111;
		#100
		cols = 4'b0000;
		#100
		cols = 4'b0111;
		#100
		cols = 4'b0000;
		#100
		cols = 4'b0111;
		#100
		cols = 4'b0000;
		#100
		cols = 4'b0111;
		#100
		cols = 4'b0000;
		#100
		cols = 4'b0111;
		#100
		cols = 4'b0000;
		#100
		cols = 4'b0111;
		#100
		cols = 4'b0000;
		#100
		cols = 4'b0111;
		#100
		cols = 4'b0000;
		#100
		cols = 4'b0111;
		#100
		cols = 4'b0000;
		#100
		cols = 4'b0111;
		#100
		cols = 4'b0000;
		#100
		cols = 4'b0111;
		#100
		cols = 4'b0000;
		#100
		cols = 4'b0111;
		#100
		cols = 4'b0000;
		#100
		cols = 4'b0111;
		#100
		cols = 4'b0000;
		#100
		cols = 4'b0111;
		#100
		cols = 4'b0000;
		#100
		cols = 4'b0111;
		#100
		cols = 4'b0000;
		#100
		cols = 4'b0111;
		#100
		cols = 4'b0000;
		#100
		cols = 4'b0111;
		#100
		cols = 4'b0000;
		#100
		cols = 4'b0111;
		#100
		cols = 4'b0000;
		#100
		cols = 4'b0111;
		#100
		cols = 4'b0000;
		#100
		cols = 4'b0111;
		#100
		cols = 4'b0000;
		#100
		cols = 4'b0111;
		#100
		cols = 4'b0000;
		#100
		cols = 4'b0111;
		#100
		cols = 4'b0000;
		#100
		cols = 4'b0111;
		#100
		cols = 4'b0000;
		#100
		cols = 4'b0111;
		#100
		cols = 4'b0000;
		#100
		cols = 4'b1111;
		#15624
		
		
		
		
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		
		assert(anodes == 2'b10)
            $display("PASS anode correct at %t", $time);
		else
			$display("FAIL anode incorrect at %t", $time);
			
		assert(segWrite == 7'b1001111)
            $display("PASS segment correct at %t", $time);
		else
			$display("FAIL segment incorrect at %t", $time);
		
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b1111;
		#15624
		cols = 4'b0111;
		#5208
		cols = 4'b0000;
		#15624
		
		
		assert(anodes == 2'b01)
            $display("PASS anode correct at %t", $time);
		else
			$display("FAIL anode incorrect at %t", $time);
			
		assert(segWrite == 7'b0000000)
            $display("PASS segment correct at %t", $time);
		else
			$display("FAIL segment incorrect at %t", $time);
		
		
		reset = 1'b0;
		#100000
		assert(anodes == 2'b10)
            $display("PASS anode correct after reset at %t", $time);
		else
			$display("FAIL anode incorrect after reset at %t", $time);
			
		assert(segWrite == 7'b0000000)
            $display("PASS segment correct after reset at %t", $time);
		else
			$display("FAIL segment incorrect after reset at %t", $time);
		
		#100
		$stop;

    end

endmodule