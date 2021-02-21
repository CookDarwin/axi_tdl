/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.0
created: xxxx.xx.xx
madified:
***********************************************/
`timescale 1ns/1ps

module always_ff_test (
    input  clock,
    input  clock1,
    input  rst_n,
    input  rst_n1
);

//==========================================================================
//-------- define ----------------------------------------------------------
logic [1-1:0]  tmp0[9-1:0][2-1:0] ;
logic tmp1;
data_inf_c #(.DSIZE(8)) a_inf (.clock(dclk),.rst_n(drstn)) ;
data_inf_c #(.DSIZE(8)) c_inf [2:0][6:0][7:0] (.clock(dclk),.rst_n(drstn)) ;
//==========================================================================
//-------- instance --------------------------------------------------------

//==========================================================================
//-------- expression ------------------------------------------------------
always_ff@(posedge clock,negedge rst_n) begin 
     32*2- 5- 6;
end

endmodule
