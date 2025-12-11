/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.0
created: 2021-05-04 20:03:32 +0800
madified:
***********************************************/
`timescale 1ns/1ps

module example_interface (
    data_inf_c.master       dim,
    data_inf_c.slaver       dis,
    data_inf_c.mirror       dirr,
    axi_stream_inf.master   asim  [3:0],
    axi_stream_inf.slaver   asis,
    axi_lite_inf.master     alm,
    axi_inf.master          a4m,
    axi_inf.slaver          a4s   [2:0]
);

//==========================================================================
//-------- define ----------------------------------------------------------

data_inf_c #(.DSIZE(8),.FreqM(101)) a_inf (.clock(dim.clock),.rst_n(dim.clock)) ;
data_inf_c #(.DSIZE(8),.FreqM(101)) c_inf [7:0] (.clock(dim.clock),.rst_n(dim.clock)) ;
axi_stream_inf #(.DSIZE(8),.FreqM(1.0),.USIZE(1)) f_inf (.aclk(asis.aclk),.aresetn(asis.aresetn),.aclken(1'b1)) ;
axi_stream_inf #(.DSIZE(8),.FreqM(1.0),.USIZE(1)) g_inf [1:0] (.aclk(asis.aclk),.aresetn(asis.aresetn),.aclken(1'b1)) ;
axi_lite_inf #(.DSIZE(32),.ASIZE(32),.FreqM(103)) h_inf (.axi_aclk(alm.axi_aclk),.axi_aresetn(alm.axi_aresetn)) ;
axi_inf #(.DSIZE(32),.IDSIZE(3),.ASIZE(32),.LSIZE(10),.MODE("BOTH"),.ADDR_STEP(4096),.FreqM(103)) i_inf (.axi_aclk(a4m.axi_aclk),.axi_aresetn(a4m.axi_aresetn)) ;
axi_inf #(.DSIZE(31),.IDSIZE(3),.ASIZE(37),.LSIZE(12),.MODE("BOTH"),.ADDR_STEP(1024),.FreqM(103)) j_inf [8:0][4:0][2:0] (.axi_aclk(a4m.axi_aclk),.axi_aresetn(a4m.axi_aresetn)) ;
//==========================================================================
//-------- instance --------------------------------------------------------

//==========================================================================
//-------- expression ------------------------------------------------------

endmodule
