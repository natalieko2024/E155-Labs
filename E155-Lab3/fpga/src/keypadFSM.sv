module keypadFSM(input logic clk, reset,
                input logic [3:0] cols,
                input logic [15:0] initialMap, finalMap,
                input logic [3:0] checkCol,
                input logic [2:0] count1, 
                input logic [20:0] count2,
                output logic scan1EN, scan2EN, displayEN, count1Reset, count2Reset);

    logic [2:0] state, nextState;

    always_ff @(posedge clk, negedge reset) begin
        if (~reset) state <= 3'b000;
        else state <= nextState;
    end

    always_comb begin

        case(state)
            // RESET
            3'b000: begin
                scan1EN = 1'b0;
                scan2EN = 1'b0;
                displayEN = 1'b0;
                count1Reset = 1'b0;
                count2Reset = 1'b0;
                nextState = 3'b001;
            end

            // SCAN1
            3'b001: begin
                scan1EN = 1'b1;
                scan2EN = 1'b0;
                displayEN = 1'b0;
                count1Reset = 1'b1;
                count2Reset = 1'b0;
                if (count1 >= 3) nextState = 3'b010;
                else nextState = 3'b001;
            end

            // OFF1
            3'b010: begin
                scan1EN = 1'b0;
                scan2EN = 1'b0;
                displayEN = 1'b0;
                count1Reset = 1'b0;
                count2Reset = 1'b1;
                if (count2 >= 1199999) nextState = 3'b011;
                else nextState = 3'b010;
            end
            
            // SCAN2
            3'b011: begin
                scan1EN = 1'b0;
                scan2EN = 1'b1;
                displayEN = 1'b0;
                count1Reset = 1'b1;
                count2Reset = 1'b0;
                if (count1 >= 3) nextState = 3'b100;
                else nextState = 3'b011;
            end

            // OFF 2
            3'b100: begin
                scan1EN = 1'b0;
                scan2EN = 1'b0;
                displayEN = 1'b0;
                count1Reset = 1'b0;
                count2Reset = 1'b0;
                if (~(initialMap == finalMap) || ~$onehot(finalMap)) nextState = 3'b000;
                else if ((initialMap == finalMap) && $onehot(finalMap)) nextState = 3'b101;
                else nextState = 3'b100;
            end

            // DISPLAY
            3'b101: begin
                scan1EN = 1'b0;
                scan2EN = 1'b0;
                displayEN = 1'b1;
                count1Reset = 1'b0;
                count2Reset = 1'b0;
                nextState = 3'b110;
            end

            // HOLD
            3'b110: begin
                scan1EN = 1'b0;
                scan2EN = 1'b0;
                displayEN = 1'b0;
                count1Reset = 1'b0;
                count2Reset = 1'b0;
                if (~(checkCol && cols)) nextState = 3'b000;
                else nextState = 3'b110;
            end

            default: begin
                scan1EN = 1'b0;
                scan2EN = 1'b0;
                displayEN = 1'b0;
                count1Reset = 1'b1;
                count2Reset = 1'b0;
                nextState = 3'b000;
            end
        endcase
    end

endmodule