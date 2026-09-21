// use the 4x as fast clock (scanning clock)


module keyMapper(input logic clk, reset, enable,
                input logic [3:0] rows, cols,
                output logic [15:0] map);

    logic [15:0] newMap;

    always_ff @(posedge clk, negedge reset) begin
        if (~reset) map <= 16'b0;
        else if (enable) map <= newMap;
    end

    // If the particular row is high, write ~cols to newMap
    // (cols are active low, so ~cols will write 1 when the key is pressed)
    //assign newMap[3:0] = rows[0] ? ~cols : map[3:0];
    //assign newMap[7:4] = rows[1] ? ~cols : map[7:4];
    //assign newMap[11:8] = rows[2] ? ~cols : map[11:8];
    //assign newMap[15:12] = rows[3] ? ~cols : map[15:12];
	
	always_comb begin
		if (rows[0]) newMap[3:0] = ~cols;
		else if (rows[1]) newMap[7:4] = ~cols;
		else if (rows[2]) newMap[11:8] = ~cols;
		else if (rows[3]) newMap[15:12] = ~cols;
		else newMap = 16'b0;
	end

endmodule