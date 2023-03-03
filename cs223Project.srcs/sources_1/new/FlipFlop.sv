`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2021 19:07:50
// Design Name: 
// Module Name: FlipFlop
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



module flipFlop3 ( input logic [2:0] d,
                    input logic clk, reset, en,
                    output logic [2:0] q );
                    
    always_ff@( posedge clk, posedge reset )
        begin
            if( reset )    q <= 3'b000;
            else if ( en ) q <= d;
        end
endmodule




module flipFlop4 ( input logic [3:0] d,
                    input logic clk, reset, en,
                    output logic [3:0] q );
                    
    always_ff@( posedge clk, posedge reset )
        begin
            if( reset )    q <= 4'b0000;
            else if ( en ) q <= d;
        end
endmodule

