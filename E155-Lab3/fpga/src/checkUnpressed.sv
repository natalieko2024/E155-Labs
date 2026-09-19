module checkUnpressed(input logic [15:0] map,
                    output logic [3:0] checkCol);

    logic [3:0] col3, col2, col1, col0;

    assign col3 = {map[15], map[11], map[7], map[3]};
    assign col2 = {map[14], map[10], map[6], map[2]};
    assign col1 = {map[13], map[9], map[5], map[1]};
    assign col0 = {map[12], map[8], map[4], map[0]};

    always_comb begin
        if ($onehot(col3)) checkCol = 4'b1000;
        else if ($onehot(col2)) checkCol = 4'b0100;
        else if ($onehot(col1)) checkCol = 4'b0010;
        else if ($onehot(col0)) checkCol = 4'b0001;
        else checkCol = 4'b0000;
    end

endmodule