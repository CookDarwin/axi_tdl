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
`timescale 1ns/1ps
`timescale 1ns/1ps

module tb_exp_test_unit();
//==========================================================================
//-------- define ----------------------------------------------------------
logic  sys_clk;

//==========================================================================
//-------- instance --------------------------------------------------------
exp_test_unit rtl_top(
/* input clock */.clock (sys_clk ),
/* input reset */.rst_n (1'b1    )
);
//==========================================================================
//-------- expression ------------------------------------------------------

endmodule
