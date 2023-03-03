`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2021 19:07:50
// Design Name: 
// Module Name: Datapath
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


module DataPath( input logic clk,
                 input logic reset,
                 input logic [11:0] inst,
                 input logic M_wd_clr,
                 input logic M_wd_ld,
                 input logic M_we,
                 input logic M_add_clr,
                 input logic M_add_ld,
                 input logic M_re,
                 input logic RF_add1_clr,
                 input logic RF_add1_ld,
                 input logic RF_add2_clr,
                 input logic RF_add2_ld,
                 input logic RF_wd_clr,
                 input logic RF_wd_ld,
                 input logic RF_wa_clr,
                 input logic RF_wa_ld,
                 input logic RF_we,
                 input logic A_clr,
                 input logic A_ld,
                 input logic B_clr,
                 input logic B_ld,
                 input logic out_clr,
                 input logic out_ld,
                 input logic ALU_op,
                 input logic ALU_src_sel,
                 input logic const_clr,
                 input logic const_ld,
                 input logic reg_wr_sel,
                 output logic EQ,
                 output logic [3:0] A,
                 output logic [3:0] B,
                 output logic [3:0] out );
    
    logic [3:0] M_rd;
    logic [3:0] ALU_out;
    logic [3:0] RF_wd_next;
    logic [3:0] RF_d1;
    logic [3:0] RF_d2;
    logic [3:0] const4bit;
    logic [3:0] const_cur;
    logic [3:0] ALU_src_in;

    // Data memory:
    DataMemExt dmExt( clk, reset, inst[3:0], M_re, M_we, RF_d2, M_add_clr, M_add_ld, M_wd_clr, M_wd_ld, M_rd );

    // Mux after the data memory (reg_wr_sel):
    assign RF_wd_next = reg_wr_sel ? ALU_out : M_rd;

    // Register File:
    RegFileExt rfExt( clk, reset, inst, RF_we, RF_wd_next, RF_add1_clr, RF_add1_ld,
                      RF_add2_clr, RF_add2_ld, RF_wa_clr, RF_wa_ld, RF_wd_clr, RF_wd_ld,
                      RF_d1, RF_d2 );
    
    // Extending three bits to four for constant:                
    bitExtend bitExt( inst[2:0], const4bit );                
    
    // Constant Register:
    flipFlop4 ffConst( const4bit, clk, const_clr, const_ld, const_cur );
    
    // Mux before ALU (ALU_src_sel):
    assign ALU_src_in = ALU_src_sel ? const_cur : RF_d2;                                 
      
     // A Register:
    flipFlop4 ffA( RF_d1, clk, A_clr, A_ld, A );   
    
     // B Register:
    flipFlop4 ffB( ALU_src_in, clk, B_clr, B_ld, B ); 
     
    // ALU:                  
    ALU alu( A, B, inst[9], ALU_op, ALU_out, EQ );  
    
    // Result Register:
    flipFlop4 ffOut( ALU_out, clk, out_clr, out_ld, out );          
    
endmodule




