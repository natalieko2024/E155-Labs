module keyexpansion(input clk, reset, enable, 
                    input logic [127:0] key,
                    output logic [1407:0] word);    

    // 8 words per round so 256

    logic [0:3][0:3][7:0] keyArray;
    logic [0:3][0:7][7:0] wordArray;
    logic [0:3][7:0] initialTemp, ifTemp, finalTemp;
    logic [0:3][0:9][7:0] roundConst;

    // logic [3:0] round;

    // always_comb begin
    //     case(round)
    //         4'd0: roundConst[0][7:0] = 8'h1;
    //         4'd1: roundConst[0][7:0] = 8'h2;
    //         4'd2: roundConst[0][7:0] = 8'h4;
    //         4'd3: roundConst[0][7:0] = 8'h8;
    //         4'd4: roundConst[0][7:0] = 8'h10;
    //         4'd5: roundConst[0][7:0] = 8'h20;
    //         4'd6: roundConst[0][7:0] = 8'h40;
    //         4'd7: roundConst[0][7:0] = 8'h80;
    //         4'd8: roundConst[0][7:0] = 8'h1b;
    //         4'd9: roundConst[0][7:0] = 8'h36;
    //         default: roundConst[0][7:0] = 0;
    //     endcase
    // end

    assign roundConst[0][0][7:0] = 8'h1;
	assign roundConst[0][1][7:0] = 8'h2;
	assign roundConst[0][2][7:0] = 8'h4;
	assign roundConst[0][3][7:0] = 8'h8;
    assign roundConst[0][4][7:0] = 8'h10;
    assign roundConst[0][5][7:0] = 8'h20;
    assign roundConst[0][6][7:0] = 8'h40;
    assign roundConst[0][7][7:0] = 8'h80;
    assign roundConst[0][8][7:0] = 8'h1b;
    assign roundConst[0][9][7:0] = 8'h36;

    genvar i, j;

    for(i=0; i<10; i++) begin
        for(j=0; j<3; j++) begin
            assign roundConst[j+1][i][7:0] = 8'h0;
        end
    end

    input_to_state #(4) is(key, keyArray);

    // word column, key row
    // this replaces the first while (bc no overlap)
    // assign wordArray[0:3][0][7:0] = keyArray[0][0:3][7:0];
    // assign wordArray[0:3][1][7:0] = keyArray[1][0:3][7:0];
    // assign wordArray[0:3][2][7:0] = keyArray[2][0:3][7:0];
    // assign wordArray[0:3][3][7:0] = keyArray[3][0:3][7:0];

    genvar l,k;

    for (l=0; l<4; l++) begin
        for (k=0; k<4; k++) begin
            assign wordArray[k][l][7:0] = keyArray[l][k][7:0];
        end
    end

    // 1x if

    // just need same number of bits to assign to each other
    // temp is w[i-1] then rotated

    // assign initialTemp[0:2][7:0] = wordArray[1:3][3][7:0];

    //rotate word
    genvar n,m;
    for (n=0; n<10; n++) begin
        for (m=0; m<3; m++) begin
            assign initialTemp[m][7:0] = wordArray[m+1][3+4*n][7:0];
        end
    
        assign initialTemp[3][7:0] = wordArray[0][3+4*n][7:0];

        subwords sw(clk, reset, enable, initialTemp, ifTemp);

        //XOR
        genvar p;
        for (p=0; p<4; p++) begin
            assign finalTemp[p][7:0] = ifTemp[p][7:0] ^ roundConst[p][n][7:0];
        end

        genvar q;
        for (q=0; q<4; q++) begin
            assign wordArray[q][n*4+4][7:0] = wordArray[q][n*4][7:0] ^ finalTemp[q][7:0];
        end

        // 3x else

        //assign wordArray[0:3][5][7:0] = wordArray[0:3][1][7:0] ^ wordArray[0:3][4][7:0];
        //assign wordArray[0:3][6][7:0] = wordArray[0:3][2][7:0] ^ wordArray[0:3][5][7:0];
        //assign wordArray[0:3][7][7:0] = wordArray[0:3][3][7:0] ^ wordArray[0:3][6][7:0];

        genvar r,s;
        for (r=0; r<3; r++) begin
            for (s=0; s<4; s++) begin
                assign wordArray[r][n*4+s+5][7:0] = wordArray[r][n*4+s+1][7:0] ^ wordArray[r][n*4+s+4][7:0];
            end
        end

    end

    state_to_output #(8) so(wordArray, word);

endmodule