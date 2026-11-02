module addroundkey(input logic [127:0] a, word,
                    output logic [127:0] y);

    logic [0:3][0:3][7:0] initialState, finalState, decodedWord;

    input_to_state #(4) is1(a, initialState);
    input_to_state #(4) is2(word, decodedWord);

    // finalState[0:3][0][7:0] = initialState[0:3][0][7:0] ^ word;
    // finalState[0:3][1][7:0] = initialState[0:3][1][7:0] ^ word;
    // finalState[0:3][2][7:0] = initialState[0:3][2][7:0] ^ word;
    // finalState[0:3][3][7:0] = initialState[0:3][3][7:0] ^ word;

    genvar i, k;

    for (i=0; i<4; i++) begin
        for (k=0; k<4; k++) begin
            assign finalState[i][k][7:0] = initialState[i][k][7:0] ^ decodedWord[i][k][7:0];
        end
    end

    state_to_output #(4) so(finalState, y);

endmodule