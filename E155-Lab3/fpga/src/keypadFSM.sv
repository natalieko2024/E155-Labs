module keypadFSM(input logic clk, reset,
                input logic [3:0] cols,
                input logic [15:0] initialMap, finalMap,
                input logic [3:0] checkCol,
                input logic [20:0] count,
                output logic [2:0] state,
                output logic scan1EN, scan2EN, displayEN, countReset);

    logic [1:0] nextState;

    always_ff @(posedge clk, negedge reset) begin
        if (~reset) state <= 3'b000;
        else state <= nextState;
    end

    always_comb begin

        case(state)
            3'b000: begin
                scan1EN = 1'b0;
                scan2EN = 1'b0;
                displayEN = 1'b0;
                countReset = 1'b1;
                nextState = 3'b001;
            end

            3'001: begin
                scan1EN = 1'b1;
                scan2EN = 1'b0;
                displayEN = 1'b0;
                countReset = 1'b0;
                if (count >= 1199999) nextState = 3'b001;
                else nextState = 3'b000;
            end

            3'b010: begin
                scan1EN = 1'b0;
                scan2EN = 1'b1;
                displayEN = 1'b0;
                countReset = 1'b0;
                if (~(initialMap == finalMap) || ~$onehot(finalMap)) nextState = 3'b000;
                else if ((initialMap == finalMap) && $onehot(finalMap)) nextState = 3'b011;
                else nextState = 3'b010;
            end

            3'b011: begin
                scan1EN = 1'b0;
                scan2EN = 1'b0;
                displayEN = 1'b1;
                countReset = 1'b0;
                nextState = 3'b100;
            end

            3'b100: begin
                scan1EN = 1'b0;
                scan2EN = 1'b0;
                displayEN = 1'b0;
                countReset = 1'b0;
                if ~(checkCol & cols) nextState = 3'b000;
                else nextState = 3'b100;
            end

            default: begin
                scan1EN = 1'b0;
                scan2EN = 1'b0;
                displayEN = 1'b0;
                countReset = 1'b1;
                nextState = 3'b000;
            end
        endcase
    end

endmodule