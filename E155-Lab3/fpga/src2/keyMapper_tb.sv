// Defining the delays in terms of ns with a precision of 1ns
`timescale 1 ns/1 ns

module keyMapper_tb();

    logic clk, reset, enable;
    logic [3:0] rows, cols;
    logic [15:0] map;

    keyMapper dut(clk, reset, enable, rows, cols, map);

    always begin
        clk = 0; 
        #1;
        clk = 1;
        #1;
    end

    initial begin
        reset 1'b0;
        #4
        reset 1'b1;
        enable 1'b1;
        #4
        
        rows = 4'b1000;


        rows = 4'b0100;


        rows = 4'b0010;


        rows = 4'b0001;
    end

endmodule