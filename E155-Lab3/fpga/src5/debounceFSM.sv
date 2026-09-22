module debounceFSM(input logic clk, reset, 
                input logic [3:0] syncCols, 
                input logic [31:0] count,
                output logic countRST, countEN,
                output logic [3:0] debouncedCols);

    logic [3:0] initialCols, finalCols;
	
	typedef enum logic [1:0] {IDLE = 2'b00, WAIT = 2'b01, PRESS = 2'b10} statetype;
	statetype state, nextState;

	always_ff @(posedge clk, negedge reset) begin
		if (~reset) state <= IDLE;
		else state <= nextState;
	end
	
	always_comb begin
		case(state)
			IDLE: begin
				if (~(&syncCols)) nextState = WAIT;
				else nextState = IDLE;
			end 
			WAIT: begin
				if (count >= 1200000) nextState = PRESS;
				else if (initialCols != finalCols) nextState = IDLE;
				else nextState = WAIT;
			end
			PRESS: begin
				if (initialCols != finalCols) nextState = IDLE;
				else nextState = PRESS;
			end 
			default: nextState = IDLE;
		endcase
	end
	
	always_ff @(posedge clk, negedge reset) begin
		if (~reset) begin
			countRST <= 1;
			countEN <= 0;
		end
		else begin
			if (state == IDLE) countRST <= 1;
			else if (state == WAIT) countEN <= 1;
			else if (state == PRESS) begin
				countRST <= 0;
				countEN <= 0;
			end
			
			if ((state == IDLE) && (nextState == WAIT)) initialCols <= syncCols;
			if ((state == WAIT) && (nextState == PRESS)) finalCols <= syncCols;
			if ((state == PRESS) && (nextState == PRESS)) finalCols <= syncCols;
		end
	end
	
	assign debouncedCols = (state == PRESS) ? syncCols : 4'b1111;

endmodule