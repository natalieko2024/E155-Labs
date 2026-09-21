module mapFSM(input logic clk, reset, 
                input logic [15:0] keymap,
                output logic scanEN,
                output logic [15:0] rightKeymap, leftKeymap);

    logic [1:0] state, nextState;
	logic [15:0] initialKeymap, finalKeymap;

    always_ff @(posedge clk, negedge reset) begin
        if (~reset) state <= 2'b00;
        else if (state == 2'b01) begin
            rightKeymap = initialKeymap;
            leftKeymap = rightKeymap; 
        end
        else state <= nextState;
    end

    always_comb begin
        case(state)
            
            // State 1: SCAN
            2'b00: begin
                scanEN = 1'b1;
                if ($onehot(keymap)) begin
                    nextState = 2'b01;
                    initialKeymap = keymap;
                end
                else if (~$onehot(keymap)) nextState = 2'b00;
                else nextState = 2'b00;
            end

            // State 2: PRESS
            2'b01: begin
                scanEN = 1'b0;
                nextState = 2'b10;
            end

            // State 3: HOLD
            2'b10: begin
                scanEN = 1'b0;
                if (keymap == 0) nextState = 2'b00;
                else if ((initialKeymap != finalKeymap) && ($onehot(finalKeymap))) nextState = 2'b01;
                else begin
                    nextState = 2'b10;
                    finalKeymap = keymap;
                end
            end
			
			default: begin
				scanEN = 1'b0;
				nextState = 2'b00;
			end
        endcase
    end

endmodule