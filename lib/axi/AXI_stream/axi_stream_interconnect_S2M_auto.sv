/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VER1.0.0
creaded: 2018-4-17 17:52:21
madified:
***********************************************/
`timescale 1ns/1ps
(* axi_stream = "true" *)
module axi_stream_interconnect_S2M_auto #(
    parameter HEAD_DUMMY    = 4,
    parameter NUM           = 4
)(
    (* axis_up = "true" *)
    axi_stream_inf.slaver      slaver,
    axi_stream_inf.master      sub_tx_inf [NUM-1:0]
);
axi_stream_inf #(.DSIZE(slaver.DSIZE)) pre_cm_tb_m  (.aclk(slaver.aclk),.aresetn(slaver.aresetn),.aclken(slaver.aclken));
// axi_stream_inf #(.DSIZE(slaver.DSIZE)) pre_mirror  (.aclk(slaver.aclk),.aresetn(slaver.aresetn),.aclken(slaver.aclken));

logic [slaver.DSIZE*HEAD_DUMMY-1:0]     route_id;
logic                                   route_id_vld;
//---------------------------------------------------------------
// `include "define_macro.sv"
// `VCS_AXIS_CPT(slaver,slaver,mirror,)

// vcs_axis_comptable #(
//     .ORIGIN ("slaver" ),
//     .TO     ("mirror" )
// )vcs_axis_comptable_inst(
// /* input  */.origin (slaver              ),
// /* output */.to     (pre_mirror          )
// );

// parse_big_field_table_A2 #(
//     .DSIZE          (slaver.DSIZE   ),
//     .FIELD_LEN      (HEAD_DUMMY     )     //MAX 16*8
// )parse_big_field_table_A2_inst(
// /*  input                        */    .enable          (1'b1           ),
// /*  output[0:DSIZE*FIELD_LEN-1]  */    .value           (route_id       ),
// /*  output logic                 */    .out_valid       (route_id_vld   ),
// /*  axi_stream_inf.slaver        */    .cm_tb_s         (slaver         ),
// /*  axi_stream_inf.master        */    .cm_tb_m         (pre_cm_tb_m    ),
// /*  axi_stream_inf.mirror        */    .cm_mirror       (pre_mirror     )
// );

parse_big_field_table_slaver #(
    .DSIZE          (slaver.DSIZE   ),
    .FIELD_LEN      (HEAD_DUMMY     )     //MAX 16*8
)parse_big_field_table_slaver_inst(
/*  input                        */    .enable          (1'b1           ),
/*  output[0:DSIZE*FIELD_LEN-1]  */    .value           (route_id       ),
/*  output logic                 */    .out_valid       (route_id_vld   ),
/*  axi_stream_inf.slaver        */    .cm_tb_s         (slaver         ),
/*  axi_stream_inf.master        */    .cm_tb_m         (pre_cm_tb_m    )
);

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

axi_stream_interconnect_S2M #(
    .NUM        (NUM      )
)interconnect_S2M_inst(
/*  input [NSIZE-1:0]     */ .addr      (route_id[$clog2(NUM)-1:0]      ),
/*  axi_stream_inf.slaver */ .s00       (pre_cm_tb_m                    ),
/*  axi_stream_inf.master */ .m00       (sub_tx_inf                     )//[NUM-1:0]
);

endmodule
