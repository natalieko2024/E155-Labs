// use the 4x as fast clock (scanning clock)


module keyMapper(input logic clk, reset, enable,
                input logic [3:0] rows, cols,
                input logic [8:0] row0Count, row1Count, row2Count, row3Count,
                output logic [15:0] map);

    logic [15:0] newMap, tempMap;
	
	assign tempMap = newMap;

    always_ff @(posedge clk, negedge reset) begin
        if (~reset) map <= 16'b0;
        else if (enable) map <= newMap;
    end

    // If the particular row is high, write ~cols to newMap
    // (cols are active low, so ~cols will write 1 when the key is pressed)
	
	always_comb begin
		if (rows[0]) newMap = {tempMap[15:4], ~cols};	// && (row0Count == 100)
		else if (rows[1]) newMap = {tempMap[15:8], ~cols, tempMap[3:0]};	// && (row1Count == 100)
		else if (rows[2]) newMap = {tempMap[15:12], ~cols, tempMap[7:0]};	// && (row2Count == 100)
		else if (rows[3]) newMap = {~cols, tempMap[11:0]};	// && (row3Count == 100)
		else newMap = 16'b0;
	end

endmodule