module subbytes(input logic clk, reset, enable,
                input logic [127:0] a,
                output logic [127:0] y);

    logic [3:0] count;
    logic [0:3][0:3][7:0] inputArray, outputArray;
    logic [2:0] row, col;

    input_to_state #(4) is(a, inputArray);

    counter #(4, 16) staller(clk, reset, enable, count);

    always_comb begin
        case(count)
            4'b0000: begin row = 2'b00; col = 2'b00; end
            4'b0001: begin row = 2'b00; col = 2'b01; end
            4'b0010: begin row = 2'b00; col = 2'b10; end
            4'b0011: begin row = 2'b00; col = 2'b11; end
            4'b0100: begin row = 2'b01; col = 2'b00; end
            4'b0101: begin row = 2'b01; col = 2'b01; end
            4'b0110: begin row = 2'b01; col = 2'b10; end
            4'b0111: begin row = 2'b01; col = 2'b11; end
            4'b1000: begin row = 2'b10; col = 2'b00; end
            4'b1001: begin row = 2'b10; col = 2'b01; end
            4'b1010: begin row = 2'b10; col = 2'b10; end
            4'b1011: begin row = 2'b10; col = 2'b11; end
            4'b1100: begin row = 2'b11; col = 2'b00; end
            4'b1101: begin row = 2'b11; col = 2'b01; end
            4'b1110: begin row = 2'b11; col = 2'b10; end
            4'b1111: begin row = 2'b11; col = 2'b11; end
            default: begin row = 2'b00; col = 2'b00; end
        endcase
    end

    sbox convert(inputArray[row][col][7:0], outputArray[row][col][7:0]);

    state_to_output #(4) so(outputArray, y);

endmodule