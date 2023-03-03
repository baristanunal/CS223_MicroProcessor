`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2021 19:07:50
// Design Name: 
// Module Name: DataMemExt
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



module DataMemExt( input logic clk,
                   input logic reset,
                   input logic [3:0] inst30,
                   input logic M_re,
                   input logic M_we,
                   input logic [3:0] M_wd_next,
                   input logic M_add_clr,
                   input logic M_add_ld,
                   input logic M_wd_clr,
                   input logic M_wd_ld,
                   output logic [3:0] M_rd );
                   
    logic [3:0] M_add;
    logic [3:0] M_wd;
    
    
    flipFlop4 dataMemff1( inst30, clk, M_add_clr, M_add_ld, M_add );
    
    flipFlop4 dataMemff2( M_wd_next, clk, M_wd_clr, M_wd_ld, M_wd );
    
    DataMemory dm( clk, reset, M_add, M_wd, M_re, M_we, M_rd );

endmodule