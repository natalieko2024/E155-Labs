module subBytes(input logic clk,
                input logic [127:0] a,
                output logic [127:0] y);

    logic [0:3][0:3][7:0] inputArray, outputArray;

    // input_to_state is(a, inputArray);

    // sbox_sync sbox0(inputArray[0][0][7:0], clk, outputArray[0][0][7:0]);
    // sbox_sync sbox1(inputArray[0][1][7:0], clk, outputArray[0][1][7:0]);
    // sbox_sync sbox2(inputArray[0][2][7:0], clk, outputArray[0][2][7:0]);
    // sbox_sync sbox3(inputArray[0][3][7:0], clk, outputArray[0][3][7:0]);

    // sbox_sync sbox4(inputArray[1][0][7:0], clk, outputArray[1][0][7:0]);
    // sbox_sync sbox5(inputArray[1][1][7:0], clk, outputArray[1][1][7:0]);
    // sbox_sync sbox6(inputArray[1][2][7:0], clk, outputArray[1][2][7:0]);
    // sbox_sync sbox7(inputArray[1][3][7:0], clk, outputArray[1][3][7:0]);

    // sbox_sync sbox8(inputArray[2][0][7:0], clk, outputArray[2][0][7:0]);
    // sbox_sync sbox9(inputArray[2][1][7:0], clk, outputArray[2][1][7:0]);
    // sbox_sync sbox10(inputArray[2][2][7:0], clk, outputArray[2][2][7:0]);
    // sbox_sync sbox11(inputArray[2][3][7:0], clk, outputArray[2][3][7:0]);

    // sbox_sync sbox12(inputArray[3][0][7:0], clk, outputArray[3][0][7:0]);
    // sbox_sync sbox13(inputArray[3][1][7:0], clk, outputArray[3][1][7:0]);
    // sbox_sync sbox14(inputArray[3][2][7:0], clk, outputArray[3][2][7:0]);
    // sbox_sync sbox15(inputArray[3][3][7:0], clk, outputArray[3][3][7:0]);

    // state_to_output os(outputArray, y);

    // 0
	sbox_sync sbox16(.a(state[127:120]), .clk(clk), .y(Sstate[127:120]));
	sbox_sync sbox15(.a(state[119:112]), .clk(clk), .y(Sstate[119:112]));
	sbox_sync sbox14(.a(state[111:104]), .clk(clk), .y(Sstate[111:104]));
	sbox_sync sbox13(.a(state[103:96]), .clk(clk), .y(Sstate[103:96]));
	
	// 1
	sbox_sync sbox12(.a(state[95:88]), .clk(clk), .y(Sstate[95:88]));
	sbox_sync sbox11(.a(state[87:80]), .clk(clk), .y(Sstate[87:80]));
	sbox_sync sbox10(.a(state[79:72]), .clk(clk), .y(Sstate[79:72]));
	sbox_sync sbox9(.a(state[71:64]), .clk(clk), .y(Sstate[71:64]));
	
	// 2
	sbox_sync sbox8(.a(state[63:56]), .clk(clk), .y(Sstate[63:56]));
	sbox_sync sbox7(.a(state[55:48]), .clk(clk), .y(Sstate[55:48]));
	sbox_sync sbox6(.a(state[47:40]), .clk(clk), .y(Sstate[47:40]));
	sbox_sync sbox5(.a(state[39:32]), .clk(clk), .y(Sstate[39:32]));
	
	// 3
	sbox_sync sbox4(.a(state[31:24]), .clk(clk), .y(Sstate[31:24]));
	sbox_sync sbox3(.a(state[23:16]), .clk(clk), .y(Sstate[23:16]));
	sbox_sync sbox2(.a(state[15:8]), .clk(clk), .y(Sstate[15:8]));
	sbox_sync sbox1(.a(state[7:0]), .clk(clk), .y(Sstate[7:0]));

endmodule