module subwords(input logic clk, reset, enable,
                input logic [31:0] a,
                output logic [31:0] y);

    logic [1:0] count;
    logic [0:3][0:3][7:0] inputArray, outputArray;
    logic [2:0] row;

    input_to_state #(4) is(a, inputArray);

    counter #(2, 4) staller(clk, reset, enable, count);

    // feed in a column at a time
    always_comb begin
        case(count)
            2'b00: begin row = 2'b00; end
            2'b01: begin row = 2'b01; end
            2'b10: begin row = 2'b10; end
            2'b11: begin row = 2'b11; end
            default: begin row = 2'b00; end
        endcase
    end

    sbox convert(inputArray[row][7:0], outputArray[row][7:0]);

    state_to_output #(4) so(outputArray, y);

endmodule