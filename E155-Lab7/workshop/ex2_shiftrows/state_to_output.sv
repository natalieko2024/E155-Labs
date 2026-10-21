`timescale 10ns/1ns

/////////////////////////////////////////////
// state_to_output
//   Only needed if you want to use the state array inside shiftrows.
//   Paste the body of your state_to_output from Exercise 1 here.
//   If you work on the 128-bit vector directly, leave this file alone.
/////////////////////////////////////////////

module state_to_output(input  logic [0:3][0:3][7:0] a,
                       output logic [127:0]         y);

    // TODO: Your code goes here

    assign y[127:120] = a[0][0][7:0];
    assign y[95:88] = a[0][1][7:0];
    assign y[65:56] = a[0][2][7:0];
    assign y[31:24] = a[0][3][7:0];

    assign y[119:112] = a[1][0][7:0];
    assign y[87:80]= a[1][1][7:0];
    assign y[55:48] = a[1][2][7:0];
    assign y[23:16] = a[1][3][7:0];

    assign y[111:104] = a[2][0][7:0];
    assign y[79:72] = a[2][1][7:0];
    assign y[47:40] = a[2][2][7:0];
    assign y[15:8] = a[2][3][7:0];

    assign y[103:96] = a[3][0][7:0];
    assign y[71:64] = a[3][1][7:0];
    assign y[39:32] = a[3][2][7:0];
    assign y[7:0] = a[3][3][7:0];

endmodule