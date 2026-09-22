module lab3_nk(input logic reset, 
                input logic [3:0] rows,
                output logic [3:0] cols,
                output logic [1:0] anodes,
                output logic [6:0] segWrite);

    logic [3:0] syncCols;
    logic scan1EN, scan2EN, scan3EN, scan4EN, scanRST, scanClk, debounceRST, debounceClk, displayEN;
    logic [12:0] scanCount;
    logic [18:0] debounceCount;
    logic [15:0] map1, map2, map3, map4;
    logic [3:0] position, switches;
    logic [6:0] seg, segRight, segLeft;

    // Set up the internal HSOSC to provide a 24MHz oscillation frequency output
	HSOSC #(.CLKHF_DIV("0b01")) 
		hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));

    // synchronize all cols
    synchronizer #(4) sync(clk, cols, syncCols);

    // make counters
    // count till 16 = 4 scan cycles done
    freqconverter #(13, 4801) scanCounter(clk, scanRST, ($onehot({scan1EN, scan2EN, scan3EN, scan4EN})), scanClk, scanCount);
    // count till 120000 -> 10ms for debounce
    freqconverter #(19, 200000) debounceCounter(clk, debounceRST, 1'b1, debounceClk, debounceCount);

    // make mappers
    keyMapper makeMap1(clk, reset, scan1EN, rows, syncCols, map1);
    keyMapper makeMap2(clk, reset, scan2EN, rows, syncCols, map2);
    keyMapper makeMap3(clk, reset, scan3EN, rows, syncCols, map3);
    keyMapper makeMap4(clk, reset, scan4EN, rows, syncCols, map4);

    // find high bit
    findHighBit findPosition(map4, position);

    //DISPLAY LOGIC
    keySwitchConverter getSwitches(map4, switches);

    switch_7seg convertSeg(switches, seg);

    enableFlipFlop #(7) shiftRight(clk, reset, displayEN, seg, segRight);
    enableFlipFlop #(7) shiftLeft(clk, reset, displayEN, segRight, segLeft);

    assign anodes[1] = (debounceCount < 100000);
    assign anodes[0] = (debounceCount >= 100000);

    assign segWrite = anodes[1] ? segRight : segLeft;

    // implement fsm
    keypadFSM fsm(clk, reset, scanCount, debounceCount, map1, map2, map3, map4, position, scan1EN, scan2EN, scan3EN, scan4EN, scanRST, debounceRST, displayEN);
    

endmodule