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

module test_package2 (
    output  out
);

//------>> EX CODE <<-------------------
import test_package::*;
//------<< EX CODE >>-------------------

//==========================================================================
//-------- define ----------------------------------------------------------
z_ing y0;

//==========================================================================
//-------- instance --------------------------------------------------------

//==========================================================================
//-------- expression ------------------------------------------------------
assign  out = NUM;
assign  out = data;

assign  y0.op = 0;
assign  y0.op[0] = 0;

endmodule