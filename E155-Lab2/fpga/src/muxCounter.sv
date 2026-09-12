module muxCounter(input logic clk, reset, enable,
                  input logic [7:0] s,
                  output logic anodeLeft, anodeRight,
                  output logic [3:0] switchLeft, switchRight);

	logic stepDownClk, nextAnodeLeft, nextAnodeRight;

    freqconverter #(.WIDTH(23), .MAX(100000)) oscillator(clk, reset, enable, stepDownClk);

    // Switch which 7-seg to write to every rising clock edge and write to it
    always_ff @(posedge stepDownClk, negedge reset) begin
        if (~reset)	begin
			anodeLeft <= 1'b1;
			anodeRight <= 1'b0;
		end 
		else if (enable) begin 
			anodeLeft <= nextAnodeLeft;
			anodeRight <= nextAnodeRight;
		end
    end

    // Set up next state of anode toggle, always going to invert it
    // Save the 7-segment output for each side
    always_comb begin 
		nextAnodeLeft = anodeRight;
		nextAnodeRight = anodeLeft;
		switchLeft = s[7:4];
		switchRight = s[3:0];
	end
    
endmodule


/*
     if (anodeLeft) begin
            nextAnodeLeft = 0;
            nextAnodeRight = 1;
        end
        else begin
            nextAnodeLeft = 1;
            nextAnodeRight = 0;
        end */