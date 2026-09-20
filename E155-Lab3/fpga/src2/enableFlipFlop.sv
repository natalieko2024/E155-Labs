module enableFlipFlop #(parameter WIDTH) (input logic clk, reset, enable,
                                            input logic [(WIDTH - 1):0] d,
                                            output logic [(WIDTH - 1):0] q);

    always_ff @(posedge clk, negedge reset) begin
        if (~reset) q <= 0;
		else if (enable) q <= d;
    end
    
endmodule