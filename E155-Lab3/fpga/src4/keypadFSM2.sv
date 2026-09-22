module keypadFSM(input logic clk, reset,
                input logic [12:0] scanCount,
                input logic [20:0] debounceCount,
                input logic [15:0] map1, map2, map3, map4,
				input logic [3:0] position,
                output logic scan1EN, scan2EN, scan3EN, scan4EN, scanCountRST, debounceRST, displayEN);

	typedef enum logic [3:0] {SCAN1 = 4'b0000, OFF1 = 4'b0001, SCAN2 = 4'b0010, OFF2 = 4'b0011, DISPLAY = 4'b0100, SCAN3 = 4'b0101, OFF3 = 4'b0110, SCAN4 = 4'b0111, OFF4 = 4'b1000} statetype;
	statetype state, nextState;
	//statetype nextState;

	always_ff @(posedge clk, negedge reset) begin
		if (~reset) state <= SCAN1;
		else state <= nextState;
	end
	
	always_comb begin
		case(state)
			SCAN1: begin
				scan1EN = 1;
				scan2EN = 0;
				scan3EN = 0;
				scan4EN = 0;
				scanCountRST = 1;
				debounceRST = 0;
				displayEN = 0;
				if (scanCount >= 20) nextState = OFF1;
				else nextState = SCAN1;
			end
			
			OFF1: begin
				scan1EN = 0;
				scan2EN = 0;
				scan3EN = 0;
				scan4EN = 0;
				scanCountRST = 0;
				debounceRST = 1;
				displayEN = 0;
				if (debounceCount >= 120000) nextState = SCAN2;
				else nextState = OFF1;
			end
			
			SCAN2: begin
				scan1EN = 0;
				scan2EN = 1;
				scan3EN = 0;
				scan4EN = 0;
				scanCountRST = 1;
				debounceRST = 0;
				displayEN = 0;
				if (scanCount >= 20) nextState = OFF2;
				else nextState = SCAN2;
			end
			
			OFF2: begin
				scan1EN = 0;
				scan2EN = 0;
				scan3EN = 0;
				scan4EN = 0;
				scanCountRST = 0;
				debounceRST = 0;
				displayEN = 0;
				if ((map1 == map2) && $onehot(map2)) nextState = DISPLAY;
				else if (~(map1 == map2) || ~$onehot(map2)) nextState = SCAN1;
				else nextState = OFF2;
			end
			
			DISPLAY: begin
				scan1EN = 0;
				scan2EN = 0;
				scan3EN = 0;
				scan4EN = 0;
				scanCountRST = 0;
				debounceRST = 0;
				displayEN = 1;
				nextState = SCAN3;
			end
			
			SCAN3: begin
				scan1EN = 0;
				scan2EN = 0;
				scan3EN = 1;
				scan4EN = 0;
				scanCountRST = 1;
				debounceRST = 0;
				displayEN = 0;
				if (scanCount >= 20) nextState = OFF3;
				else nextState = SCAN3;
			end
			
			OFF3: begin
				scan1EN = 0;
				scan2EN = 0;
				scan3EN = 0;
				scan4EN = 0;
				scanCountRST = 0;
				debounceRST = 1;
				displayEN = 0;
				if (debounceCount >= 120000) nextState = SCAN4;
				else nextState = OFF3;
			end
			
			SCAN4: begin
				scan1EN = 0;
				scan2EN = 0;
				scan3EN = 0;
				scan4EN = 1;
				scanCountRST = 1;
				debounceRST = 0;
				displayEN = 0;
				if (scanCount >= 20) nextState = OFF4;
				else nextState = SCAN4;
			end
			
			OFF4: begin
				scan1EN = 0;
				scan2EN = 0;
				scan3EN = 0;
				scan4EN = 0;
				scanCountRST = 0;
				debounceRST = 0;
				displayEN = 0;
				//if ((map3 == map4) && (map4 == 0)) nextState = SCAN1;
				//else if (~(map3 == map4) || ($onehot(map4))) nextState = SCAN3;
				//else nextState = OFF4;
				if ((map3 == map4) && (map4[position] != map2[position])) nextState = SCAN1;
				else if (~(map3 == map4) || (map4[position] == map2[position])) nextState = SCAN3;
				else nextState = OFF4;
			end
			
			default: begin
				scan1EN = 1;
				scan2EN = 0;
				scan3EN = 0;
				scan4EN = 0;
				scanCountRST = 1;
				debounceRST = 0;
				displayEN = 0;
				nextState = SCAN1;
			end
		endcase
	end
	
endmodule