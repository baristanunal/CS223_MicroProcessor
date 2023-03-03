`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2021 19:07:50
// Design Name: 
// Module Name: ALU
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


// Arithmetic logc unit that calculates sum and dif and then chooses between 
// them depending on ALU operation select signal.


// REMARK: inst[9] should be passed as inst as one bit.
module ALU( input logic [3:0] RF_d1,
            input logic [3:0] ALU_src_in,
            input logic inst,
            input logic ALU_op,
            output logic [3:0] ALU_out,
            output logic EQ );

    logic [3:0] sum;
    logic [3:0] dif;
                        
    //adder add( RF_d1, ALU_src_in, sum );
    //subtractor sub( RF_d1, ALU_src_in, dif );
    
    // ALU operations subtraction and addition:
    assign sum = RF_d1 + ALU_src_in; 
    assign dif = RF_d1 - ALU_src_in;
    
    // Choosing between sum and difference of two inputs via mux:
    assign ALU_out = ALU_op ? dif : sum;
    
    // NOR gate for inst[9]', ALU_out bits and ALU_op':
    assign EQ = ~( (~ALU_op) | (~inst) | ALU_out[3] | ALU_out[2] | ALU_out[1] | ALU_out[0] );
    
endmodule
