module lab3_nk(input logic reset,
                input logic [3:0] cols,
                output logic [3:0] rows,
                output logic [6:0] seg,
                output logic anodeLeft, anodeRight);

    // Set up the internal HSOSC to provide a 24MHz oscillation frequency output
	HSOSC #(.CLKHF_DIV("0b01")) 
		hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));

    // scanning module to send the rotating scanning signal to keypad rows
	scan s1(stepDownClk, reset, (scan1EN || scan2EN), rows);

    freqconverter #(.MAX(80000), .WIDTH(17)) clock(clk, reset, enable, stepDownClk, countDontUse);
    freqconverter #(.MAX(1200000), .WIDTH(21)) counter(clk, countReset, enable, clkDontUse, count);

    synchronizer #(.WIDTH(4)) sync(stepDownClk, cols, syncCols);

    keyMapping  initialMapping(stepDownClk, reset, scan1EN, rows, syncCols, initialMap);
    keyMapping  finalMapping(stepDownClk, reset, scan2EN, rows, syncCols, finalMap);

    checkUnpressed      cu1(finalMap, checkCol);

    keypadFSM(stepDownClk, reset, syncCols, initialMap, finalMap, checkCol, count, state, scan1EN, scan2EN, displayEN, countReset);

    keySwitchConverter      mapSwitches(finalMap, switches);

    flipFlop #(.WIDTH(4)) findSegRight(stepDownClk, switches, switchRight);
    flipFlop #(.WIDTH(4)) findSegRight(stepDownClk, switchRight, switchLeft);

    // multiplexing counter module to write outputs at a frequency
	muxCounter mc1(clk, reset, 1'b1, 4'b0000, anodeLeft, anodeRight, switchLeftDontUse, switchRightDontUse);
	
	// Implement 7-segment mux for which side to write to
	assign switchWrite = anodeLeft? switchRight : switchLeft;
	
	// 7-segment module
	switch_7seg ss1(switchWrite, segWrite);
		
endmodule