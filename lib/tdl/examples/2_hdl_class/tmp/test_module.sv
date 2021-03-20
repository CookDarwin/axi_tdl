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

module test_module (
    input               clock,
    input               clock1,
    input               rst_n,
    input               rst_n1,
    axi_inf.master_wr   axi_wr_inf
);

//==========================================================================
//-------- define ----------------------------------------------------------
logic [axi_wr_inf.ASIZE-1:0]  addr ;
logic [axi_wr_inf.IDSIZE-4-1:0]  id ;
logic [24-1:0]  length ;
axi_inf #(.DSIZE(axi_wr_inf.DSIZE),.IDSIZE(axi_wr_inf.IDSIZE-4),.ASIZE(axi_wr_inf.ASIZE),.LSIZE(24),.MODE("ONLY_WRITE"),.ADDR_STEP(8192)) pre_axi_wr_inf (.axi_aclk(axi_wr_inf.axi_aclk),.axi_aresetn(axi_wr_inf.axi_aresetn)) ;
//==========================================================================
//-------- instance --------------------------------------------------------
axi_stream_cache_35bit cache_inst(
/* axi_stream_inf.slaver */.axis_in  (opop      ),
/* axi_stream_inf.master */.axis_out (" 909090" )
);
//==========================================================================
//-------- expression ------------------------------------------------------

endmodule
