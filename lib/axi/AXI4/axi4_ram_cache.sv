/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.0
creaded: XXXX.XX.XX
madified:
***********************************************/
`timescale 1ns/1ps

module axi4_ram_cache #(
    parameter  INIT_FILE = ""
)(
    axi_inf.slaver   a_inf
);

//==========================================================================
//-------- define ----------------------------------------------------------

axi_inf #(.DSIZE(a_inf.DSIZE),.IDSIZE(a_inf.IDSIZE),.ASIZE(a_inf.ASIZE),.LSIZE(a_inf.LSIZE),.MODE(a_inf.MODE),.ADDR_STEP(a_inf.ADDR_STEP),.FreqM(a_inf.FreqM)) b_inf (.axi_aclk(a_inf.axi_aclk),.axi_aresetn(a_inf.axi_aresetn)) ;
//==========================================================================
//-------- instance --------------------------------------------------------
axi4_dpram_cache #(
    .INIT_FILE (INIT_FILE )
)axi4_dpram_cache_inst(
/* axi_inf.slaver */.a_inf (a_inf ),
/* axi_inf.slaver */.b_inf (b_inf )
);
//==========================================================================
//-------- expression ------------------------------------------------------
assign b_inf.axi_awvalid = 1'b0;
assign b_inf.axi_arvalid = 1'b0;
assign b_inf.axi_wvalid = 1'b0;
assign b_inf.axi_rready = 1'b1;
assign b_inf.axi_bready = 1'b1;

endmodule
