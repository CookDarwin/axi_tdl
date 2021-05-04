/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.0
created: 2021-05-04 20:03:33 +0800
madified:
***********************************************/
`timescale 1ns/1ps

module test_module_port (
    axi_stream_inf.slaver   from_ethernet_udp_stream,
    axi_stream_inf.master   to_ethernet_udp_stream,
    axi_inf.master          ddr_dma_inf,
    data_inf.slaver         test_data_inf,
    data_inf_c.slaver       test_data_inf_c
);

//==========================================================================
//-------- define ----------------------------------------------------------

data_inf_c #(.DSIZE(test_data_inf_c.DSIZE),.FreqM(test_data_inf_c.FreqM)) inherited_inf (.clock(test_data_inf_c.clock),.rst_n(test_data_inf_c.rst_n)) ;
//==========================================================================
//-------- instance --------------------------------------------------------
test_module_port_sub test_module_port_sub_inst(
/* axi_inf.master */.test_axi4 (ddr_dma_inf )
);
//==========================================================================
//-------- expression ------------------------------------------------------

endmodule
