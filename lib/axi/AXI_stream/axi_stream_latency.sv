/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript: base on planer
author : Cook.Darwin
Version: VERA.0.0
creaded: 
madified:
***********************************************/
`timescale 1ns/1ps
`include "define_macro.sv"
module axi_stream_latency #(
    parameter LAT   = 3
)(
    input                 reset,
    axi_stream_inf.slaver axis_in,
    axi_stream_inf.master axis_out        
);

data_inf_c #(.DSIZE(axis_in.DSIZE + 1 + axis_in.KSIZE + axis_in.USIZE)) data_slaver (.clock(axis_in.aclk), .rst_n(axis_in.aresetn) );
data_inf_c #(.DSIZE(axis_in.DSIZE + 1 + axis_in.KSIZE + axis_in.USIZE + 1)) data_master (.clock(axis_in.aclk), .rst_n(axis_in.aresetn) );


data_inf_c_planer_A1 #(
    .LAT        (LAT        ),
    .DSIZE      (1      ),
    .HEAD       ("ON"    )
)data_inf_c_planer_A1_inst(
/*  input             */ .reset         (reset      ),
/*  input [DSIZE-1:0] */ .pack_data     (1'b0       ),
/*  data_inf_c.slaver */ .slaver        (data_slaver    ),
/*  data_inf_c.master */ .master        (data_master    )///HEAD=="ON" : {pack_data,slaver.data} or /HEAD=="OFF" : {slaver.data,pack_data}
);

assign data_slaver.data  = {axis_in.axis_tuser, axis_in.axis_tkeep, axis_in.axis_tlast, axis_in.axis_tdata};
assign data_slaver.valid = axis_in.axis_tvalid;
assign axis_in.axis_tready = data_slaver.ready;

// axis_to_data_inf #(
//     .CONTAIN_LAST   ("ON")
// )axis_to_data_inf_inst(
// /*  axi_stream_inf.slaver  */ .axis_in      (axis_in        ),
// /*  data_inf_c.master      */ .data_out_inf (data_slaver    )
// );

// data_c_to_axis_full data_c_to_axis_full_inst(
// /* data_inf_c.slaver     */ .data_in_inf            (data_master    ),
// /* axi_stream_inf.master */ .axis_out               (axis_out       )
// );

assign {axis_out.axis_tuser, axis_out.axis_tkeep, axis_out.axis_tlast, axis_out.axis_tdata} = data_master.data[data_master.DSIZE-2:0];
assign axis_out.axis_tvalid = data_master.valid;
assign data_master.ready    = axis_out.axis_tready;

endmodule