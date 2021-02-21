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

module test_struct_function #(
    parameter  NUM = 8
)(
    input         ain,
    output        bout,
    input [31:0]  in_array,
    output [31:0] out_array
);

//==========================================================================
//-------- define ----------------------------------------------------------
logic [32-1:0]  data ;
typedef struct {
logic op;
logic yp;
logic [NUM-1:0]  adata ;
logic data;
} s_map;

s_map s_map_a1;

//==========================================================================
//-------- instance --------------------------------------------------------

//==========================================================================
//-------- expression ------------------------------------------------------
function s_map f_g(input s_map fin); 
     f_g = fin.op;
     f_g.yp = 1;
endfunction:f_g

endmodule
