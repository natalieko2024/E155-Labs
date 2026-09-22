module keypadFSM(input logic clk, reset,
                input logic [15:0] keyMap,
                output logic displayEN);

    logic [15:0] initialKeyMap;

	typedef enum logic [1:0] {START = 2'b00, DISPLAY = 2'b01, HOLD = 2'b10, MULTI = 2'b11} statetype;
	statetype state, nextState;

    always_ff @(posedge clk, negedge reset) begin
        if (~reset) state <= START;
        else begin
            state <= nextState;
            if (state == DISPLAY) initialKeyMap <= keyMap;
        end
    end

    always_comb begin
        case(state)

        START: begin
            displayEN = 0;
            if ($onehot(keyMap)) nextState = DISPLAY;
            else nextState = START;
        end

        DISPLAY: begin
            displayEN = 1;
            nextState = HOLD;
        end

        HOLD: begin
            displayEN = 0;
            if (keyMap == 0) nextState = START;
            else if ((~$onehot(keyMap)) && (keyMap !=0)) nextState = MULTI;
            else nextState = HOLD;
        end

        MULTI: begin
            displayEN = 0;
            if (initialKeyMap == keyMap) nextState = HOLD;
            else if ((initialKeyMap != keyMap) && $onehot(keyMap)) nextState = DISPLAY;
            else if (keyMap == 0) nextState = START;
            else nextState = MULTI;
        end

        default: begin 
            displayEN = 0; 
            nextState = START;
        end
        endcase
    end

endmodule