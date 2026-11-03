module aesFSM(input  logic         clk, 
              input  logic         load,
              input  logic [127:0] key, plaintext, out, selectedKey,
              output logic [1:0] stateD,
              output logic [3:0] round,
              output logic [127:0] in, oldKey);

    typedef enum logic [1:0] {START, DELAY, CONTINUE, DONE} statetype;
    statetype state, nextState;

    always_ff @(posedge clk) begin
        if (load) begin
            round <= 0;
            in <= plaintext;
            oldKey <= key;
            state <= START;
        end
        else if ((state == DELAY) || (state == DONE)) begin
            state <= nextState;
        end
        else begin
            round <= round + 4'b1;
            in <= out;
            oldKey <= selectedKey;
            state <= nextState;
        end
    end

    always_comb begin
        case(state)
            START: begin nextState = DELAY; stateD = 2'b00; end
            DELAY: begin nextState = (round >= 4'd10) ? DONE : CONTINUE; stateD = 2'b01; end
            CONTINUE: begin nextState = DELAY; stateD = 2'b10;  end
            DONE: begin nextState = DONE; stateD = 2'b11; end
            default: begin nextState = START;  stateD = 2'b00;  end
        endcase
    end

endmodule