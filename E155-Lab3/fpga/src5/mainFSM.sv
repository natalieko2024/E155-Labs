module mainFSM(input logic clk, reset, debounced, press,
                input logic [15:0] keymap,
                output logic [15:0] rightKeymap, leftKeymap,
				output logic displayEN,
				output logic [1:0] state);

	logic [15:0] initialKeymap, finalKeymap;
	typedef enum logic [1:0] {SCAN = 2'b00, PRESS = 2'b01, HOLD = 2'b10} statetype;
	statetype nextState;
	
	always_ff @(posedge clk, negedge reset) begin
		if (~reset) state <= SCAN;
		else begin
            state <= nextState;
            if (state == PRESS) begin
                leftKeymap <= rightKeymap;
                rightKeymap <= keymap;
            end
        end
	end

	always_comb begin
		case(state)
			SCAN: begin nextState = (debounced & press) ? PRESS : SCAN; displayEN = 1'b0; end
			PRESS: begin nextState = HOLD; displayEN = 1'b1; end
			HOLD: begin nextState = (~press) ? SCAN : HOLD; displayEN = 1'b0; end
			default: begin nextState = SCAN; displayEN = 1'b0; end
		endcase
	end

endmodule