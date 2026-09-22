module lab3_nk(input logic reset,
                input logic [3:0] cols,
                output logic [3:0] rows,
                output logic [1:0] anodes,
                output logic [6:0] segWrite);

    logic clk, displayEN, anodeClk, row0Clk, row1Clk, row2Clk, row3Clk;
    logic [3:0] syncCols, switches;
    logic [15:0] keyMap, debouncedKeyMap;
    logic [6:0] segs, segRight, segLeft;
    logic [32:0] anodeCount;
    logic [8:0] row0Count, row1Count, row2Count, row3Count;
    
    // Set up the internal HSOSC to provide a 24MHz oscillation frequency output
	HSOSC #(.CLKHF_DIV("0b01")) 
		hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));

    synchronizer #(.WIDTH(4)) syncCol(clk, cols, syncCols);

    scan #(.COUNTWIDTH(9), .COUNTMAX(500)) scanner(clk, reset, 1'b1, rows);

    freqconverter #(.WIDTH(32), .MAX(200001)) anodeSwitcher(clk, reset, 1'b1, anodeClk, anodeCount);
    freqconverter #(.WIDTH(9), .MAX(500)) trackRow1(clk, (rows[0]), 1'b1, row1Clk, row1Count);
    freqconverter #(.WIDTH(9), .MAX(500)) trackRow2(clk, (rows[1]), 1'b1, row2Clk, row2Count);
    freqconverter #(.WIDTH(9), .MAX(500)) trackRow3(clk, (rows[2]), 1'b1, row3Clk, row3Count);
    freqconverter #(.WIDTH(9), .MAX(500)) trackRow0(clk, (rows[3]), 1'b1, row0Clk, row0Count);

    //keyMap  getMap(clk, reset, rows, syncCols, keyMap);
    keyMapper getMap(clk, reset, 1'b1, rows, syncCols, row0Count, row1Count, row2Count, row3Count, keyMap);

    debouncer debounce(clk, reset, keyMap, debouncedKeyMap);

    keypadFSM mainFSM(clk, reset, debouncedKeyMap, displayEN);

    keySwitchConverter getSwitches(debouncedKeyMap, switches);

    switch_7seg getSegs(switches, segs);

    flipFlop #(7) shiftRight(clk, reset, displayEN, segs, segRight);
    flipFlop #(7) shiftLeft(clk, reset, displayEN, segRight, segLeft);

    assign anodes[1] = (anodeCount < 100000);
    assign anodes[0] = (anodeCount >= 100000);

    assign segWrite = anodes[1] ? segRight : segLeft;

endmodule