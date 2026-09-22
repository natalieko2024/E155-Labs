module mapFSM(input logic clk, reset, 
                input logic [15:0] keymap,
                output logic scanEN,
                output logic [15:0] rightKeymap, leftKeymap);

	logic [15:0] initialKeymap, finalKeymap;
	typedef enum logic [1:0] {SCAN = 2'b00, PRESS = 2'b01, HOLD = 2'b10} statetype;
	statetype state, nextState;
	
	always_ff @(posedge clk, negedge reset) begin
		if (~reset) state <= SCAN;
		else state <= nextState;
	end

	always_comb begin
		case(state)
			SCAN: nextState = $onehot(keymap) ? PRESS : SCAN;
			PRESS: nextState = HOLD;
			HOLD: begin
				if ((initialKeymap != finalKeymap) && $onehot(finalKeymap)) nextState = PRESS;
				else if (keymap == 0) nextState = SCAN;
				else nextState = HOLD;
			end 
			default: nextState = SCAN;
		endcase
	end
	
	always_ff @(posedge clk, negedge reset) begin
		if (~reset) begin
			rightKeymap <= 0;
			leftKeymap <= 0;
			scanEN <= 1;
		end
		else begin
			if (state == SCAN) scanEN <= 1;
			else scanEN <= 0;
				
			if ((state == PRESS) && (keymap != 0)) begin
				leftKeymap <= rightKeymap;
				rightKeymap <= keymap;
			end
			
			if ((state == SCAN) && (nextState == PRESS)) initialKeymap <= keymap;
			if ((state == HOLD) && (nextState == HOLD)) finalKeymap <= keymap;
		end
	end

endmodule