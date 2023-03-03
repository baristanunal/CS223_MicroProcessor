`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.12.2021 19:07:50
// Design Name: 
// Module Name: TopModule
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


module TopModule( input logic clk,
                  input logic rightButton, 
                  input logic leftButton,
                  input logic [11:0] SWs,
                  input logic reset,
                  output logic [6:0] sevSeg,
                  output logic [3:0] an );
    logic rb;
    logic lb;
    logic [3:0] A;
    logic [3:0] B;
    logic [3:0] out;
    logic newCLK;

    //clock_divider_sys system (clk, newCLK);
    butdebouncer rightDebouncer( clk, rightButton, rb );
    butdebouncer leftDebouncer( clk, leftButton, lb );
    
    //rb
    MicroProcessor mp( clk, reset, rightButton, leftButton, SWs, A, B, out );
    
    sevenSeg sevenSegment( reset, clk, A, B, out, sevSeg, an );

endmodule

module clock_divider_sys( input clk,
                      output logic clk_div);
    localparam constantNumber = 100000000;
    logic [31:0] count;
     
    always @ (posedge(clk))
    begin
        if (count == constantNumber - 1)
            count <= 32'b0;
        else
            count <= count + 1;
    end
    
    always @ (posedge(clk))
    begin
        if (count == constantNumber - 1)
            clk_div <= ~clk_div;
        else
            clk_div <= clk_div;
    end
endmodule