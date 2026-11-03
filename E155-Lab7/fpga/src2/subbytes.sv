module subBytes(input logic clk,
                input logic [127:0] a,
                output logic [127:0] y);

    logic [0:3][0:3][7:0] inputArray, outputArray;

    input_to_state is(a, inputArray);

    sbox_sync sbox0(inputArray[0][0][7:0], clk, outputArray[0][0][7:0]);
    sbox_sync sbox1(inputArray[0][1][7:0], clk, outputArray[0][1][7:0]);
    sbox_sync sbox2(inputArray[0][2][7:0], clk, outputArray[0][2][7:0]);
    sbox_sync sbox3(inputArray[0][3][7:0], clk, outputArray[0][3][7:0]);

    sbox_sync sbox0(inputArray[1][0][7:0], clk, outputArray[1][0][7:0]);
    sbox_sync sbox1(inputArray[1][1][7:0], clk, outputArray[1][1][7:0]);
    sbox_sync sbox2(inputArray[1][2][7:0], clk, outputArray[1][2][7:0]);
    sbox_sync sbox3(inputArray[1][3][7:0], clk, outputArray[1][3][7:0]);

    sbox_sync sbox0(inputArray[2][0][7:0], clk, outputArray[2][0][7:0]);
    sbox_sync sbox1(inputArray[2][1][7:0], clk, outputArray[2][1][7:0]);
    sbox_sync sbox2(inputArray[2][2][7:0], clk, outputArray[2][2][7:0]);
    sbox_sync sbox3(inputArray[2][3][7:0], clk, outputArray[2][3][7:0]);

    sbox_sync sbox0(inputArray[3][0][7:0], clk, outputArray[3][0][7:0]);
    sbox_sync sbox1(inputArray[3][1][7:0], clk, outputArray[3][1][7:0]);
    sbox_sync sbox2(inputArray[3][2][7:0], clk, outputArray[3][2][7:0]);
    sbox_sync sbox3(inputArray[3][3][7:0], clk, outputArray[3][3][7:0]);

    state_to_output os(outputArray, y);

endmodule