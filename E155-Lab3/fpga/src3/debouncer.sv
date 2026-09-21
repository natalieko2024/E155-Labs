module debouncer(input logic clk, reset, 
                input logic [3:0] syncCols, 
                input logic [20:0] count,
                output logic countRST, countEN,
                output logic [3:0] debouncedCols);

    logic [1:0] state, nextState;
    logic [3:0] initialCols, finalCols;

    always_ff @(posedge clk, negedge reset) begin
        if (~reset) state <= 2'b00;
        else state <= nextState;
    end

    always_comb begin
        case(state)
            // State 1: IDLE
            2'b00: begin
                countRST = 1'b1;
                countEN = 1'b0;
                if (&syncCols) nextState = 2'b00;
                else if (~(&syncCols)) begin
                    nextState = 2'b01;
                    initialCols = syncCols;
                end
                else nextState = 2'b00;
            end

            // State 2: WAIT
            2'b01: begin
                countRST = 1'b1;
                countEN = 1'b1;
                if (count < 1200000) nextState = 2'b01;
                else if (count >= 1200000) begin
                    nextState = 2'b11;
                    finalCols = syncCols;
                end
                else if (initialCols != finalCols) nextState = 2'b00;
                else nextState = 2'b01;
            end

            // State 3: PRESS
            2'b10: begin
                countRST = 1'b0;
                countEN = 1'b0;
                debouncedCols = finalCols;
                if (initialCols == finalCols) begin
                    nextState = 2'b10;
                    finalCols = syncCols;
                end
                else if (initialCols != finalCols) nextState = 2'b00;
                else nextState = 2'b10;
            end
			
			default: begin
				countRST = 1'b0;
				countEN = 1'b0;
				nextState = 2'b00;
			end

        endcase
    end


endmodule