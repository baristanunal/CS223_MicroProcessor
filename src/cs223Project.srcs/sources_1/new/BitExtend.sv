`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2021 19:39:49
// Design Name: 
// Module Name: BitExtend
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module bitExtend(
    input [2:0] in,
    output [3:0] out
);
    assign out[0] = in[0];
    assign out[1] = in[1];
    assign out[2] = in[2];
    assign out[3] = 0;
endmodule