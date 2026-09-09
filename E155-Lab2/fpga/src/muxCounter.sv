module muxCounter(input logic clk, reset, enable, switch
                  input logic [6:0] seg,
                  output logic anodeLeft, anodeRight,
                  output logic [6:0] segWrite);

    freqconverter #(.WIDTH = 23, .MAX = 3000000) oscillator(clk, reset, enable, stepDownClk);

    // conserve state for each segment based on switch
    // output switches between each anode and seg
    always_ff@(posedge stepDownClk, posedge reset) begin
        if (enable)
			if (~reset)	begin
                anodeLeft <= 0;
                anodeRight <= 1;
                segWrite <= 7'b0;
            end
			else begin
                anodeLeft <= nextAnodeLeft;
                anodeRight <= nextAnodeRight;
                if (anodeLeft) segWrite <= segLeft;
                else segWrite <= segRight;
            end
		else begin
            anodeLeft <= anodeLeft;
            anodeRight <= anodeRight;
        end
    end

    always_comb
        if (anodeLeft) begin
            nextAnodeLeft = 0;
            nextAnodeRight = 1;
            nextSeg = seg;
        end
        else begin
            nextAnodeLeft = 1;
            nextAnodeRight = 0;
            nextSeg = seg;
        end
    
endmodule