/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.0
created: 2021-03-28 14:46:59 +0800
madified:
***********************************************/
`timescale 1ns/1ps

module axis_sim_master_model #(
    parameter  LOOP      = "TRUE",
    parameter  RAM_DEPTH = 10000
)(
    input                   load_trigger,
    input [31:0]            total_length,
    input [4095:0]          mem_file,
    axi_stream_inf.master   out_inf
);

//==========================================================================
//-------- define ----------------------------------------------------------

data_inf_c #(.DSIZE(out_inf.DSIZE + out_inf.KSIZE + out_inf.USIZE + 1)) out_inf_dc (.clock(out_inf.aclk),.rst_n(out_inf.aresetn)) ;
//==========================================================================
//-------- instance --------------------------------------------------------
data_c_sim_master_model #(
    .LOOP      (LOOP      ),
    .RAM_DEPTH (RAM_DEPTH )
)data_c_sim_master_model_inst(
/* input             */.load_trigger (load_trigger ),
/* input             */.total_length (total_length ),
/* input             */.mem_file     (mem_file     ),
/* data_inf_c.master */.out_inf      (out_inf_dc   )
);
//==========================================================================
//-------- expression ------------------------------------------------------
assign out_inf.axis_tvalid = out_inf_dc.valid;
assign out_inf_dc.ready = out_inf.axis_tready;
assign {>>{out_inf.axis_tuser,out_inf.axis_tkeep,out_inf.axis_tlast,out_inf.axis_tdata}} = out_inf_dc.data;

endmodule
