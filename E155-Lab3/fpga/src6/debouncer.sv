// Natalie Ko (nko@g.hmc.edu)
// Created on 18 Sept 2026
// The module debouncer only outputs a keymap when all keys have been debounced.
module debouncer (input logic clk, reset,
                input logic [15:0] keyMap,
                output logic [15:0] debouncedKeyMap);

    logic [15:0] keyMap0, keyMap1, keyMap2, keyMap3, keyMap4, keyMap5, keyMap6, keyMap7, keyMap8;

    // Make a shift register
    flipFlop #(16) flop0(clk, reset, 1'b1, keyMap, keyMap0);
    flipFlop #(16) flop1(clk, reset, 1'b1, keyMap0, keyMap1);
    flipFlop #(16) flop2(clk, reset, 1'b1, keyMap1, keyMap2);
    flipFlop #(16) flop3(clk, reset, 1'b1, keyMap2, keyMap3);
    flipFlop #(16) flop4(clk, reset, 1'b1, keyMap3, keyMap4);
    flipFlop #(16) flop5(clk, reset, 1'b1, keyMap4, keyMap5);
    flipFlop #(16) flop6(clk, reset, 1'b1, keyMap5, keyMap6);
    flipFlop #(16) flop7(clk, reset, 1'b1, keyMap6, keyMap7);
    flipFlop #(16) flop8(clk, reset, 1'b1, keyMap7, keyMap8);

    // Check that the bits in the output of each flop is equal before assigning that bit to the output map
    always_ff @(posedge clk, negedge reset) begin
        if (~reset) debouncedKeyMap <= 0;
        else begin
            for (int i = 0; i<16; i = i+1) begin
                if ((keyMap0[i] == keyMap1[i]) && (keyMap1[i] == keyMap2[i]) && (keyMap2[i] == keyMap3[i]) && (keyMap3[i] == keyMap4[i]) && (keyMap4[i] == keyMap5[i]) && (keyMap5[i] == keyMap6[i]) && (keyMap6[i] == keyMap7[i]) && (keyMap7[i] == keyMap8[i])) debouncedKeyMap[i] <= keyMap0[i];
            end
        end
    end

endmodule