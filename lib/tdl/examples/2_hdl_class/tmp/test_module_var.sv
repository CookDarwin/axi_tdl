/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.0
created: 2025-12-12 04:47:03 +0800
madified:
***********************************************/
`timescale 1ns/1ps

module test_module_var #(
    parameter  DSIZE = 10
)(
    input clock,
    input rst_n
);

//==========================================================================
//-------- define ----------------------------------------------------------
localparam  ASIZE  = 20   ;
axi_stream_inf #(.DSIZE(8),.FreqM(100),.USIZE(1)) tmp_axis_inf (.aclk(clock),.aresetn(rst_n),.aclken(1'b1)) ;
axi_stream_inf #(.DSIZE(8),.FreqM(100),.USIZE(1)) tmp_axis0_inf (.aclk(clock),.aresetn(rst_n),.aclken(1'b1)) ;
axi_inf #(.DSIZE(32),.IDSIZE(2),.ASIZE(8),.LSIZE(9),.MODE("BOTH"),.ADDR_STEP(4294967295),.FreqM(100)) tmp_axi4_inf (.axi_aclk(clock),.axi_aresetn(rst_n)) ;
data_inf #(.DSIZE(5)) tmp_data_inf();
data_inf_c #(.DSIZE(3),.FreqM(100)) tmp_data_inf_c (.clock(clock),.rst_n(rst_n)) ;
data_inf_c #(.DSIZE(3),.FreqM(100)) opopopopo (.clock(clock),.rst_n(rst_n)) ;
//==========================================================================
//-------- instance --------------------------------------------------------

//==========================================================================
//-------- expression ------------------------------------------------------

endmodule
