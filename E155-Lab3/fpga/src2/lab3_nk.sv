module lab3_nk(input logic reset,
                input logic [3:0] cols,
                output logic [1:0] anode,
                output logic [6:0] segWrite,
                output logic [3:0] rows);

    logic scanCLK,;
    logic [3:0] syncCols;

    // Set up the internal HSOSC to provide a 24MHz oscillation frequency output
	HSOSC #(.CLKHF_DIV("0b01")) 
		hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));

    // Synchronize column inputs
    synchronizer #(.WIDTH(4)) sync(clk, cols, syncCols);
    
    // Count till 16 = 4 scan cycles done
    freqconverter #(.WIDTH(5), .MAX(20)) scanCounter(clk, scanCountRST, 1'b1, scanCLK, scanCount);

    // Count till 120000 -> 10ms for debouncing
    freqconverter #(.WIDTH(19), .MAX(200000)) debounceCounter(clk, debounceRST, 1'b1, debounceCLK, debounce);

    // Scan at 3MHz -> bits oscillate at 6MHz
    scan #(.COUNTWIDTH(3), .COUNTMAX(4)) scanner(clk, reset, (scan1EN | scan2EN), rows);

    // Make keymap
    keyMapper initialMapper(clk, reset, scan1EN, rows, syncCols, initialMap);
    keyMapper finalMapper(clk, reset, scan2EN, rows, syncCols, finalMap);

    // FSM
    keypadFSM fsm(clk, reset, scanCount, debounce, initialMap, finalMap, scan1EN, scan2EN, scanCountRST, debounceRST, displayEN);

    // Get switches and segments
    keySwitchConverter getSwitches(finalMap, switches);
    switch_7seg getSeg(switches, seg);

    // Pushing the segments
    enableFlipFlop #(.WIDTH(7)) pushSegRight(clk, displayEN, seg, segRight);
    enableFlipFlop #(.WIDTH(7)) pushSegLeft(clk, displayEN, segRight, segLeft);

    assign anodeLeft = (debounceCount < 100000);
    assign anodeRight = (debounceCount >= 100000);

    assign segWrite = anodeLeft ? segRight : segLeft;

endmodule