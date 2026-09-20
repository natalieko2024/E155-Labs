module keyMapper(input logic clk, reset, enable, tick,
                input logic [3:0] rows, cols,
                output logic [15:0] map);

    logic [15:0] newMap;

    always_ff @(posedge clk, negedge reset) begin
        if (~reset) map <= 16'b1111111111111111;
        else if (enable) map <= newMap;
    end

    // If the particular row is high, write ~cols to newMap
    // (cols are active low, so ~cols will write 1 when the key is pressed)
    always_comb begin
        if (tick) begin
            case(rows)
                4'b1000: newMap[15:12] = ~cols;
                4'b0100: newMap[11:8] = ~cols;
                4'b0010: newMap[7:4] = ~cols;
                4'b0001: newMap[3:0] = ~cols;
                default: newMap = 16'b1111111111111111;
            endcase
        end

    end
    
    // assign newMap[3:0] = rows[0] ? ~cols : map[3:0];
    // assign newMap[7:4] = rows[1] ? ~cols : map[7:4];
    // assign newMap[11:8] = rows[2] ? ~cols : map[11:8];
    // assign newMap[15:12] = rows[3] ? ~cols : map[15:12];

endmodule