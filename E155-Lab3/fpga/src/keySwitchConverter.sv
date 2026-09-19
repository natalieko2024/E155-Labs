module keySwitchConverter(input logic [15:0] map,
                            output logic [3:0] switches);

    always_comb begin
        case(map)
        16'b1000000000000000: switches = 4'h1;
        16'b0100000000000000: switches = 4'h2;
        16'b0010000000000000: switches = 4'h3;
        16'b0001000000000000: switches = 4'hA;
        16'b0000100000000000: switches = 4'h4;
        16'b0000010000000000: swtiches = 4'h5;
        16'b0000001000000000: switches = 4'h6;
        16'b0000000100000000: switches = 4'hB;
        16'b0000000010000000: switches = 4'h7;
        16'b0000000001000000: switches = 4'h8;
        16'b0000000000100000: switches = 4'h9;
        16'b0000000000010000: switches = 4'hC;
        16'b0000000000001000: switches = 4'hF;
        16'b0000000000000100: switches = 4'h0;
        16'b0000000000000010: switches = 4'hG;
        16'b0000000000000001: switches = 4'hD;
    end

endmodule