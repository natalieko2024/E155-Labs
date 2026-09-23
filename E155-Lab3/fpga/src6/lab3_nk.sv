// Natalie Ko (nko@g.hmc.edu)
// Created on 18 Sept 2026
// Top level module to connect all submodules. Additional combinational logic to write the correct segments to each half of the display and control the display switching frequency.
module lab3_nk(input logic reset,
                input logic [3:0] cols,
                output logic [3:0] rows,
                output logic [1:0] anodes,
                output logic [6:0] segWrite);

    logic clk, displayEN, anodeClk;
    logic [3:0] syncCols, switches;
    logic [15:0] keyMap, debouncedKeyMap;
    logic [6:0] segs, segRight, segLeft;
    logic [32:0] anodeCount;
    
    // Set up the internal HSOSC to provide a 24MHz oscillation frequency output
	HSOSC #(.CLKHF_DIV("0b01")) 
		hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));

    // synchronize all asynchronous inputs (column inputs)
    synchronizer #(.WIDTH(4)) syncCol(clk, cols, syncCols);

    // Scan each row at 24kHz -> each row oscillates at 12kHz
    scan #(.COUNTWIDTH(9), .COUNTMAX(500)) scanner(clk, reset, 1'b1, rows);

    // Counter for the display anodes
    freqconverter #(.WIDTH(32), .MAX(200001)) anodeSwitcher(clk, reset, 1'b1, anodeClk, anodeCount);

    // Convert inputs to keymap
	keyMap  getMap(clk, reset, rows, syncCols, keyMap);

    // Debounce the keymap
    debouncer debounce(clk, reset, keyMap, debouncedKeyMap);

    // send debounced keymap to FSM
    keypadFSM mainFSM(clk, reset, debouncedKeyMap, displayEN);

    // convert debounced keymap to switches then to 7 segment outputs
    keySwitchConverter getSwitches(debouncedKeyMap, switches);

    switch_7seg getSegs(switches, segs);

    // seg is 1 clk behind segRight, segRight is 1 clk behind segLeft
    flipFlop #(7) shiftRight(clk, reset, displayEN, segs, segRight);
    flipFlop #(7) shiftLeft(clk, reset, displayEN, segRight, segLeft);

    // Display logic
    assign anodes[1] = (anodeCount < 100000);
    assign anodes[0] = (anodeCount >= 100000);

    assign segWrite = anodes[1] ? segRight : segLeft;

endmodule