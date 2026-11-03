module addRoundKey(input logic [127:0] state,
                    input logic [127:0] roundKey,
                    output logic [127:0] newState);
    
    // newstate = state XOR roundkey (AES section 5.1.4)
    assign newState = state ^ roundKey;

endmodule