module keyColConverter(input logic [15:0] map,
                        output logic [3:0] cols);

    assign cols[0] = (map[0] | map[4] | map[8] | map[12]);
    assign cols[1] = (map[1] | map[5] | map[9] | map[13]);
    assign cols[2] = (map[2] | map[6] | map[10] | map[14]);
    assign cols[3] = (map[3] | map[7] | map[11] | map[15]);
    
endmodule