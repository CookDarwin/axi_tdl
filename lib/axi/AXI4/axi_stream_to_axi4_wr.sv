/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.0
creaded: 2017/3/1 
madified:
***********************************************/
`timescale 1ns/1ps
module axi_stream_to_axi4_wr (
    axi_stream_inf.slaver       axis_in,
    axi_inf.master_wr           axi_wr_inf
);

localparam FIELD_LEN    = 64/axis_in.DSIZE + (64%axis_in.DSIZE != 0);

axi_stream_inf #(.DSIZE(axis_in.DSIZE)) ps_inf              (.aclk(axis_in.aclk),.aresetn(axis_in.aresetn),.aclken(axis_in.aclken));
axi_stream_inf #(.DSIZE(axis_in.DSIZE)) ps_cache_inf              (.aclk(axis_in.aclk),.aresetn(axis_in.aresetn),.aclken(axis_in.aclken));
axi_stream_inf #(.DSIZE(axis_in.DSIZE)) ps_mirror_inf              (.aclk(axis_in.aclk),.aresetn(axis_in.aresetn),.aclken(axis_in.aclken));
axi_stream_inf #(.DSIZE(axis_in.DSIZE)) pipe_ps_inf              (.aclk(axis_in.aclk),.aresetn(axis_in.aresetn),.aclken(axis_in.aclken));
axi_stream_inf #(.DSIZE(axi_wr_inf.IDSIZE+axi_wr_inf.ASIZE+axi_wr_inf.LSIZE))
id_add_len_inf      (.aclk(axis_in.aclk),.aresetn(axis_in.aresetn),.aclken(axis_in.aclken));

axi_inf #(
    .DSIZE(axi_wr_inf.DSIZE),
    .IDSIZE(axi_wr_inf.IDSIZE),
    .ASIZE(axi_wr_inf.ASIZE),
    .LSIZE(axi_wr_inf.LSIZE),
    .MODE(axi_wr_inf.MODE),
    .ADDR_STEP(axi_wr_inf.ADDR_STEP),
    .FreqM(axi_wr_inf.FreqM)) 
axi_wr_vcs_cp_R0000 (.axi_aclk(axi_wr_inf.axi_aclk),.axi_aresetn(axi_wr_inf.axi_aresetn)) ;

logic[axis_in.DSIZE*FIELD_LEN-1:0]  value;

logic [31:0]                addr;
logic [31:0]                length;
logic                       addr_len_vld;

assign {addr,length}    = value[63:0];


parse_big_field_table #(
    .DSIZE          (axis_in.DSIZE      ),
    .FIELD_LEN      (FIELD_LEN          ),     //MAX 16*8
    .FIELD_NAME     ("Big Filed"        ),
    .TRY_PARSE      ("OFF"              )
)parse_big_field_table_inst(
/*    input                               */    .enable     (1'b1           ),
/*    input [DSIZE*FIELD_LEN-1:0]         */    .value      (value          ),
/*    output logic                        */    .out_valid  (addr_len_vld   ),
/*    axi_stream_inf.slaver               */    .cm_tb_s    (axis_in        ),
/*    axi_stream_inf.master               */    .cm_tb_m    (ps_inf         ),
/*    axi_stream_inf.mirror               */    .cm_mirror  (ps_mirror_inf  )
);

axi_stream_cache_verb axi_stream_cache_verb_inst(
/*  axi_stream_inf.slaver   */   .axis_in           (ps_inf         ),
/*  axi_stream_inf.master   */   .axis_out          (ps_cache_inf   )
);

assign ps_mirror_inf.axis_tvalid    = 1'b0;
assign ps_mirror_inf.axis_tready    = 1'b0;

assign id_add_len_inf.axis_tvalid   = addr_len_vld;
assign id_add_len_inf.axis_tdata    = {{axi_wr_inf.IDSIZE{1'b0}},addr[axi_wr_inf.ASIZE-1:0],length[axi_wr_inf.LSIZE-1:0]};

// axi4_wr_auxiliary_gen axi4_wr_auxiliary_gen_inst(
// /*    axi_stream_inf.slaver    */   .id_add_len_in  (id_add_len_inf         ),      //tlast is not necessary
// /*    axi_inf.master_wr_aux    */   .axi_wr_aux     (axi_wr_inf             )
// );

logic stream_en;

axi4_wr_auxiliary_gen_without_resp axi4_wr_auxiliary_gen_without_resp_inst(
/* output                        */.stream_en     (stream_en           ),
/* axi_stream_inf.slaver         */.id_add_len_in (id_add_len_inf      ),
/* axi_inf.master_wr_aux_no_resp */.axi_wr_aux    (axi_wr_vcs_cp_R0000 )
);

vcs_axi4_comptable #(
    .ORIGIN ("master_wr_aux_no_resp" ),
    .TO     ("master_wr"             )
)vcs_axi4_comptable_axi_wr_aux_R0001_axi_wr_inst(
/* input  */.origin (axi_wr_vcs_cp_R0000 ),
/* output */.to     (axi_wr_inf              )
);

axis_valve_with_pipe #(
    .MODE ("OUT" )
)axis_valve_with_pipe_inst(
/* input                 */.button   (stream_en ),
/* axi_stream_inf.slaver */.axis_in  (ps_cache_inf   ),
/* axi_stream_inf.master */.axis_out (pipe_ps_inf    )
);

assign pipe_ps_inf.axis_tready   = axi_wr_inf.axi_awready || axi_wr_inf.axi_wready;

assign axi_wr_inf.axi_wdata     = pipe_ps_inf.axis_tdata;
assign axi_wr_inf.axi_wvalid    = pipe_ps_inf.axis_tvalid;
assign axi_wr_inf.axi_wlast     = pipe_ps_inf.axis_tlast;

assign axi_wr_inf.axi_wstrb     = '1;

endmodule
