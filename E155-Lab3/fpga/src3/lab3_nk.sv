module lab3_nk(input logic reset,
                input logic [3:0] cols,
                output logic [3:0] rows,
                output logic [6:0] segWrite,
                output logic [1:0] anodes,
				output logic [1:0] state);

    logic clk, stepDownClk, countRST, countEN, anodeClk, scanEN;
    logic [3:0] syncCols, debouncedCols, rightSwitches, leftSwitches;
    logic [31:0] count;
    logic [31:0] anodeCount;
    logic [15:0] keymap, rightKeymap, leftKeymap;
    logic [6:0] rightSeg, leftSeg;

    // Set up the internal HSOSC to provide a 24MHz oscillation frequency output
	HSOSC #(.CLKHF_DIV("0b01")) 
		hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));

    synchronizer #(.WIDTH(4)) sync(clk, cols, syncCols);

    freqconverter #(.WIDTH(32), .MAX(1200000)) counter(clk, countRST, countEN, stepDownClk, count);

    freqconverter #(.WIDTH(32), .MAX(200000)) anodeSwitcher(clk, reset, 1'b1, anodeClk, anodeCount);

    debouncer debounce(clk, reset, syncCols, count, countRST, countEN, debouncedCols);

    keyMapper mapKeys(clk, reset, 1'b1, rows, syncCols, keymap);

    mapFSM fsm(clk, reset, keymap, scanEN, rightKeymap, leftKeymap, state);

    // max is 6MHz (cutting it close)
    scan #(.COUNTWIDTH(9), .COUNTMAX(500)) scanner(clk, reset, scanEN, rows);

    keySwitchConverter getRightSwitches(rightKeymap, rightSwitches);
    keySwitchConverter getLeftSwtiches(leftKeymap, leftSwitches);

    switch_7seg getRightSeg(rightSwitches, rightSeg);
    switch_7seg getLeftSeg(leftSwitches, leftSeg);

    assign anodes[1] = (anodeCount < 100000);
    assign anodes[0] = (anodeCount >= 100000);

    assign segWrite = anodes[1] ? rightSeg : leftSeg;

endmodule