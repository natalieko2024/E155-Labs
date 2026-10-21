// Natalie Ko (nko@g.hmc.edu)
// Created on 18 Sept 2026
// This is a flip flop. I just made it a parametrized module so I don't have to make a new one every time.
module flopEN #(parameter WIDTH=1) (input logic clk, reset, enable,
                                            input logic [(WIDTH - 1):0] d,
                                            output logic [(WIDTH - 1):0] q);

    always_ff @(posedge clk, reset) begin
        if (reset) q <= 0;
		else if (enable) q <= d;
    end
    
endmodule