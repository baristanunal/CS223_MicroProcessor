`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2021 19:07:50
// Design Name: 
// Module Name: InstructionMemory
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



module rom( input logic [2:0] adr,
            output logic [11:0] dout );
  always_comb        
    case( adr )
        3'b000: dout <= 12'b0000_0000_0000;
        3'b001: dout <= 12'b0000_0000_0000;
        3'b010: dout <= 12'b0000_0000_0000;
        3'b011: dout <= 12'b0000_0000_0000;
        3'b100: dout <= 12'b0000_0000_0000;
        3'b101: dout <= 12'b0000_0000_0000;
        3'b110: dout <= 12'b0000_0000_0000;
        3'b111: dout <= 12'b0000_0000_0000;
   endcase    
endmodule
