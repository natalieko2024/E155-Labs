`timescale 10ns/1ns

/////////////////////////////////////////////
// state_to_output
//   Copy the 4x4 state array back into a 128-bit value
//   Section 3.4
//   Purely combinational
//
//   The reverse of input_to_state, with the same packing. With both, a
//   module with 128-bit ports like the ones in aes_core can do its work
//   on rows and columns inside.
/////////////////////////////////////////////

module #(parameter NUMCOLS=4) state_to_output(input  logic [0:3][0:NUMCOLS-1][7:0] a,
                                                output logic [4*NUMCOLS-1:0]         y);

    // TODO: Your code goes here

    // genvar minimizes hardware as opposed to int -huanhuan (from SOC)
    genvar i;

    for (i = 0; i<NUMCOLS; i = i+1) begin
        assign y[(COL-1-i)*32+24 +: 8] = a[0][i][7:0];
        assign y[(COL-1-i)*32+16 +: 8] = a[1][i][7:0];
        assign y[(COL-1-i)*32+8 +: 8] = a[2][i][7:0];
        assign y[(COL-1-i)*32 +: 8] = a[3][i][7:0];
    end

    // assign y[127:120] = a[0][0][7:0];
    // assign y[95:88] = a[0][1][7:0];
    // assign y[65:56] = a[0][2][7:0];
    // assign y[31:24] = a[0][3][7:0];

    // assign y[119:112] = a[1][0][7:0];
    // assign y[87:80]= a[1][1][7:0];
    // assign y[55:48] = a[1][2][7:0];
    // assign y[23:16] = a[1][3][7:0];

    // assign y[111:104] = a[2][0][7:0];
    // assign y[79:72] = a[2][1][7:0];
    // assign y[47:40] = a[2][2][7:0];
    // assign y[15:8] = a[2][3][7:0];

    // assign y[103:96] = a[3][0][7:0];
    // assign y[71:64] = a[3][1][7:0];
    // assign y[39:32] = a[3][2][7:0];
    // assign y[7:0] = a[3][3][7:0];

endmodule