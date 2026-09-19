// flip flop
module flipFlop #(parameter WIDTH) (input logic clk, 
                                        input logic [WIDTH-1:0] d, 
                                        output logic [WIDTH-1:0] q);

    always_ff @(posedge clk) begin
        q <= d;
    end

endmodule