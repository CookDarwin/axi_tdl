/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.0
created: 2021-09-30 21:20:42 +0800
madified:
***********************************************/
`timescale 1ns/1ps

module test_logic_latency (
    input        data,
    input        clock,
    input        rst_n,
    output logic od
);

//==========================================================================
//-------- define ----------------------------------------------------------
logic broaden_and_cross_clk_R0000;

//==========================================================================
//-------- instance --------------------------------------------------------

//==========================================================================
//-------- expression ------------------------------------------------------
//----<<<< BROADEN_AND_CROSS_CLK >>>>---------------------------------------
broaden_and_cross_clk #(
    .PHASE     ("POSITIVE"),  //POSITIVE NEGATIVE
    .LEN       (4       ),
    .LAT       (2       )
)broaden_and_cross_clk_R0000_inst_R0001(
/* input    */  .rclk       (clock   ),
/* input    */  .rd_rst_n   (1'b1    ),
/* input    */  .wclk       (clock   ),
/* input    */  .wr_rst_n   (1'b1    ),
/* input    */  .d          (data    ),
/* output   */  .q          (broaden_and_cross_clk_R0000)
);
//====>>>> BROADEN_AND_CROSS_CLK <<<<=======================================

assign od = broaden_and_cross_clk_R0000;

endmodule
