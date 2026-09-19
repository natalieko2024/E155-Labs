module keyMapping(input logic clk, reset, enable,
                input logic [3:0] rows, cols,
                output logic [15:0] map);

    always_ff(@posedge clk, negedge reset) begin
        if (~reset) map <= 16'b1111111111111111;
        else if (enable) map <= newMap;
    end

    always_comb begin
        case(rows)
            4'b0001: newMap[3:0] = cols;
            4'b0010: newMap[7:4] = cols;
            4'b0100: newMap[11:8] = cols;
            4'b1000: newMap[15:12] = cols;
            default: newMap = map;
        endcase
    end

endmodule
