module keyExpansion(input logic clk,
                    input logic [3:0] round,
                    input logic [127:0] roundKey,
                    output logic [127:0] newRoundKey);

    // AES 5.2
    // Nk=4, Nr=10

    logic [31:0] roundConst, subW;

    // Finding w[0]
    always_comb begin
        case(round)
            4'd1: roundConst = 32'h01000000;	// HAVE TO ADD 0s OR the XOR DOESNT WORK
            4'd2: roundConst = 32'h02000000;
            4'd3: roundConst = 32'h04000000;
            4'd4: roundConst = 32'h08000000;
            4'd5: roundConst = 32'h10000000;
            4'd6: roundConst = 32'h20000000;
            4'd7: roundConst = 32'h40000000;
            4'd8: roundConst = 32'h80000000;
            4'd9: roundConst = 32'h1b000000;
            4'd10: roundConst = 32'h36000000;
            default: roundConst = 32'h0000000;
        endcase
    end

    // rotword(temp) is roundKey, subword this to get output
    // so shift roundKey 4 bytes left and put it into sbox
    sbox_sync sb0(roundKey[31:24], clk, subW[7:0]);
    sbox_sync sb1(roundKey[7:0], clk, subW[15:8]);
    sbox_sync sb2(roundKey[15:8], clk, subW[23:16]);
    sbox_sync sb3(roundKey[23:16], clk, subW[31:24]);

    // output XOR roundKey
    // w[0] = w[0-4]^sw^rk
    assign newRoundKey[127:96] = roundKey[127:96] ^ subW ^ roundConst;

    // Finding w[1], w[2], w[3]
    // w[i] = w[i-4]^w[i-1]
    // bc of how rotated, w[i-4] = rk[i]
    assign newRoundKey[95:64] = roundKey[95:64] ^ newRoundKey[127:96];
    assign newRoundKey[63:32] = roundKey[63:32] ^ newRoundKey[95:64];
    assign newRoundKey[31:0] = roundKey[31:0] ^ newRoundKey[63:32];

endmodule