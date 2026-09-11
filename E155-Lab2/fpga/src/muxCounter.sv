module muxCounter(input logic clk, reset, enable,
                  input logic [7:0] s,
                  output logic anodeLeft, anodeRight,
                  output logic [3:0] switchWrite);

    logic [3:0] switchLeft, switchRight;
	logic stepDownClk, nextAnodeLeft, nextAnodeRight;

    freqconverter #(.WIDTH(23), .MAX(3000000)) oscillator(clk, reset, enable, stepDownClk);

    // Switch which 7-seg to write to every rising clock edge and write to it
    always_ff @(posedge stepDownClk, negedge reset) begin
        if (~reset)	begin
			anodeLeft <= 1;
			anodeRight <= 0;
			switchWrite <= 4'b0;
		end 
		else if (enable) begin 
			anodeLeft <= nextAnodeLeft;
			anodeRight <= nextAnodeRight;
			if (anodeLeft) switchWrite <= switchLeft;
			else switchWrite <= switchRight;
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
        if (s >= 8'b00010000) begin
			switchLeft = s[7:4];
		end
        else begin 
			switchRight = s[3:0];
		end
	end
    
endmodule