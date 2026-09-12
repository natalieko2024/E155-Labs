module scan(input logic clk, reset, enable,
			output logic [3:0] rows);
		
	logic stepDownClk;
	logic [23:0] countUp;
	
	// Use my counter module to step down 24MHz to 1Hz
	freqconverter #(.WIDTH(24), .MAX(12000000)) counter(clk, reset, enable, stepDownClk, countUp);
	
	// Assign statements based on the counter output to shift the bits of rows every 1/8 clock cycle
	
	assign rows[0] = (countUp >= 0) && (countUp <= 2999999);
	assign rows[1] = (countUp >= 3000000) && (countUp <= 5999999);
	assign rows[2] = (countUp >= 6000000) && (countUp <= 8999999);
	assign rows[3] = (countUp >= 9000000) && (countUp <= 11999999);
	
	
	 ////Update rows every 2Hz and if enable is high
	 ////Push the default value 4'b1000 if reset if low (active)
	 ////Otherwise keep the current value
	//always_ff @(posedge count, negedge reset) begin
		//if (~reset)	rows <= 4'b1000;
		//else if (enable) rows <= tempState;
	//end
	
	 ////Combinational logic to determine next state based on current scanning rows
	//always_comb
		//case(rows)
			//4'b1000: tempState = 4'b0100;
			//4'b0100: tempState = 4'b0010;
			//4'b0010: tempState = 4'b0001;
			//4'b0001: tempState = 4'b1000;
			//default: tempState = rows;
		//endcase
	
endmodule