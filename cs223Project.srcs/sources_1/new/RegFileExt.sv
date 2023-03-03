`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2021 19:07:50
// Design Name: 
// Module Name: RegFileExt
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



module RegFileExt( input logic clk,
                   input logic reset,
                   input logic [11:0] inst,
                   input logic RF_we,
                   input logic [3:0] RF_wd_next,
                   input logic RF_add1_clr, 
                   input logic RF_add1_ld,
                   input logic RF_add2_clr, 
                   input logic RF_add2_ld,
                   input logic RF_wa_clr, 
                   input logic RF_wa_ld,
                   input logic RF_wd_clr, 
                   input logic RF_wd_ld,
                   output logic [3:0] RF_d1,
                   output logic [3:0] RF_d2 );
    
    logic [2:0] add2_in;
    logic [2:0] wa_in;
    logic muxlow_sel;
    
    logic [2:0] RF_add1;
    logic [2:0] RF_add2;
    logic [2:0] RF_wa;
    logic [3:0] RF_wd;
    
    assign muxlow_sel = ( inst[11] | inst[10] );
        
    assign add2_in = inst[10] ? inst[2:0] : inst[6:4];
    
    assign wa_in = muxlow_sel ? inst[8:6] : inst[6:4];
    
    // RF_add1 Register:
    flipFlop3 ffAdd1( inst[5:3], clk, RF_add1_clr, RF_add1_ld, RF_add1 );   
    
    // RF_add2 Register:
    flipFlop3 ffAdd2( add2_in, clk, RF_add2_clr, RF_add2_ld, RF_add2 );
    
    // RF_wa Register:
    flipFlop3 ffWa( wa_in, clk, RF_wa_clr, RF_wa_ld, RF_wa );
       
    // RF_wd Register:
    flipFlop4 ffWd( RF_wd_next, clk, RF_wd_clr, RF_wd_ld, RF_wd );
    
    // Register File module call:
    RegFile rf( clk, reset, RF_add1, RF_add2, RF_wa, RF_we, RF_wd, RF_d1, RF_d2 );
    
endmodule