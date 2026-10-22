module keyexpansion(input clk, reset, enable, 
                    input logic [127:0] key,
                    input logic [3:0] round,
                    output logic [255:0] word);    

    // 8 words per round so 256

    logic [0:3][0:3][7:0] keyArray;
    logic [0:3][0:7][7:0] wordArray;
    logic [0:3][7:0] initialTemp, ifTemp, finalTemp, roundConst;

    assign roundConst[1][7:0] = 0;
	assign roundConst[2][7:0] = 0;
	assign roundConst[3][7:0] = 0;

    always_comb begin
        case(round)
            4'd0: roundConst[0][7:0] = 8'h1;
            4'd1: roundConst[0][7:0] = 8'h2;
            4'd2: roundConst[0][7:0] = 8'h4;
            4'd3: roundConst[0][7:0] = 8'h8;
            4'd4: roundConst[0][7:0] = 8'h10;
            4'd5: roundConst[0][7:0] = 8'h20;
            4'd6: roundConst[0][7:0] = 8'h40;
            4'd7: roundConst[0][7:0] = 8'h80;
            4'd8: roundConst[0][7:0] = 8'h1b;
            4'd9: roundConst[0][7:0] = 8'h36;
            default: roundConst[0][7:0] = 0;
        endcase
    end

    input_to_state #(4) is(key, keyArray);

    // word column, key row
    // this replaces the first while (bc no overlap)
    // assign wordArray[0:3][0][7:0] = keyArray[0][0:3][7:0];
    // assign wordArray[0:3][1][7:0] = keyArray[1][0:3][7:0];
    // assign wordArray[0:3][2][7:0] = keyArray[2][0:3][7:0];
    // assign wordArray[0:3][3][7:0] = keyArray[3][0:3][7:0];

    genvar i,k;

    for (i=0; i<4; i++) begin
        for (k=0; k<4; k++) begin
            assign wordArray[k][i][7:0] = keyArray[i][k][7:0];
        end
    end

    // 1x if

    // just need same number of bits to assign to each other
    // temp is w[i-1] then rotated

    // assign initialTemp[0:2][7:0] = wordArray[1:3][3][7:0];

    genvar j;
    for (j=0; j<3; j++) begin
        assign initialTemp[j][7:0] = wordArray[j+1][3][7:0];
    end

    assign initialTemp[3][7:0] = wordArray[0][3][7:0];

    subwords sw(clk, reset, enable, initialTemp, ifTemp);

    assign finalTemp = ifTemp ^ roundConst;

    genvar x;
    for (x=0; x<4; x++) begin
        assign wordArray[x][4][7:0] = wordArray[x][0][7:0] ^ finalTemp;
    end
    // assign wordArray[0:3][4][7:0] = wordArray[0:3][0][7:0] ^ finalTemp;

    // 3x else

    //assign wordArray[0:3][5][7:0] = wordArray[0:3][1][7:0] ^ wordArray[0:3][4][7:0];
    //assign wordArray[0:3][6][7:0] = wordArray[0:3][2][7:0] ^ wordArray[0:3][5][7:0];
    //assign wordArray[0:3][7][7:0] = wordArray[0:3][3][7:0] ^ wordArray[0:3][6][7:0];

    genvar y, z;
    for (y=0; y<3; y++) begin
        for (z=0; z<4; z++) begin
            assign wordArray[z][y+5][7:0] = wordArray[z][y+1][7:0] ^ wordArray[z][y+4][7:0];
        end
    end

    state_to_output #(8) so(wordArray, word);

endmodule