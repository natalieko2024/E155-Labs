// Natalie Ko (nko@g.hmc.edu)
// Created on 18 Sept 2026
// The module keySwitchConverter turns the map into the corresponding switch inputs so that the key presses display the correct number.
module keySwitchConverter(input logic [15:0] map,
                            output logic [3:0] switches);

    always_comb begin
        case(map)
            16'b1000000000000000: switches = 4'b0001;   // row[3] and col[3] = 1
            16'b0100000000000000: switches = 4'b0010;   // row[3] and col[2] = 2
            16'b0010000000000000: switches = 4'b0011;   // row[3] and col[1] = 3
            16'b0001000000000000: switches = 4'b1010;   // row[3] and col[0] = A
            16'b0000100000000000: switches = 4'b0100;   // row[2] and col[3] = 4
            16'b0000010000000000: switches = 4'b0101;   // row[2] and col[2] = 5
            16'b0000001000000000: switches = 4'b0110;   // row[2] and col[1] = 6
            16'b0000000100000000: switches = 4'b1011;   // row[2] and col[0] = B
            16'b0000000010000000: switches = 4'b0111;   // row[1] and col[3] = 7
            16'b0000000001000000: switches = 4'b1000;   // row[1] and col[2] = 8
            16'b0000000000100000: switches = 4'b1001;   // row[1] and col[1] = 9
            16'b0000000000010000: switches = 4'b1100;   // row[1] and col[0] = C
            16'b0000000000001000: switches = 4'b1110;   // row[0] and col[3] = E
            16'b0000000000000100: switches = 4'b0000;   // row[0] and col[2] = 0
            16'b0000000000000010: switches = 4'b1111;   // row[0] and col[1] = F
            16'b0000000000000001: switches = 4'b1101;   // row[0] and col[0] = D
			default: switches = 4'b0000;
        endcase
    end

endmodule