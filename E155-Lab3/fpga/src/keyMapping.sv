module keyMapping(input logic clk, reset, enable,
                input logic [3:0] rows, cols,
                output logic [15:0] map);
				
	logic [15:0] newMap;

    always_ff@(posedge clk, negedge reset) begin
        if (~reset) map <= 16'b1111111111111111;
        else if (enable) map <= newMap;
    end
	
	assign newMap[3:0] = rows[0] ? ~cols : 4'b0;
	assign newMap[7:4] = rows[1] ? ~cols : 4'b0;
	assign newMap[11:8] = rows[2] ? ~cols : 4'b0;
	assign newMap[15:12] = rows[3] ? ~cols : 4'b0;

endmodule
