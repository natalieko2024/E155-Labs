module debounceFSM(input logic clk, reset, 
                input logic [15:0] keyMap,
                input logic [3:0] cols,
                output logic debounced);

    typedef enum logic [1:0] {IDLE = 2'b00, WAIT = 2'b01, PRESS = 2'b10} statetype;
    statetype state, nextState;

    logic counterRST, counterEN, countClk;
    logic [20:0] count;

    freqconverter #(21,1200001) debounceCounter(clk, counterRST, counterEN, countClk, count);

    always_ff @(posedge clk, negedge reset) begin
        if (~reset) state <= IDLE;
        else state <= nextState;
    end

    always_comb begin
        case(state)
        IDLE: nextState = (keyMap == 0) ? IDLE : WAIT;

        WAIT: begin
            if (keyMap == 0) nextState = IDLE;
            else if (count >= 1200000) nextState = PRESS;
            else nextState = WAIT;
        end

        PRESS: nextState = (keyMap == 0) ? IDLE : PRESS;

        default: nextState = IDLE;
    end

    assign debounced = (state == PRESS);
    assign counterRST = ~((state == IDLE) | (~reset) | (count >= 1200000));
    assign counterEN = (state == WAIT);

endmodule