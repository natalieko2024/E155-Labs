module controlenables(input logic [4:0] count,
                    input logic clk, reset,
                    output logic subByteEnable, shiftRowEnable, mixColEnable, addRoundKeyEnable, keyExpEnable, newStateEnable, countEnable);

    always_ff @(posedge clk, reset) begin
        if (reset) begin
            subByteEnable <= 0;
            shiftRowEnable <= 0;
            mixColEnable <= 0;
            addRoundKeyEnable <= 0;
            newStateEnable <= 0;
            countEnable <= 0;
            keyExpEnable <= 0;
        end
        else begin
            subByteEnable <= (count < 16);
            shiftRowEnable <= (count == 16);
            mixColEnable <= (count == 17);
            addRoundKeyEnable <= (count == 18);
            newStateEnable <= (count == 19);
            countEnable <= (count == 20);

            // ok as long as it doesnt start later than 4 cycles left (bc 4 cycle latency)
            keyExpEnable <= (count < 12);
        end
    end

endmodule