module keypadFSM(input logic clk, reset,
                input logic [12:0] scanCount,
                input logic [18:0] debounceCount,
                input logic [15:0] map1, map2, map3, map4,
				input logic [3:0] position,
                output logic scan1EN, scan2EN, scan3EN, scan4EN, scanCountRST, debounceRST, displayEN);

	typedef enum logic [3:0] {SCAN1 = 4'b0000, OFF1 = 4'b0001, SCAN2 = 4'b0010, OFF2 = 4'b0011, DISPLAY = 4'b0100, SCAN3 = 4'b0101, OFF3 = 4'b0110, SCAN4 = 4'b0111, OFF4 = 4'b1000} statetype;
	statetype state, nextState;

	always_ff @(posedge clk, negedge reset) begin
		if (~reset) state <= SCAN1;
		else state <= nextState;
	end

	always_comb begin 
		case(state)
			SCAN1: nextState = (scanCount >= 16) ? OFF1 : SCAN1;
			OFF1: nextState = (debounceCount >= 120000) ? SCAN2 : OFF1;
			SCAN2: nextState = (scanCount >= 16) ? OFF2 : SCAN2;
			OFF2: begin
				if ($onehot(map2)) nextState = DISPLAY;				//(map1 == map2) && 
				else if ((~$onehot(map2))) nextState = SCAN1;			//(~(map1 == map2)) || 
				else nextState = OFF2;
			end
			DISPLAY: nextState = SCAN3;
			SCAN3: nextState = (scanCount >= 16) ? OFF3 : SCAN3;
			OFF3: nextState = (debounceCount >= 120000) ? SCAN4 : OFF3;
			SCAN4: nextState = (scanCount >= 16) ? OFF4 : SCAN4;
			OFF4: begin
				if ((map2[position] != map4[position])) nextState = SCAN1;			//(map3 == map4) && 
				else if ((map2[position] == map4[position])) nextState = SCAN3;			//(~(map3 == map4)) || 
				else nextState = OFF4;
			end
			default: nextState = SCAN1;
		endcase
	end

	always_ff @(posedge clk, negedge reset) begin
		if (~reset) begin
			scan1EN <= 1;
			scan2EN <= 0;
			scan3EN <= 0;
			scan4EN <= 0;
			scanCountRST <= 1;
			debounceRST <= 0;
			displayEN <= 0;
		end
		else begin
			if (state == SCAN1) begin
				scan1EN <= 1;
				scan2EN <= 0;
				scan3EN <= 0;
				scan4EN <= 0;
				scanCountRST <= 1;
				debounceRST <= 0;
				displayEN <= 0;
			end else if (state == OFF1) begin
				scan1EN <= 0;
				scan2EN <= 0;
				scan3EN <= 0;
				scan4EN <= 0;
				scanCountRST <= 0;
				debounceRST <= 1;
				displayEN <= 0;
			end else if (state == SCAN2) begin
				scan1EN <= 0;
				scan2EN <= 1;
				scan3EN <= 0;
				scan4EN <= 0;
				scanCountRST <= 1;
				debounceRST <= 0;
				displayEN <= 0;
			end else if (state == OFF2) begin
				scan1EN <= 0;
				scan2EN <= 0;
				scan3EN <= 0;
				scan4EN <= 0;
				scanCountRST <= 0;
				debounceRST <= 0;
				displayEN <= 0;
			end else if (state == DISPLAY) begin
				scan1EN <= 0;
				scan2EN <= 0;
				scan3EN <= 0;
				scan4EN <= 0;
				scanCountRST <= 0;
				debounceRST <= 0;
				displayEN <= 1;
			end else if (state == SCAN3) begin
				scan1EN <= 0;
				scan2EN <= 0;
				scan3EN <= 1;
				scan4EN <= 0;
				scanCountRST <= 1;
				debounceRST <= 0;
				displayEN <= 0;
			end else if (state == OFF3) begin
				scan1EN <= 0;
				scan2EN <= 0;
				scan3EN <= 0;
				scan4EN <= 0;
				scanCountRST <= 0;
				debounceRST <= 1;
				displayEN <= 0;
			end else if (state == SCAN4) begin
				scan1EN <= 0;
				scan2EN <= 0;
				scan3EN <= 0;
				scan4EN <= 1;
				scanCountRST <= 1;
				debounceRST <= 0;
				displayEN <= 0;
			end else if (state == OFF4) begin
				scan1EN <= 0;
				scan2EN <= 0;
				scan3EN <= 0;
				scan4EN <= 0;
				scanCountRST <= 0;
				debounceRST <= 0;
				displayEN <= 0;
			end
		end
	end

endmodule