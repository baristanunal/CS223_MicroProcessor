`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2021 19:07:50
// Design Name: 
// Module Name: Microprocessor
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


module MicroProcessor( input logic clk,
                       input logic reset,
                       input logic isExternal,
                       input logic isInternal,
                       input logic [11:0] SWs,
                       output logic [3:0] A,
                       output logic [3:0] B,
                       output logic [3:0] out );

    
    logic PC_clr;
    logic IR_clr;
    logic EQ;
    logic [2:0] PC_add_out;
    //logic [2:0] PC_add_in;//
    logic [11:0] inst;
    logic [11:0] instToIR;
    logic const_clr;
    logic const_ld;
               
                    
    logic reg_wr_sel;
    logic ALU_src_sel;
    logic ALU_op;
                    
    logic RF_add1_clr;
    logic RF_add1_ld;
    logic RF_add2_clr;
    logic RF_add2_ld;
    logic RF_wa_clr;
    logic RF_wa_ld;
    logic RF_wd_clr;
    logic RF_wd_ld;
    logic RF_clr;
    logic RF_we;
                    
    logic M_add_clr;
    logic M_add_ld;
    logic M_wd_clr;
    logic M_wd_ld;
    logic M_re;
    logic M_we;
    logic M_clr;
                    
    logic A_clr;
    logic A_ld;
    logic B_clr;
    logic B_ld;
    logic out_clr;
    logic out_ld;
    
    // PC_add_in initialization?
    // EQ init?
    PC pcount( clk, PC_clr, ~isExternal, EQ, inst[8:6], PC_add_out );
    
    IRreg ireg( clk, instToIR, SWs, IR_clr, isExternal, inst );
    
    rom imem( PC_add_out, instToIR );
    
    
    typedef enum logic [3:0] { init, wait_button, fetch, 
                               load_rd, load, 
                               store_rd, store, 
                               sub_rd, sub, 
                               add_const_rd, add_const, 
                               jump, x0, x1, x2, x3 } statetype;

    statetype [3:0] state;
    statetype [3:0] nextState;
    
    always_ff@( posedge clk, posedge reset)
        begin
            if( reset ) state <= init;
            else        state <= nextState;
        end
        
        
     // NEXT STATES:   
        
     always_comb
        case( state )
        
            init: nextState = wait_button;
            
            wait_button: if( (~isExternal) & (~isInternal) )    nextState = wait_button;
                         //else if ( isInternal & (~isExternal) ) nextState = im;
                         else                                   nextState = fetch;   
            
            //im: nextState = fetch;
            
            //sw: nextState = fetch;
            
            fetch: if( (~inst[11]) & (~inst[10]) & (~inst[9]) )     nextState = load_rd;
                   else if( (~inst[11]) & (~inst[10]) & (inst[9]) ) nextState = store_rd;
                   else if( (~inst[11]) & (inst[10]) & (~inst[9]) ) nextState = sub_rd;
                   else if( (inst[11]) & (~inst[10]) & (inst[9]) )  nextState = add_const_rd;
                   else if( (inst[11]) & (inst[10]) & (inst[9]) )   nextState = jump;
                   else                                             nextState = wait_button;
            
            load_rd: nextState = load;
            
            load: nextState = wait_button;
            
            
            store_rd: nextState = store;
            
            store: nextState = wait_button;
            
            
            sub_rd: nextState = sub;
            
            sub: nextState = wait_button;
            
            
            add_const_rd: nextState = add_const;
            
            add_const: nextState = wait_button;
            
         
            
            jump: nextState = wait_button;
            
            
            default: nextState = init;
            
         endcase
         
         
         
    always_comb
        case( state )
        
            init: 
                begin
                    PC_clr = 1;
                    IR_clr = 1;
                    
                    const_clr = 1;
                    const_ld = 0;
                    
                    reg_wr_sel = 0;
                    ALU_src_sel = 0;
                    ALU_op = 0;
                    
                    RF_add1_clr = 1;
                    RF_add1_ld = 0;
                    RF_add2_clr = 1;
                    RF_add2_ld = 0;
                    RF_wa_clr = 1;
                    RF_wa_ld = 0;
                    RF_wd_clr = 1;
                    RF_wd_ld = 0;
                    RF_clr = 1;
                    RF_we = 0;
                    
                    M_add_clr = 1;
                    M_add_ld = 0;
                    M_wd_clr = 1;
                    M_wd_ld = 0;
                    M_re = 0;
                    M_we = 0;
                    M_clr = 1;
                    
                    A_clr = 1;
                    A_ld = 0;
                    B_clr = 1;
                    B_ld = 0;
                    out_clr = 1;
                    out_ld = 0;
                end
                
            wait_button:
                begin
                    PC_clr = 0;
                    IR_clr = 0;
                    
                    const_clr = 0;
                    const_ld = 0;
                    
                    RF_add1_clr = 0;
                    RF_add1_ld = 0;
                    RF_add2_clr = 0;
                    RF_add2_ld = 0;
                    RF_wa_clr = 0;
                    RF_wa_ld = 0;
                    RF_wd_clr = 0;
                    RF_wd_ld = 0;
                    RF_clr = 0;
                    RF_we = 0;
                    
                    M_add_clr = 0;
                    M_add_ld = 0;
                    M_wd_clr = 0;
                    M_wd_ld = 0;
                    M_re = 0;
                    M_we = 0;
                    M_clr = 0;
                    
                    A_clr = 0;
                    A_ld = 1;
                    B_clr = 0;
                    B_ld = 1;
                    out_clr = 0;
                    out_ld = 1;
                end
                
             fetch:
                begin
                    A_clr = 1;
                    A_ld = 0;
                    B_clr = 1;
                    B_ld = 0;
                    out_clr = 1;
                    out_ld = 0;
                    
                    const_ld = 0;
                end
            
            load_rd:
                begin
                    A_clr = 0;
                    B_clr = 0;
                    out_clr = 0;
                    
                    M_re = 1;
                    M_add_ld = 1;
                end
            
            load:
                begin
                
                    RF_we = 1;
                    RF_wa_ld = 1;
                    RF_wd_ld = 1;
                    
                    reg_wr_sel = 0;
                    
                end
            
            store_rd:
                begin
                    A_clr = 0;
                    B_clr = 0;
                    out_clr = 0;
                    
                    RF_add2_ld = 1;
                end
            
            store:
                begin
                    M_we = 1;
                    M_add_ld = 1;
                    M_wd_ld = 1;
                end
                
            sub_rd:
                begin
                    A_clr = 0;
                    B_clr = 0;
                    out_clr = 0;
                    
                    RF_add1_ld = 1;
                    RF_add2_ld = 1;
                    
                    ALU_op = 1;
                    ALU_src_sel = 0;
                end
            
            sub:
                begin
                    RF_we = 1;
                    RF_wa_ld = 1;
                    RF_wd_ld = 1;
                    
                    reg_wr_sel = 1;
                end
             
            add_const_rd:
                begin
                    A_clr = 0;
                    B_clr = 0;
                    out_clr = 0;
                    
                    const_ld = 1;
                    
                    RF_add1_ld = 1;
                    
                    ALU_op = 0;
                    ALU_src_sel = 1;
                end
                
            add_const:
                begin
                    RF_we = 1;
                    RF_wa_ld = 1;
                    RF_wd_ld = 1;
                    
                    reg_wr_sel = 1;
                end
             
             jump:
                begin
                    A_clr = 0;
                    B_clr = 0;
                    out_clr = 0;
                    
                    RF_add1_ld = 1;
                    RF_add2_ld = 1;
                    
                    ALU_op = 1;
                    ALU_src_sel = 0;
                end
            
            default:
                begin
                    PC_clr = 1;
                    IR_clr = 1;
                    
                    const_clr = 1;
                    const_ld = 0;
                    
                    reg_wr_sel = 0;
                    ALU_src_sel = 0;
                    ALU_op = 0;
                    
                    RF_add1_clr = 1;
                    RF_add1_ld = 0;
                    RF_add2_clr = 1;
                    RF_add2_ld = 0;
                    RF_wa_clr = 1;
                    RF_wa_ld = 0;
                    RF_wd_clr = 1;
                    RF_wd_ld = 0;
                    RF_clr = 1;
                    RF_we = 0;
                    
                    M_add_clr = 1;
                    M_add_ld = 0;
                    M_wd_clr = 1;
                    M_wd_ld = 0;
                    M_re = 0;
                    M_we = 0;
                    M_clr = 1;
                    
                    A_clr = 1;
                    A_ld = 0;
                    B_clr = 1;
                    B_ld = 0;
                    out_clr = 1;
                    out_ld = 0;
                end     
            
        endcase
        
    DataPath dp( clk, reset, inst, M_wd_clr, M_wd_ld, M_we, M_add_clr, M_add_ld, M_re,
                 RF_add1_clr, RF_add1_ld, RF_add2_clr, RF_add2_ld, RF_wd_clr, RF_wd_ld,
                 RF_wa_clr, RF_wa_ld, RF_we, A_clr, A_ld, B_clr, B_ld, out_clr, out_ld,
                 ALU_op, ALU_src_sel, const_clr, const_ld, reg_wr_sel,
                 EQ, A, B, out );

endmodule