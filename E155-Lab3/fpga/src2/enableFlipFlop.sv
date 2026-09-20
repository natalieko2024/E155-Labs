module enableFlipFlop #(parameter WIDTH) (input logic clk, enable,
                                            input logic [(WIDTH - 1): 0] d,
                                            output logic [(WIDTH - 1): 0] q);

    always_ff @(posedge clk) begin
        if (enable) q <= d;
    end
    
endmodule