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

module tb_test_tttop_sim();
//==========================================================================
//-------- define ----------------------------------------------------------
logic gl_clk;
string test_unit_region;
logic unit_pass_u;
logic unit_pass_d;

//==========================================================================
//-------- instance --------------------------------------------------------
test_tttop_sim rtl_top(
/* input clock */.global_sys_clk (gl_clk )
);
test_clock_bb test_unit_0(
/* input  */.from_up_pass (unit_pass_u ),
/* output */.to_down_pass (unit_pass_d )
);
//==========================================================================
//-------- expression ------------------------------------------------------
initial begin
    forever begin #(33ns);gl_clk = ~gl_clk;end;
end

assign unit_pass_u = 1'b1;

endmodule
