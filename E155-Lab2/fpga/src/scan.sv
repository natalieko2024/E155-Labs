module scan(input logic clk, reset, enable,
			output logic [3:0] rows);
		
	logic count;
	logic [3:0] tempState;
	
	// Use my counter module to step down 24MHz to 2Hz
	freqconverter #(.WIDTH(23), .MAX(6000000)) counter(clk, reset, enable, count);
	
	// Update rows every 2Hz and if enable is high
	// Push the default value 4'b1000 if reset if low (active)
	// Otherwise keep the current value
	always_ff @(posedge count, negedge reset) begin
		if (~reset)	rows <= 4'b1000;
		else if (enable) rows <= tempState;
	end
	
	// Combinational logic to determine next state based on current scanning rows
	always_comb
		case(rows)
			4'b1000: tempState = 4'b0100;
			4'b0100: tempState = 4'b0010;
			4'b0010: tempState = 4'b0001;
			4'b0001: tempState = 4'b1000;
			default: tempState = rows;
		endcase
	
endmodule