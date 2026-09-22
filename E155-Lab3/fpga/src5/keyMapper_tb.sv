// Defining the delays in terms of ns with a precision of 1ns
`timescale 1 ns/1 ns

module keyMapper_tb();
    logic clk, reset, enable;
    logic [3:0] rows, cols;
    logic [15:0] map;

    keyMapper dut(clk, reset, enable, rows, cols, map);

    

endmodule