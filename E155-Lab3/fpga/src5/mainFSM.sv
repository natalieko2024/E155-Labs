module mainFSM(input logic clk, reset, debounced,
                input logic [15:0] keymap,
                output logic [15:0] rightKeymap, leftKeymap);

	logic [15:0] initialKeymap, finalKeymap;
	typedef enum logic [1:0] {SCAN = 2'b00, PRESS = 2'b01, HOLD = 2'b10} statetype;
	statetype state, nextState;
	
	always_ff @(posedge clk, negedge reset) begin
		if (~reset) state <= SCAN;
		else state <= nextState;
        if (state == PRESS) begin
            leftKeymap <= rightKeymap;
			rightKeymap <= keymap;
        end

	end

	always_comb begin
		case(state)
			SCAN: nextState = (debounced & $onehot(keymap)) ? PRESS : SCAN;
			PRESS: nextState = HOLD;
			HOLD: nextState = (~$onehot(keymap)) ? SCAN : HOLD;
			default: nextState = SCAN;
		endcase
	end

endmodule