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

module test_logic_combin ();
//==========================================================================
//-------- define ----------------------------------------------------------
logic [7-1:0]  a0 ;
logic [5-1:0]  a1 ;
logic [9-1:0]  a2 ;
logic [21-1:0]  ca ;
logic [8-1:0]  b0[2-1:0] ;
logic [16-1:0]  b1 ;
logic [32-1:0]  cb ;
logic [8-1:0]  c0[1-1:0] ;
logic [8-1:0]  c1[3-1:0] ;
logic [16-1:0]  cc[2-1:0] ;

//==========================================================================
//-------- instance --------------------------------------------------------

//==========================================================================
//-------- expression ------------------------------------------------------
assign  ca = {a0,a1,a2};
assign  cb = {>>{b1,b0}};
assign  cc = {<<{c0,c1}};

endmodule
