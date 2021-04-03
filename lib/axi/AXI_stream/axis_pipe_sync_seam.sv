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

module axis_pipe_sync_seam #(
    parameter  LAT   = 4,
    parameter  DSIZE = 32
)(
    input [DSIZE-1:0]       in_datas  [LAT-1:0],
    output [DSIZE-1:0]      out_datas [LAT-1:0],
    axi_stream_inf.slaver   in_inf,
    axi_stream_inf.master   out_inf
);

//==========================================================================
//-------- define ----------------------------------------------------------

data_inf_c #(.DSIZE(in_inf.DSIZE+in_inf.KSIZE+1+in_inf.USIZE)) data_in_inf (.clock(in_inf.aclk),.rst_n(in_inf.aresetn)) ;
data_inf_c #(.DSIZE(in_inf.DSIZE+in_inf.KSIZE+1+in_inf.USIZE)) data_out_inf (.clock(in_inf.aclk),.rst_n(in_inf.aresetn)) ;
//==========================================================================
//-------- instance --------------------------------------------------------
data_c_pipe_sync_seam #(
    .LAT   (LAT   ),
    .DSIZE (DSIZE )
)data_c_pipe_sync_seam_inst(
/* input             */.in_datas  (in_datas     ),
/* output            */.out_datas (out_datas    ),
/* data_inf_c.slaver */.in_inf    (data_in_inf  ),
/* data_inf_c.master */.out_inf   (data_out_inf )
);
//==========================================================================
//-------- expression ------------------------------------------------------
assign data_in_inf.data = {>>{in_inf.axis_tuser,in_inf.axis_tkeep,in_inf.axis_tlast,in_inf.axis_tdata}};
assign data_in_inf.valid = in_inf.axis_tvalid;
assign in_inf.axis_tready = data_in_inf.ready;
assign {out_inf.axis_tuser,out_inf.axis_tkeep,out_inf.axis_tlast,out_inf.axis_tdata} = data_out_inf.data;
assign out_inf.axis_tvalid = data_out_inf.valid;
assign data_out_inf.ready = out_inf.axis_tready;

endmodule
