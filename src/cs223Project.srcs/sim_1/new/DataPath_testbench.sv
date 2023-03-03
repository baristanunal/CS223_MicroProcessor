`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2021 00:47:26
// Design Name: 
// Module Name: DataPath_testbench
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


module DataPath_testbench();
    
    
   
    logic clk, reset, M_wd_clr, M_wd_ld, M_we, M_add_clr, M_add_ld, M_re, RF_add1_clr, RF_add1_ld, RF_add2_clr, RF_add2_ld,
      RF_wd_clr, RF_wd_ld, RF_wa_clr, RF_wa_ld, RF_we, A_clr, A_ld, B_clr, B_ld, out_clr, out_ld, ALU_op, ALU_src_sel, 
      const_clr, const_ld, reg_wr_sel;
      
    logic [11:0] inst;

    logic EQ;

    logic [3:0] A;
    logic [3:0] B;
    logic [3:0] out;


    DataPath dut( clk, reset, inst, M_wd_clr, M_wd_ld, M_we, M_add_clr, M_add_ld, M_re, RF_add1_clr, RF_add1_ld, RF_add2_clr, RF_add2_ld,
             RF_wd_clr, RF_wd_ld, RF_wa_clr, RF_wa_ld, RF_we, A_clr, A_ld, B_clr, B_ld, out_clr, out_ld, ALU_op, ALU_src_sel, 
             const_clr, const_ld, reg_wr_sel, EQ, A, B, out ); 
    
    
    always 
        begin
            clk = 1; #5; clk = 0; #5;
        end
    
    initial begin
    
        reset = 1;
        
        #10;
        
        // Inýtializing values:
        { reset, M_wd_clr, M_wd_ld, M_we, M_add_clr, M_add_ld, M_re, RF_add1_clr, RF_add1_ld, RF_add2_clr, RF_add2_ld,
          RF_wd_clr, RF_wd_ld, RF_wa_clr, RF_wa_ld, RF_we, A_clr, A_ld, B_clr, B_ld, out_clr, out_ld, ALU_op, ALU_src_sel, 
          const_clr, const_ld, reg_wr_sel } = 0;
          
          inst = 12'b0000_0000_0000;
          
          A_ld = 1;
          B_ld = 1;
          out_ld = 1;
          const_ld = 1;
          
          #10;
          
          // Reading from 6th slot of dmem (value = 6), writing to 2nd slot of regfle.
          inst = 12'b0000_0010_0110;
          M_add_ld = 1;
          M_re = 1;
          reg_wr_sel = 0;
          RF_we = 1;
          RF_wa_ld = 1;
          RF_wd_ld = 1;
          
          #20;
          
          // Closing the registers:
          M_re = 0;
          RF_we = 0;
          M_add_ld = 0;
          RF_wa_ld = 0;
          RF_wd_ld = 0;
          
          #20;
          
          // Reading from 2nd slot of dmem (value = 2), writing to 3rd slot of regfle.
          inst = 12'b0000_0011_0010;
          M_add_ld = 1;
          M_re = 1;
          reg_wr_sel = 0;
          RF_we = 1;
          RF_wa_ld = 1;
          RF_wd_ld = 1;
          
          #20;
          
          // Closing the registers:
          M_re = 0;
          RF_we = 0;
          M_add_ld = 0;
          RF_wa_ld = 0;
          RF_wd_ld = 0;
          
          #20;
          
          
          // Subtracting 6-2=4 and writing the result to the 4th slot of regfile.
          inst = 12'b0101_0001_0011;
          RF_add1_ld = 1;
          RF_add2_ld = 1; 
          ALU_op = 1;
          reg_wr_sel = 1;
          RF_we = 1;
          RF_wd_ld = 1;
          RF_wa_ld = 1;
          
          #20;
          
          
    
    end
        
    
endmodule
