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

module head_pkg_module import test_package::*;(
    output [9:0]        out,
    data_inf_c.slaver   d_inf       [4:0],
    input z_ing         struct_z,
    input z_ing         struct_z_l [9-1:0]
);

//==========================================================================
//-------- define ----------------------------------------------------------
z_ing y0;
z_ing curr_y0;
logic [$clog2(NUM*8)-1:0]  clog2_data ;

//==========================================================================
//-------- instance --------------------------------------------------------

//==========================================================================
//-------- expression ------------------------------------------------------
assign out = NUM;
assign out = data;
assign struct_z_l[8].op[0] = 0;

assign y0.op = 1'b0;
assign y0.op[0] = 1'd0;
assign y0.op[1] = struct_z.op[1];
assign y0.op[y0.op[3:1]] = struct_z.op;

assign curr_y0 = struct_z;

endmodule
