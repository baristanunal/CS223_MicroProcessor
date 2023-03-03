`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Barýþ Tan Ünal
// 
// Create Date: 26.12.2021 19:07:50
// Design Name: 
// Module Name: SevenSeg
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

module display(
input logic [3:0] sw, 
input logic [3:0] osw, 
input logic [3:0] lsw,
input logic clk,
output logic seg[6:0], an[3:0]
   );
   logic sclk;
   logic [3:0] val;
   logic r = 0;
   clk_divider d(clk,sclk);
   num_converter n(val,seg);
    always_ff @(posedge sclk ) begin
        if (r) begin
            an[0] <=1;
            an[1] <=1;
            an[2] <=1;
            an[3] <=0;
            r <= 0;
        end
        else if(an[3] == 0)begin
            an[3] <= 1;
            an[2] <= 0;
            val <= osw;
        end
        else if(an[2]== 0)begin
            an[0] <= 0;
            an[2] <= 1;
            val <= lsw;
        end
        else if(an[0]== 0)begin
            an[0] <= 1;
            an[3] <= 0;
            val <= sw;
        end    
    end
endmodule

module clk_divider(input logic clk, output logic newClk);
    logic[31:0]counter = 1;

    localparam delay = (200_000-1);
    logic temporaryClk = 0;

    always@(posedge clk)
    begin
        if(counter == delay)
            begin
                counter <= 1;
                temporaryClk = ~temporaryClk;
            end
        else
            counter <= counter + 1;
    end
    assign newClk = temporaryClk;
endmodule

module num_converter(
input logic [3:0] sw,
output logic seg[6:0]
    );
    always_comb begin
    if(sw == 0)begin
        seg[0] <= 0;
        seg[1] <= 0;
        seg[2] <= 0;
        seg[3] <= 0;
        seg[4] <= 0;
        seg[5] <= 0;
        seg[6] <= 1;
        end
        else if(sw == 1)begin
        seg[0] <= 1;
        seg[1] <= 0;
        seg[2] <= 0;
        seg[3] <= 1;
        seg[4] <= 1;
        seg[5] <= 1;
        seg[6] <= 1;
        end
        else if(sw == 2)begin
        seg[0] <= 0;
        seg[1] <= 0;
        seg[2] <= 1;
        seg[3] <= 0;
        seg[4] <= 0;
        seg[5] <= 1;
        seg[6] <= 0;
        end
        else if(sw == 3)begin
        seg[0] <= 0;
        seg[1] <= 0;
        seg[2] <= 0;
        seg[3] <= 0;
        seg[4] <= 1;
        seg[5] <= 1;
        seg[6] <= 0;
        end
         if(sw == 4)begin
        seg[0] <= 1;
        seg[1] <= 0;
        seg[2] <= 0;
        seg[3] <= 1;
        seg[4] <= 1;
        seg[5] <= 0;
        seg[6] <= 0;
        end
        else if(sw == 5)begin
        seg[0] <= 0;
        seg[1] <= 1;
        seg[2] <= 0;
        seg[3] <= 0;
        seg[4] <= 1;
        seg[5] <= 0;
        seg[6] <= 0;
        end
        else if(sw == 6)begin
        seg[0] <= 0;
        seg[1] <= 1;
        seg[2] <= 0;
        seg[3] <= 0;
        seg[4] <= 0;
        seg[5] <= 0;
        seg[6] <= 0;
        end
        else if(sw == 7)begin
        seg[0] <= 0;
        seg[1] <= 0;
        seg[2] <= 0;
        seg[3] <= 1;
        seg[4] <= 1;
        seg[5] <= 1;
        seg[6] <= 1;
        end
        else if(sw == 8)begin
        seg[0] <= 0;
        seg[1] <= 0;
        seg[2] <= 0;
        seg[3] <= 0;
        seg[4] <= 0;
        seg[5] <= 0;
        seg[6] <= 0;
        end
        else if(sw == 9)begin
        seg[0] <= 0;
        seg[1] <= 0;
        seg[2] <= 0;
        seg[3] <= 0;
        seg[4] <= 1;
        seg[5] <= 0;
        seg[6] <= 0;
        end
        else if(sw == 10)begin
        seg[0] <= 0;
        seg[1] <= 0;
        seg[2] <= 0;
        seg[3] <= 1;
        seg[4] <= 0;
        seg[5] <= 0;
        seg[6] <= 0;
        end
        else if(sw == 11)begin
        seg[0] <= 1;
        seg[1] <= 1;
        seg[2] <= 0;
        seg[3] <= 0;
        seg[4] <= 0;
        seg[5] <= 0;
        seg[6] <= 0;
        end
        else if(sw == 12)begin
        seg[0] <= 1;
        seg[1] <= 1;
        seg[2] <= 1;
        seg[3] <= 0;
        seg[4] <= 0;
        seg[5] <= 1;
        seg[6] <= 0;
        end
        else if(sw == 13)begin
        seg[0] <= 1;
        seg[1] <= 0;
        seg[2] <= 0;
        seg[3] <= 0;
        seg[4] <= 0;
        seg[5] <= 1;
        seg[6] <= 0;
        end
        else if(sw == 14)begin
        seg[0] <= 0;
        seg[1] <= 1;
        seg[2] <= 1;
        seg[3] <= 0;
        seg[4] <= 0;
        seg[5] <= 0;
        seg[6] <= 0;
        end
        else if(sw == 15)begin
        seg[0] <= 0;
        seg[1] <= 1;
        seg[2] <= 1;
        seg[3] <= 1;
        seg[4] <= 0;
        seg[5] <= 0;
        seg[6] <= 0;
        end
    end
endmodule


module sevenSeg(
    input clear,
    input clk,
    input [3:0] A,
    input [3:0] B,
    input [3:0] result,
    output reg [6:0] seg,
    output reg [3:0] an );
    
    logic newCLK;
    logic [1:0] refreshcounter;
    logic [3:0] singleDigit;
    clock_divider_ss clkDiv (clk, newCLK);
    refreshcounter refCnt (newCLK, refreshcounter);
    anode_control anCnt (refreshcounter, an);
    BCD_control bcc (result, B, A, refreshcounter, singleDigit);
    BCD_to_Cathodes bccToCath (clear, singleDigit, seg);
endmodule

module clock_divider_ss( input clk,
                      output logic clk_div);
    localparam constantNumber = 500;
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

module refreshcounter(
    input refresh_clock,
    output reg [1:0] refreshcounter = 0
);
    always @(posedge refresh_clock) refreshcounter <= refreshcounter + 1;
endmodule

module anode_control(
    input [1:0] refreshcounter,
    output reg [3:0] anode = 0
);
    always @(refreshcounter)
        begin
            case(refreshcounter)
                2'b00: anode <= 4'b1110;
                2'b01: anode <= 4'b1111;
                2'b10: anode <= 4'b1011;
                2'b11: anode <= 4'b0111;
            endcase
        end
endmodule

module BCD_control(
    input [3:0] digit1,
    input [3:0] digit3,
    input [3:0] digit4,
    input [1:0] refreshcounter,
    output reg [3:0] singleDigit = 0
);
    always @(refreshcounter)
        case(refreshcounter)
            2'd0: singleDigit = digit1;
            2'd2: singleDigit = digit3;
            2'd3: singleDigit = digit4;
        endcase
endmodule

module BCD_to_Cathodes(
    input clear,
    input [3:0] digit,
    output reg [6:0] cathode = 0
);
    logic [3:0] display;
    always @(clear)
        if (clear)
            display <= 0;
        else
            display <= digit;
    always @(display)
        begin
            case(display)
                0: cathode = 7'b100_0000;
                1: cathode = 7'b111_1001;
                2: cathode = 7'b010_0100;
                3: cathode = 7'b011_0000;
                4: cathode = 7'b001_1001;
                5: cathode = 7'b001_0010;
                6: cathode = 7'b000_0010;
                7: cathode = 7'b111_1000;
                8: cathode = 7'b000_0000;
                9: cathode = 7'b001_0000;
                10: cathode = 7'b000_1000;
                11: cathode = 7'b000_0011;
                12: cathode = 7'b100_0110;
                13: cathode = 7'b010_0001;
                14: cathode = 7'b000_0110;
                15: cathode = 7'b000_1110;
                default: cathode = 7'b111_1111;
            endcase
        end
endmodule

