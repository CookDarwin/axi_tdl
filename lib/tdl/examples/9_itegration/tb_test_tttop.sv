/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.0
created: 2021-04-03 13:14:45 +0800
madified:
***********************************************/
`timescale 1ns/1ps
`timescale 1ns/1ps
`timescale 1ns/1ps

module tb_test_tttop();
//==========================================================================
//-------- define ----------------------------------------------------------
logic gl_clk;

//==========================================================================
//-------- instance --------------------------------------------------------
test_tttop rtl_top(
/* input clock */.global_sys_clk (gl_clk )
);
//==========================================================================
//-------- expression ------------------------------------------------------
initial begin
    forever begin #(33ns);gl_clk = ~gl_clk;end;
end

endmodule
