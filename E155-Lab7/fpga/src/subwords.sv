module subwords(input logic clk, reset, enable,
                input logic [31:0] a,
                output logic [31:0] y);

    logic [1:0] count;
    logic [0:3][0:3][7:0] inputArray, outputArray;
    logic [1:0] row, nextRow;
	logic [7:0] in, out;

    input_to_state #(4) is(a, inputArray);

    counter #(2, 4) staller(clk, reset, enable, count);

    // feed in a column at a time
    always_comb begin
        case(count)
            2'b00: begin nextRow = 2'b00; end
            2'b01: begin nextRow = 2'b01; end
            2'b10: begin nextRow = 2'b10; end
            2'b11: begin nextRow = 2'b11; end
            default: begin nextRow = 2'b00; end
        endcase
    end

    always_ff @(posedge clk, reset) begin
        if (reset) begin
            row <= 2'b00;
        end
        else begin
            if (enable) begin
                row <= nextRow;
            end
        end
    end
    
    always_comb begin
        case(row)
            2'b00: begin in = inputArray[0]; outputArray[0] = out; end
            2'b01: begin in = inputArray[1]; outputArray[1] = out; end
            2'b10: begin in = inputArray[2]; outputArray[2] = out; end
            2'b11: begin in = inputArray[3]; outputArray[3] = out; end
            default: begin in = inputArray[0]; outputArray[0] = out; end
        endcase
    end

    sbox convert(in, out);

    state_to_output #(4) so(outputArray, y);

endmodule