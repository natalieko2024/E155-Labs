// Natalie Ko (nko@g.hmc.edu)
// Created on 18 Sept 2026
// A synchronizer is 2 flip flops in series. Prevent metastability!
module synchronizer #(parameter WIDTH) (input logic clk,
                                        input logic [(WIDTH - 1): 0] d,
                                        output logic [(WIDTH - 1): 0] q);

    logic [(WIDTH - 1): 0] n1;

    always_ff @(posedge clk) begin
        n1 <= d;
        q <= n1;
    end

endmodule