// Defining the delays in terms of ns with a precision of 1ns
`timescale 1 ns/1 ns

module keySwitchConverter_tb();

    logic [15:0] map;
    logic [3:0] switches;

    keySwitchConverter dut(map, switches);

    initial begin
        map = 16'b1000000000000000;
    end

endmodule