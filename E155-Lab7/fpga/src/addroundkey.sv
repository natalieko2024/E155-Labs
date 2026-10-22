module addroundkey(input logic [127:0] a,
                    input logic [0:3][7:0] word,
                    output logic [127:0] y);

    logic [0:3][0:3][7:0] initialState, finalState;

    input_to_state #(4) is(a, initialState);

    // finalState[0:3][0][7:0] = initialState[0:3][0][7:0] ^ word;
    // finalState[0:3][1][7:0] = initialState[0:3][1][7:0] ^ word;
    // finalState[0:3][2][7:0] = initialState[0:3][2][7:0] ^ word;
    // finalState[0:3][3][7:0] = initialState[0:3][3][7:0] ^ word;

    genvar i, k;

    for (i=0; i<4; i++) begin
        for (k=0; k<4; k++) begin
            assign finalState[k][i][7:0] = initialState[k][i][7:0] ^ word[k];
        end
    end

    state_to_output #(4) so(finalState, y);

endmodule