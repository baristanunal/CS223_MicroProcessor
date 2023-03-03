`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2021 19:07:50
// Design Name: 
// Module Name: Debouncer
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


module butdebouncer( input logic clk, btnR,
                     output logic out );
    
    logic state[1:0];
    localparam T = 200000;
    logic st = 1;
    logic [20:0] c = 0;
    
    always_ff @(posedge clk) begin
    if(st) begin
        state[0] <= 0;
        state[1] <= 0;
        st <= 0;
    end
    
    else if(state[0] == 0 & state[1] == 0) begin
        out = 0;
        c <= 0;
        if(btnR) begin
          state[0] = 1; 
          state[1] = 0; 
          end
        end
    else if(state[0] == 1 & state[1] == 0) begin
        c <= c + 1;
        if(c > T) begin 
           state[1] = 1; 
           state[0] = 0; 
           end
        end
    else if(state[0] == 0 & state[1] == 1) begin
        out = 1;
        if(~btnR) begin
          state[0] = 0; 
          state[1] = 0; 
          end
        end
    end
endmodule