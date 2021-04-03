/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.0
created: 2021-04-03 14:05:10 +0800
madified:
***********************************************/
`timescale 1ns/1ps

module tb_exp_test_unit_sim();
//==========================================================================
//-------- define ----------------------------------------------------------
logic  sys_clk;
string test_unit_region;
logic [2-1:0]  unit_pass_u ;
logic [2-1:0]  unit_pass_d ;

//==========================================================================
//-------- instance --------------------------------------------------------
exp_test_unit_sim rtl_top(
/* input clock */.clock (sys_clk ),
/* input reset */.rst_n (1'b1    )
);
tu0 test_unit_0(
/* input  */.from_up_pass (unit_pass_u[0] ),
/* output */.to_down_pass (unit_pass_d[0] )
);
tu1 test_unit_1(
/* input  */.from_up_pass (unit_pass_u[1] ),
/* output */.to_down_pass (unit_pass_d[1] )
);
//==========================================================================
//-------- expression ------------------------------------------------------
assign unit_pass_u[0] = 1'b1;

assign unit_pass_u[1] = unit_pass_d[0];

endmodule
