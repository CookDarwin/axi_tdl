/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.0
created: 2020-06-09 15:39:16 +0800
madified:
***********************************************/
`timescale 1ns/1ps

module test_axi4_M2S (
    input clock,
    input rst_n
);

//==========================================================================
//-------- define ----------------------------------------------------------

axi_inf #(.DSIZE(32),.IDSIZE(2),.ASIZE(8),.LSIZE(9),.MODE("BOTH"),.ADDR_STEP(4294967295)) tmp_axi4_inf (.axi_aclk(clock),.axi_aresetn(rst_n)) ;
axi_inf #(.DSIZE(32),.IDSIZE(2),.ASIZE(tmp_axi4_inf.ASIZE),.LSIZE(tmp_axi4_inf.LSIZE),.MODE(tmp_axi4_inf.MODE),.ADDR_STEP(tmp_axi4_inf.ADDR_STEP)) axi4_sub0 (.axi_aclk(clock),.axi_aresetn(rst_n)) ;
axi_inf #(.DSIZE(32),.IDSIZE(2),.ASIZE(tmp_axi4_inf.ASIZE),.LSIZE(tmp_axi4_inf.LSIZE),.MODE(tmp_axi4_inf.MODE),.ADDR_STEP(tmp_axi4_inf.ADDR_STEP)) axi4_sub1 (.axi_aclk(clock),.axi_aresetn(rst_n)) ;
//==========================================================================
//-------- instance --------------------------------------------------------

//==========================================================================
//-------- expression ------------------------------------------------------

endmodule
