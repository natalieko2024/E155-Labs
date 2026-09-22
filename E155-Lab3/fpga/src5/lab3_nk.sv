module lab3_nk(input logic reset,
                input logic [3:0] cols,
                output logic [3:0] rows,
                output logic [6:0] segWrite,
                output logic [1:0] anodes,
				output logic [1:0] state);

    logic clk, stepDownClk, countRST, countEN, anodeClk, scanEN, debounced, press, displayEN;
    logic [3:0] syncCols, syncRows, switches;
    //logic [31:0] count;
    logic [31:0] anodeCount;
    logic [15:0] keyMap, rightKeymap, leftKeymap;
    logic [6:0] seg, segRight, segLeft;

    // Set up the internal HSOSC to provide a 24MHz oscillation frequency output
	HSOSC #(.CLKHF_DIV("0b01")) 
		hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));

    synchronizer #(.WIDTH(4)) syncCol(clk, cols, syncCols);
    synchronizer #(.WIDTH(4)) syncRow(clk, rows, syncRows);

    //freqconverter #(.WIDTH(32), .MAX(1200000)) counter(clk, countRST, countEN, stepDownClk, count);

    freqconverter #(.WIDTH(32), .MAX(200001)) anodeSwitcher(clk, reset, 1'b1, anodeClk, anodeCount);

    debounceFSM debounce(clk, reset, keyMap, syncCols, debounced);

    keyMap mapKeys(clk, reset, syncRows, syncCols, keyMap, switches, press);

    mainFSM fsm(clk, reset, 1'b1, press, keyMap, rightKeymap, leftKeymap, displayEN, state);

    // max is 6MHz (cutting it close)
    scan #(.COUNTWIDTH(9), .COUNTMAX(500)) scanner(clk, reset, 1'b1, rows);

    switch_7seg getSeg(switches, seg);

    flop #(7) shiftRight(clk, reset, displayEN, seg, segRight);
    flop #(7) shiftLeft(clk, reset, displayEN, segRight, segLeft);

    assign anodes[1] = (anodeCount < 100000);
    assign anodes[0] = (anodeCount >= 100000);

    assign segWrite = anodes[1] ? segRight : segLeft;

endmodule