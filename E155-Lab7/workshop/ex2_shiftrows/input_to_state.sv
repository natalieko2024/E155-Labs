`timescale 10ns/1ns

/////////////////////////////////////////////
// input_to_state
//   Only needed if you want to use the state array inside shiftrows.
//   Paste the body of your input_to_state from Exercise 1 here.
//   If you work on the 128-bit vector directly, leave this file alone.
/////////////////////////////////////////////

module input_to_state(input  logic [127:0]         a,
                      output logic [0:3][0:3][7:0] y);

    assign y[0][0][7:0] = a[127:120];
    assign y[0][1][7:0] = a[95:88];
    assign y[0][2][7:0] = a[65:56];
    assign y[0][3][7:0] = a[31:24];

    assign y[1][0][7:0] = a[119:112];
    assign y[1][1][7:0] = a[87:80];
    assign y[1][2][7:0] = a[55:48];
    assign y[1][3][7:0] = a[23:16];

    assign y[2][0][7:0] = a[111:104];
    assign y[2][1][7:0] = a[79:72];
    assign y[2][2][7:0] = a[47:40];
    assign y[2][3][7:0] = a[15:8];

    assign y[3][0][7:0] = a[103:96];
    assign y[3][1][7:0] = a[71:64];
    assign y[3][2][7:0] = a[39:32];
    assign y[3][3][7:0] = a[7:0];

endmodule