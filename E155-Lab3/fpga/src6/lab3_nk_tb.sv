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
        #4
        reset = 1'b1;

    end

endmodule