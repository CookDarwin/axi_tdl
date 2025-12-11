/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.0
creaded: 
madified:
***********************************************/
`timescale 1ns/1ps
(* axi_stream = "true" *)
module axis_width_convert_verb #(
    parameter IDSIZE = 8,
    parameter ODSIZE = 16
)(
    axi_stream_inf.slaver   in_axis,
    axi_stream_inf.master   out_axis
);

generate
if(IDSIZE == ODSIZE)
    axis_direct_A1 #(
        .IDSIZE     (in_axis.DSIZE),
        .ODSIZE     (out_axis.DSIZE)
    )axis_direct_A1_inst(
    /*  axi_stream_inf.slaver */  .slaver       (in_axis    ),
    /*  axi_stream_inf.master */  .master       (out_axis   )
    );
else
    width_convert_verb #(
        .ISIZE      (IDSIZE ),
        .OSIZE      (ODSIZE )
    )width_convert_verb_inst(
    /*  input                    */     .clock          (in_axis.aclk           ),
    /*  input                    */     .rst_n          (in_axis.aresetn        ),
    /*  input [ISIZE-1:0]        */     .wr_data        (in_axis.axis_tdata     ),
    /*  input                    */     .wr_vld         (in_axis.axis_tvalid    ),
    /*  output logic             */     .wr_ready       (in_axis.axis_tready    ),
    /*  input                    */     .wr_last        (in_axis.axis_tlast     ),
    /*  input                    */     .wr_align_last  (1'b0),      //can be leave 1'b0
    /*  output logic[OSIZE-1:0]  */     .rd_data        (out_axis.axis_tdata    ),
    /*  output logic             */     .rd_vld         (out_axis.axis_tvalid   ),
    /*  input                    */     .rd_ready       (out_axis.axis_tready   ),
    /*  output                   */     .rd_last        (out_axis.axis_tlast    )
    );
    
endgenerate

endmodule
