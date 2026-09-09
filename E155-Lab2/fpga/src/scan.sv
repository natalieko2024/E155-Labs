module scan(input logic clk, reset, enable
			output logic [3:0] rows);
	
	// Use my counter module to step down 24MHz to 2Hz
	freqconverter #(.WIDTH = 23, MAX = 6000000) counter(clk, reset, enable, count)
	
	always_ff @(posedge count) begin
		if (enable)
			if (reset)	tempState <= 4'b1000;
			else		tempState <= rows;
		else tempState <= tempState;
	end
	
	always_comb
		case(state)
			4'b1000: rows = 4'b0100;
			4'b0100: rows = 4'b0010;
			4'b0010: rows = 4'b0001;
			4'b0001: rows = 4'b1000;
			default: rows = tempState;
		endcase
	
endmodule