module muxCounter(input logic clk, reset, enable, switch,
                  input logic [6:0] seg,
                  output logic anodeLeft, anodeRight,
                  output logic [6:0] segWrite);

    logic [6:0] segLeft, segRight;
	logic stepDownClk, nextAnodeLeft, nextAnodeRight;

    freqconverter #(.WIDTH(23), .MAX(3000000)) oscillator(clk, reset, enable, stepDownClk);

    // Switch which 7-seg to write to every rising clock edge and write to it
    always_ff @(posedge stepDownClk, posedge reset) begin
        //if (~reset)	begin
			//anodeLeft <= 1;
			//anodeRight <= 0;
			//segWrite <= 7'b0;
		//end 
		//else 
		if (enable) begin 
			anodeLeft <= nextAnodeLeft;
			anodeRight <= nextAnodeRight;
			//if (anodeLeft) segWrite <= segLeft;
			//else segWrite <= segRight;
		end
    end

    // Set up next state of anode toggle, always going to invert it
    // Save the 7-segment output for each side
    always_comb begin 
        if (anodeLeft) begin
            nextAnodeLeft = 0;
            nextAnodeRight = 1;
        end
        else begin
            nextAnodeLeft = 1;
            nextAnodeRight = 0;
        end
        if (switch) begin
			segLeft = seg;
		end
        else begin 
			segRight = seg;
		end
	end
    
endmodule