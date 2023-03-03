`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.12.2021 11:35:50
// Design Name: 
// Module Name: Mp_testbench
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


module Mp_testbench();
    
    logic clk;
    logic reset;
    logic isExternal;
    logic isInternal;
    logic [11:0] SWs;
    logic [3:0] A;
    logic [3:0] B;
    logic [3:0] out;  
    
    
    MicroProcessor dut( clk, reset, isExternal, isInternal, SWs, A, B, out );
    
    always 
        begin
            clk = 1; #5; clk = 0; #5;
        end
    
    initial begin
    
    reset = 0;
    isExternal = 0;
    isInternal = 0;
    SWs = 12'b0000_0000_0000;
    
    #20;
    
    SWs = 12'b0000_0010_0110;
    isExternal = 1;
    
    #20;
    
    isExternal = 0;
    
    #20;
    
    SWs = 12'b0000_0011_0010;
    isExternal = 1;
    
    #20;
    
    isExternal = 0;
    
    #20;
    
    SWs = 12'b0101_0001_0011;
    isExternal = 1;
    
    
    
    end
    
endmodule
