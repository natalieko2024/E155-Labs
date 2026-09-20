module lab3_nk(input logic reset,
                input logic [3:0] cols,
                output logic [1:0] anode,
                output logic [6:0] segWrite,
                output logic [3:0] rows, rowLEDs);

    logic clk, scanCLK, debounceCLK, scanCountRST, debounceRST, scan1EN, scan2EN, displayEN, tick;
    logic [3:0] syncCols, switches, switchRight, switchLeft, switchWrite;
	logic [4:0] scanCount, position;
	logic [18:0] debounce;
	logic [15:0] initialMap, finalMap;
	//logic [6:0] seg, segRight, segLeft;
	
	logic [2:0] state;
	assign rowLEDs = rows;
	// assign rowLEDs = {1'b1, state};

    // Set up the internal HSOSC to provide a 24MHz oscillation frequency output
	HSOSC #(.CLKHF_DIV("0b01")) 
		hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));

    // Synchronize column inputs
    synchronizer #(.WIDTH(4)) sync(clk, cols, syncCols);
    
    // Count till 16 = 4 scan cycles done
    freqconverter #(.WIDTH(5), .MAX(31)) scanCounter(clk, scanCountRST, 1'b1, scanCLK, scanCount);

    // Count till 120000 -> 10ms for debouncing
    freqconverter #(.WIDTH(19), .MAX(200000)) debounceCounter(clk, debounceRST, 1'b1, debounceCLK, debounce);

    // Scan at 3MHz -> bits oscillate at 6MHz
    scan #(.COUNTWIDTH(10), .COUNTMAX(24)) scanner(clk, reset, (scan1EN | scan2EN), rows, tick);

    // Make keymap
    keyMapper initialMapper(clk, reset, tick, scan1EN, rows, syncCols, initialMap);
    keyMapper finalMapper(clk, reset, tick, scan2EN, rows, syncCols, finalMap);
	
	findHighBit whichOneIsHigh(finalMap, position);

    // FSM
    keypadFSM fsm(clk, reset, scanCount, position, debounce, initialMap, finalMap, scan1EN, scan2EN, scanCountRST, debounceRST, displayEN, state);

    // Get switches and segments
    keySwitchConverter getSwitches(finalMap, switches);

    // Pushing the segments
    enableFlipFlop #(.WIDTH(4)) pushSegRight(clk, reset, displayEN, switches, switchRight);
    enableFlipFlop #(.WIDTH(4)) pushSegLeft(clk, reset, displayEN, switchRight, switchLeft);

    assign anode[1] = (debounce < 100000);
    assign anode[0] = (debounce >= 100000);

    assign switchWrite = anode[1] ? switchRight : switchLeft;
	switch_7seg getSeg(switchWrite, segWrite);

endmodule