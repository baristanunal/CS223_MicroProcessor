`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2021 19:07:50
// Design Name: 
// Module Name: RegFile
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



module RegFile( input logic clk,
                input logic reset,
                input logic [2:0] RF_add1, 
                input logic [2:0] RF_add2,
                input logic [2:0] RF_wa,
                input logic RF_we,
                input logic [3:0] RF_wd, 
                output logic [3:0] RF_d1,
                output logic [3:0] RF_d2);
              
logic [3:0] rf[7:0];  
    
always_ff@(posedge clk, posedge reset) 
    if(reset) 
        begin 
                rf[3'b000] <= 4'b0000;
                rf[3'b001] <= 4'b0000;
                rf[3'b010] <= 4'b0000;
                rf[3'b011] <= 4'b0000;
                rf[3'b100] <= 4'b0000;
                rf[3'b101] <= 4'b0000;
                rf[3'b110] <= 4'b0000;
                rf[3'b111] <= 4'b0000;
          end
          
    else if(RF_we) rf[RF_wa] <= RF_wd;
    
assign RF_d1 = rf[RF_add1];                 
assign RF_d2 = rf[RF_add2];
       
endmodule
