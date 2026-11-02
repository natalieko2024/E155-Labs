module subbytes(input logic clk, reset, enable,
                input logic [127:0] a,
                output logic [127:0] y);

    logic [3:0] count;
    logic [0:3][0:3][7:0] inputArray, outputArray;
    logic [2:0] row, col, nextRow, nextCol;
	logic [7:0] in, out;

    input_to_state #(4) is(a, inputArray);

    counter #(4, 16) staller(clk, reset, enable, count);

    always_comb begin
        case(count)
            4'b0000: begin nextRow = 2'b00; nextCol = 2'b00; end
            4'b0001: begin nextRow = 2'b00; nextCol = 2'b01; end
            4'b0010: begin nextRow = 2'b00; nextCol = 2'b10; end
            4'b0011: begin nextRow = 2'b00; nextCol = 2'b11; end
            4'b0100: begin nextRow = 2'b01; nextCol = 2'b00; end
            4'b0101: begin nextRow = 2'b01; nextCol = 2'b01; end
            4'b0110: begin nextRow = 2'b01; nextCol = 2'b10; end
            4'b0111: begin nextRow = 2'b01; nextCol = 2'b11; end
            4'b1000: begin nextRow = 2'b10; nextCol = 2'b00; end
            4'b1001: begin nextRow = 2'b10; nextCol = 2'b01; end
            4'b1010: begin nextRow = 2'b10; nextCol = 2'b10; end
            4'b1011: begin nextRow = 2'b10; nextCol = 2'b11; end
            4'b1100: begin nextRow = 2'b11; nextCol = 2'b00; end
            4'b1101: begin nextRow = 2'b11; nextCol = 2'b01; end
            4'b1110: begin nextRow = 2'b11; nextCol = 2'b10; end
            4'b1111: begin nextRow = 2'b11; nextCol = 2'b11; end
            default: begin nextRow = 2'b00; nextCol = 2'b00; end
        endcase
    end

    always_ff @(posedge clk, posedge reset) begin
        if (reset) begin
            row <= 2'b00;
            col <= 2'b00;
        end
        else begin
            if (enable) begin
                row <= nextRow;
                col <= nextCol;
            end
        end
    end

    always_comb begin
        case({row, col})
            4'b0000: begin in = inputArray[0][0]; outputArray[0][0] = out; end
            4'b0001: begin in = inputArray[0][1]; outputArray[0][1] = out; end
            4'b0010: begin in = inputArray[0][2]; outputArray[0][2] = out; end
            4'b0011: begin in = inputArray[0][3]; outputArray[0][3] = out; end
            4'b0100: begin in = inputArray[1][0]; outputArray[1][0] = out; end
            4'b0101: begin in = inputArray[1][1]; outputArray[1][1] = out; end
            4'b0110: begin in = inputArray[1][2]; outputArray[1][2] = out; end
            4'b0111: begin in = inputArray[1][3]; outputArray[1][3] = out; end
            4'b1000: begin in = inputArray[2][0]; outputArray[2][0] = out; end
            4'b1001: begin in = inputArray[2][1]; outputArray[2][1] = out; end
            4'b1010: begin in = inputArray[2][2]; outputArray[2][2] = out; end
            4'b1011: begin in = inputArray[2][3]; outputArray[2][3] = out; end
            4'b1100: begin in = inputArray[3][0]; outputArray[3][0] = out; end
            4'b1101: begin in = inputArray[3][1]; outputArray[3][1] = out; end
            4'b1110: begin in = inputArray[3][2]; outputArray[3][2] = out; end
            4'b1111: begin in = inputArray[3][3]; outputArray[3][3] = out; end
            default: begin in = inputArray[0][0]; outputArray[0][0] = out; end
        endcase
    end

    sbox convert(in, out);

    state_to_output #(4) so(outputArray, y);

endmodule