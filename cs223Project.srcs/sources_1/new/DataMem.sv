`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2021 19:07:50
// Design Name: 
// Module Name: DataMem
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



module DataMemory( input logic clk,
                   input logic reset,
                   input logic [3:0] M_add,
                   input logic [3:0] M_wd,
                   input logic M_re,
                   input logic M_we,
                   output logic [3:0] M_rd );

logic[3:0] mem[15:0];

always_ff@(posedge clk, posedge reset)
    begin
        if ( M_re ) M_rd <= mem[M_add];
        if( reset )
            begin
                mem[4'b0000] <= 4'b0000;
                mem[4'b0001] <= 4'b0001;
                mem[4'b0010] <= 4'b0010;
                mem[4'b0011] <= 4'b0011;
                mem[4'b0100] <= 4'b0100;
                mem[4'b0101] <= 4'b0101;
                mem[4'b0110] <= 4'b0110;
                mem[4'b0111] <= 4'b0111;
                mem[4'b1000] <= 4'b1000;
                mem[4'b1001] <= 4'b1001;
                mem[4'b1010] <= 4'b1010;
                mem[4'b1011] <= 4'b1011;
                mem[4'b1100] <= 4'b1100;
                mem[4'b1101] <= 4'b1101;
                mem[4'b1110] <= 4'b1110;
                mem[4'b1111] <= 4'b1111; 
            end
        else
            begin       
                if( M_we ) mem[M_add] <= M_wd;                    
            end   
    end
endmodule
