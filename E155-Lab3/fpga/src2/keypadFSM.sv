module keypadFSM(input logic clk, reset,
                input logic [4:0] scanCount, 
				input logic [18:0] debounceCount,
                input logic [15:0] initialMap, finalMap,
                output logic scan1EN, scan2EN, scanCountRST, debounceRST, displayEN);

    logic [2:0] state, nextState;
    logic match, singleKey;
	logic highBit;

    assign match = (initialMap == finalMap);
    assign singleKey = (((finalMap != 0) && (finalMap & (finalMap - 1))) == 0);
	assign highBit = $clog2(finalMap);

    always_ff @(posedge clk, negedge reset) begin
        if (~reset) state <= 3'b000;
        else state <= nextState;
    end

    always_comb begin
        case(state)
            // RESET state
            3'b000: begin
                scan1EN = 1'b0;
                scan2EN = 1'b0;
                scanCountRST = 1'b0;
                debounceRST = 1'b0;
                displayEN = 1'b0;
                nextState = 3'b001;     // Move to SCAN1 state
            end

            // SCAN1 state
            3'b001: begin
                scan1EN = 1'b1;     // Start scanning
                scan2EN = 1'b0;
                scanCountRST = 1'b1;    // Start counting for scanning
                debounceRST = 1'b0;
                displayEN = 1'b0;
                if (scanCount >= 16) nextState = 3'b010;     // If we scan enough, move to OFF1 state
                else nextState = 3'b001;        // Else stay in SCAN1 state
            end

            // OFF1 state
            3'b010: begin
                scan1EN = 1'b0;     // Stop scanning
                scan2EN = 1'b0;
                scanCountRST = 1'b0;    // Stop counting for scanning, reset count to 0
                debounceRST = 1'b1;     // Start counting for debouncing
                displayEN = 1'b0;
                if (debounceCount >= 120000) nextState = 3'b011;     // When finished debouncing attempt, move to SCAN2 state
                else nextState = 3'b010;        // Else stay in OFF1 state
            end

            // SCAN2 state
            3'b011: begin
                scan1EN = 1'b0;
                scan2EN = 1'b1;     // Start scanning
                scanCountRST = 1'b1;    // Start counting for scanning
                debounceRST = 1'b0;     // Stop counting for debouncing, reset count to 0
                displayEN = 1'b0;
                if (scanCount >= 16) nextState = 3'b100;     // If we scan enough, move to OFF2 state
                else nextState = 3'b011;        // Else stay in SCAN2 state
            end

            // OFF2 state
            3'b100: begin
                scan1EN = 1'b0;
                scan2EN = 1'b0;     // Stop scanning
                scanCountRST = 1'b0;    // Stop counting for scanning, reset count to 0
                debounceRST = 1'b0;
                displayEN = 1'b0;
                if (match && singleKey) nextState = 3'b001;     // If successfully debounced and only 1 key pressed, move to DISPLAY state
                else if ((~match) || (~singleKey)) nextState = 3'b000;     // If either condition not fulfilled, go to RESET state
                else nextState = 3'b100;    // Else stay in OFF2 state
            end

            // DISPLAY state
            3'b101: begin
                scan1EN = 1'b0;
                scan2EN = 1'b0;
                scanCountRST = 1'b0;
                debounceRST = 1'b0;
                displayEN = 1'b1;   // Start shifting the display digits
                nextState = 3'b110;     // Move to SCAN3 state
            end

            // SCAN3 state
            3'b110: begin
                scan1EN = 1'b1;     // Start scanning, overwrite initialMap with current readings
                scan2EN = 1'b0;
                scanCountRST = 1'b1;    // Start counting to scan
                debounceRST = 1'b0;
                displayEN = 1'b0;   // Don't shift the display digits anymore
                if (scanCount >= 16) nextState = 3'b111;    // If finished counting, move to OFF3 state
                else nextState = 3'b110;    // Else stay in SCAN3 state
            end

            // OFF3 state
            3'b111: begin
                scan1EN = 1'b0;     // Stop scanning
                scan2EN = 1'b0;
                scanCountRST = 1'b0;    // Stop counting to scan, reset counter
                debounceRST = 1'b0;
                displayEN = 1'b0;
                if (finalMap[highBit] != initialMap[highBit]) nextState = 3'b000;    // If pressed key isn't pressed anymore, move to RESET state
                else nextState = 3'b111;    // Else stay in OFF3 state
            end

            default: begin
                scan1EN = 1'b0;
                scan2EN = 1'b0;
                scanCountRST = 1'b0;
                debounceRST = 1'b0;
                displayEN = 1'b0;
                nextState = 3'b000;     // Default to RESET state
            end
        endcase
    end

endmodule