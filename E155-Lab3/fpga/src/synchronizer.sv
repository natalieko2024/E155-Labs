// 2 flip flop together
module synchronizer #(parameter WIDTH) (input logic clk, 
                                        input logic [WIDTH-1:0] d, 
                                        output logic [WIDTH-1:0] q);

    always_ff @(posedge clk) begin
        n1 <= d; 
        q <= n1;
    end

endmodule