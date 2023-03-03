`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2021 19:46:48
// Design Name: 
// Module Name: IRreg
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


module IRreg( input logic clk,
              input logic [11:0] inst_in,
              input logic [11:0] SWs,
              input logic IR_clr,
              input logic IR_sel,
              output logic [11:0] inst_out );

    logic [11:0] reg_in;         
      
    assign reg_in = IR_sel ? SWs : inst_in;          

    always_ff@(posedge clk, posedge IR_clr)
        begin
            if( IR_clr )            inst_out <= 12'b0000_0000_0000;
            else                    inst_out <= reg_in;
        end

endmodule
