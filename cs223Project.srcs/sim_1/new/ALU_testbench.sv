`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.12.2021 19:58:52
// Design Name: 
// Module Name: ALU_testbench
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


module ALU_testbench();

    logic[3:0] RF_d1;
    logic[3:0] ALU_src_in;

    logic inst;
    logic ALU_op;

    logic[3:0] ALU_out;
    logic EQ;

    ALU dut (RF_d1, ALU_src_in, inst, ALU_op, ALU_out, EQ);

    initial begin
        for( int i = 0; i < 1023; i++ )
            begin
                {RF_d1,ALU_src_in,inst,ALU_op} = i; #10;
            end
    end
    
endmodule
