`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2021 19:07:50
// Design Name: 
// Module Name: PC
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



module PC( input logic clk,
           input logic PC_clr,
           input logic PC_ld,
           input logic PC_sel,
           input logic [2:0] j, 
           output logic [2:0] PC_out );

    logic [2:0] PC_add_next;
    logic [2:0] PC_add;
    
    PCSelector pcSel( PC_add, j, PC_sel, PC_add_next );
    
    PCreg pReg( clk, PC_clr, PC_ld, PC_add_next, PC_add );
    assign PC_out = PC_add;


endmodule

module PCSelector( input logic [2:0] PC_in,
                   input logic [2:0] j,
                   input logic PC_sel,
                   output logic [2:0] PC_out );
    logic [2:0] sum;
    logic [2:0] mod;
    
    //adder add1( PC_in, 3'b001, sum );
    //adder add2( PC_in, j, mod );
    
    assign sum = PC_in + 3'b001;
    assign mod = PC_in + j;
    
    assign PC_out = PC_sel ? mod : sum;

endmodule

module PCreg( input logic clk,
              input logic PC_clr,
              input logic PC_ld,
              input logic [2:0] PC_add_next,
              output logic [2:0] PC_add );
  
    always_ff@(posedge clk, posedge PC_clr)
        begin
            if( PC_clr )            PC_add <= 3'b000;
            else if( PC_ld )        PC_add <= PC_add_next;
        end
endmodule