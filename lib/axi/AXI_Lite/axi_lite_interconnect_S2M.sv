/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.0
creaded: 2016/12/27 
madified:
***********************************************/
`timescale 1ns/1ps
module axi_lite_interconnect_S2M #(
    parameter NUM   = 4
)(
     axi_lite_inf.slaver     s00,
     axi_lite_inf.master     m00 [NUM-1:0]
);
localparam NSIZE =  $clog2(NUM);
//--->> STREAM CLOCK AND RESET <<-------------------
wire        clock,rst_n;
assign      clock   = s00.axi_aclk;
assign      rst_n   = s00.axi_aresetn;
//---<< STREAM CLOCK AND RESET >>-------------------

import SystemPkg::*;

initial begin
    assert(s00.ASIZE == (m00[0].ASIZE+NSIZE) )
    else begin
	$error("Lite S2M ASIZE ERROR!!!");
	$stop;
    end
end
//--->> WR CMD CHANNEL <<--------------------
// logic [3:0] aw_from_down_ready;
// logic [3:0] aw_to_down_vld;
// logic [ASIZE-1:0] awaddr        [3:0];
//
// assign m00.axi_awvalid  = aw_to_down_vld[0];
// assign m00.axi_awaddr   = awaddr[0];
//
// assign m01.axi_awvalid  = aw_to_down_vld[1];
// assign m01.axi_awaddr   = awaddr[1];
//
// assign m02.axi_awvalid  = aw_to_down_vld[2];
// assign m02.axi_awaddr   = awaddr[2];
//
// assign m03.axi_awvalid  = aw_to_down_vld[3];
// assign m03.axi_awaddr   = awaddr[3];

// assign aw_from_down_ready[0]    = m00.axi_awready;
// assign aw_from_down_ready[1]    = m01.axi_awready;
// assign aw_from_down_ready[2]    = m02.axi_awready;
// assign aw_from_down_ready[3]    = m03.axi_awready;


genvar KK;
//--->> IMPORT EXPORT GET ADDR FUNCTION <<------------
// generate
// for(KK=0;KK<NUM;KK++)begin
// Mlite_connect_addr #(NUM) Mlite_connect_addr_inst (s00,m00);
// end
// endgenerate
//---<< IMPORT EXPORT GET ADDR FUNCTION >>------------
// generate
// for(KK=0;KK<4;KK++)begin:WR_CMD_BLOCK
// data_connect_pipe #(
//     .DSIZE          (ASIZE)
// )wr_cmd_connect_pipe_inst(
// /*    input              */ .clock             (clock                                            ),
// /*    input              */ .rst_n             (rst_n                                            ),
// /*    input              */ .clk_en            (1'b1                                             ),
// /*    input              */ .from_up_vld       (s00.axi_awvalid && s00.axi_awaddr[ASIZE+2-1-:2]==KK   ),
// /*    input [DSIZE-1:0]  */ .from_up_data      (s00.axi_awaddr[ASIZE-1:0]                             ),
// /*    output             */ .to_up_ready       (s00.axi_awready                                       ),
// /*    input              */ .from_down_ready   (aw_from_down_ready[KK]                                ),
// /*    output             */ .to_down_vld       (aw_to_down_vld[KK]                                    ),
// /*    output[DSIZE-1:0]  */ .to_down_data      (awaddr[KK]                                            )
// );
// end
// endgenerate

data_inf #(.DSIZE(s00.ASIZE-NSIZE) ) m_wcmd_inf [NUM-1:0] ();
data_inf #(.DSIZE(s00.ASIZE-NSIZE) ) s_wcmd_inf ();

generate
for(KK=0;KK<NUM;KK++)begin
assign  m00[KK].axi_awvalid = m_wcmd_inf[KK].valid;
assign  m00[KK].axi_awaddr  = m_wcmd_inf[KK].data;
assign m_wcmd_inf[KK].ready = m00[KK].axi_awready;
end
endgenerate

assign s_wcmd_inf.valid       = s00.axi_awvalid;
assign s_wcmd_inf.data        = s00.axi_awaddr;
assign s00.axi_awready        = s_wcmd_inf.ready;

data_pipe_interconnect_S2M_verb #(
    .DSIZE      (s00.ASIZE-NSIZE      ),
    .NUM        (NUM        )
)wr_cmd_pipe_interconnect_S2M_inst(
/*    input           */    .clock              (clock                          ),
/*    input           */    .rst_n              (rst_n                          ),
/*    input           */    .clk_en             (1'b1                           ),
/*    input [2:0]     */    .addr               (s00.axi_awaddr[s00.ASIZE-1-:NSIZE]   ),       // sync to s00.valid
/*    data_inf.master */    .m00                (m_wcmd_inf[NUM-1:0]            ),//[NUM-1:0]
/*    data_inf.slaver */    .s00                (s_wcmd_inf                     )
);
//---<< WR CMD CHANNEL >>--------------------
//--->> WR LOCK <<---------------------------
data_inf #(.DSIZE(1) ) m_wlock_inf [NUM-1:0] ();
data_inf #(.DSIZE(1) ) s_wlock_inf ();

generate
for(KK=0;KK<NUM;KK++)begin:WLOCK_GEN
// assign  m00[KK].axi_awvalid = m_wlock_inf[KK].valid;
assign  m00[KK].axi_awlock  = m_wlock_inf[KK].data && m_wlock_inf[KK].valid;
assign m_wlock_inf[KK].ready = m00[KK].axi_awready || 1'b1;
end
endgenerate

assign s_wlock_inf.valid       = s00.axi_awlock;
assign s_wlock_inf.data        = s00.axi_awlock;
// assign s00.axi_awready        = s_wlock_inf.ready;

data_pipe_interconnect_S2M_verb #(
    .DSIZE      (1      ),
    .NUM        (NUM        )
)wr_lock_pipe_interconnect_S2M_inst(
/*    input           */    .clock              (clock                          ),
/*    input           */    .rst_n              (rst_n                          ),
/*    input           */    .clk_en             (1'b1                           ),
/*    input [2:0]     */    .addr               (s00.axi_awaddr[s00.ASIZE-1-:NSIZE]   ),       // sync to s00.valid
/*    data_inf.master */    .m00                (m_wlock_inf[NUM-1:0]            ),//[NUM-1:0]
/*    data_inf.slaver */    .s00                (s_wlock_inf                     )
);
//---<< WR LOCK >>---------------------------
//--->> RD CMD CHANNEL <<--------------------

data_inf #(.DSIZE(s00.ASIZE-NSIZE) ) m_rcmd_inf [NUM-1:0] ();
data_inf #(.DSIZE(s00.ASIZE-NSIZE) ) s_rcmd_inf ();

generate
for(KK=0;KK<NUM;KK++)begin
assign  m00[KK].axi_arvalid  = m_rcmd_inf[KK].valid;
assign  m00[KK].axi_araddr   = m_rcmd_inf[KK].data;
assign  m_rcmd_inf[KK].ready = m00[KK].axi_arready;
end
endgenerate

assign s_rcmd_inf.valid       = s00.axi_arvalid;
assign s_rcmd_inf.data        = s00.axi_araddr;
assign s00.axi_arready        = s_rcmd_inf.ready;


data_pipe_interconnect_S2M_verb #(
    .DSIZE      (s00.ASIZE-NSIZE      ),
    .NUM        (NUM        )
)rd_cmd_pipe_interconnect_S2M_inst(
/*    input           */    .clock              (clock                          ),
/*    input           */    .rst_n              (rst_n                          ),
/*    input           */    .clk_en             (1'b1                           ),
/*    input [2:0]     */    .addr               (s00.axi_araddr[s00.ASIZE-1-:NSIZE]   ),       // sync to s00.valid
/*    data_inf.master */    .m00                (m_rcmd_inf[NUM-1:0]            ),//[NUM-1:0]
/*    data_inf.slaver */    .s00                (s_rcmd_inf                     )
);
//---<< RD CMD CHANNEL >>--------------------
//--->> RD LOCK <<---------------------------
data_inf #(.DSIZE(1) ) m_rlock_inf [NUM-1:0] ();
data_inf #(.DSIZE(1) ) s_rlock_inf ();

generate
for(KK=0;KK<NUM;KK++)begin:RLOCK_GEN
// assign  m00[KK].axi_awvalid = m_wlock_inf[KK].valid;
assign  m00[KK].axi_arlock  = m_rlock_inf[KK].data && m_rlock_inf[KK].valid;
assign  m_rlock_inf[KK].ready = m00[KK].axi_arready || 1'b1;
end
endgenerate

assign s_rlock_inf.valid       = s00.axi_arlock;
assign s_rlock_inf.data        = s00.axi_arlock;
// assign s00.axi_awready        = s_wlock_inf.ready;

data_pipe_interconnect_S2M_verb #(
    .DSIZE      (1      ),
    .NUM        (NUM        )
)rd_lock_pipe_interconnect_S2M_inst(
/*    input           */    .clock              (clock                          ),
/*    input           */    .rst_n              (rst_n                          ),
/*    input           */    .clk_en             (1'b1                           ),
/*    input [2:0]     */    .addr               (s00.axi_araddr[s00.ASIZE-1-:NSIZE]   ),       // sync to s00.valid
/*    data_inf.master */    .m00                (m_rlock_inf[NUM-1:0]            ),//[NUM-1:0]
/*    data_inf.slaver */    .s00                (s_rlock_inf                     )
);
//---<< RD LOCK >>---------------------------
//--->> LOCK WR DATA CHANNEL <<--------------
//---<< LOCK WR DATA CHANNEL >>--------------
//--->> WR DATA CHANNEL <<-------------------
data_inf #(.DSIZE(s00.DSIZE) ) m_wdata_inf [NUM-1:0] ();
data_inf #(.DSIZE(s00.DSIZE) ) s_wdata_inf ();

generate
for(KK=0;KK<NUM;KK++)begin
assign  m00[KK].axi_wvalid    = m_wdata_inf[KK].valid;
assign  m00[KK].axi_wdata     = m_wdata_inf[KK].data;
assign  m_wdata_inf[KK].ready = m00[KK].axi_wready;
end
endgenerate

assign s_wdata_inf.valid     = s00.axi_wvalid;
assign s_wdata_inf.data      = s00.axi_wdata;
assign s00.axi_wready        = s_wdata_inf.ready;

data_pipe_interconnect_S2M_verb #(
    .DSIZE      (s00.DSIZE      ),
    .NUM        (NUM        )
)wr_data_pipe_interconnect_S2M_inst(
/*    input           */    .clock              (clock                          ),
/*    input           */    .rst_n              (rst_n                          ),
/*    input           */    .clk_en             (1'b1                           ),
/*    input [2:0]     */    .addr               (s00.axi_awaddr[s00.ASIZE-1-:NSIZE]   ),       // sync to s00.valid
/*    data_inf.master */    .m00                (m_wdata_inf[NUM-1:0]          ),//[NUM-1:0]
/*    data_inf.slaver */    .s00                (s_wdata_inf                   )
);
//---<< WR DATA CHANNEL >>-------------------
//--->> RD DATA CHANNEL <<-------------------
logic [NSIZE-1:0]     sw_path;
logic                 sw_vld;

always@(posedge clock,negedge rst_n)
    if(~rst_n)   sw_path     <= {NSIZE{1'b0}};
    else begin
        if(s00.axi_arvalid && s00.axi_arready)
                    sw_path    <= s00.axi_araddr[s00.ASIZE-1-:NSIZE];
        else        sw_path    <= sw_path;
    end

always@(posedge clock,negedge rst_n)
    if(~rst_n)   sw_vld     <= 1'd0;
    else begin
        if(s00.axi_arvalid && s00.axi_arready)
                    sw_vld    <= 1'b1;
        else if(s00.axi_rvalid && s00.axi_rready)
                    sw_vld    <= 1'b0;
        else        sw_vld    <= sw_vld;
    end

data_inf #(.DSIZE(s00.DSIZE) ) s00_rdata_inf [NUM-1:0]();
data_inf #(.DSIZE(s00.DSIZE) ) m00_rdata_inf ();

generate
for(KK=0;KK<NUM;KK++)begin
assign s00_rdata_inf[KK].data    = m00[KK].axi_rdata;
assign s00_rdata_inf[KK].valid   = m00[KK].axi_rvalid;
assign m00[KK].axi_rready        = s00_rdata_inf[KK].ready ;
end
endgenerate

assign s00.axi_rdata          =   m00_rdata_inf.data;
assign s00.axi_rvalid         =   m00_rdata_inf.valid;
assign m00_rdata_inf.ready    =   s00.axi_rready;

data_pipe_interconnect_M2S #(
    // .DSIZE      (s00.DSIZE      ),
    .NUM        (NUM        )
)rd_data_pipe_interconnect_M2S(
/*    input             */  .clock             (clock                          ),
/*    input             */  .rst_n             (rst_n                          ),
/*    input             */  .clk_en            (1'b1                           ),
/*    input             */  .vld_sw            (sw_vld                         ),
/*    input [2:0]       */  .sw                (sw_path                        ),
/*    output logic[2:0] */  .curr_path         (),

/*    data_inf.slaver   */  .s00/* [NUM-1:0],*/(s00_rdata_inf[NUM-1:0]         ),
/*    data_inf.master   */  .m00               (m00_rdata_inf                  )
);

//---<< RD DATA CHANNEL >>-------------------
//--->> RESP DATA CHANNEL <<-------------------
//--->> LOCK <<------------
logic                 wstatus;
logic                 awlock_raising;
logic                 awlock_falling;

always@(posedge clock,negedge rst_n)
    if(~rst_n)  wstatus <= 1'b0;
    else begin
        if(s00.axi_awvalid && s00.axi_awready)
                wstatus <= 1'b1;
        else if(s00.axi_bvalid && s00.axi_bready)
                wstatus <= 1'b0;
        else    wstatus <= wstatus;
    end

edge_generator aw_edge_generator_inst(
/*  input   */  .clk        (s00.axi_aclk       ),
/*  input   */  .rst_n      (s00.axi_aresetn     ),
/*  input   */  .in         (s00.axi_awlock     ),
/*  output  */  .raising    (awlock_raising     ),
/*  output  */  .falling    (awlock_falling     )
);

//---<< LOCK >>------------
logic [NSIZE-1:0]     bsw_path;
logic                 bsw_vld;

always@(posedge clock,negedge rst_n)
    if(~rst_n)   bsw_path     <= {NSIZE{1'd0}};
    else begin
        if(s00.axi_awvalid && s00.axi_awready)
                    bsw_path    <= {1'b0,s00.axi_awaddr[s00.ASIZE-1-:NSIZE]};
        else        bsw_path    <= bsw_path;
    end

always@(posedge clock,negedge rst_n)
    if(~rst_n)   bsw_vld     <= 1'd0;
    else begin
        if(s00.axi_awvalid && s00.axi_awready)
                    bsw_vld    <= 1'b1;
        else if(s00.axi_bvalid && s00.axi_bready && !s00.axi_awlock)
                    bsw_vld    <= 1'b0;
        else if(awlock_falling && !wstatus)
                    bsw_vld    <= 1'b0;
        else        bsw_vld    <= bsw_vld;
    end

data_inf #(.DSIZE(2) ) s00_bdata_inf [NUM-1:0]();
data_inf #(.DSIZE(2) ) m00_bdata_inf ();

generate
for(KK=0;KK<NUM;KK++)begin
assign s00_bdata_inf[KK].data    = m00[KK].axi_bresp;
assign s00_bdata_inf[KK].valid   = m00[KK].axi_bvalid;
assign m00[KK].axi_bready        = s00_bdata_inf[KK].ready ;
end
endgenerate

assign s00.axi_bresp          =   m00_bdata_inf.data;
assign s00.axi_bvalid         =   m00_bdata_inf.valid;
assign m00_bdata_inf.ready    =   s00.axi_bready;

data_pipe_interconnect_M2S #(
    .NUM        (NUM        )
    // .DSIZE      (2          )
)resp_data_pipe_interconnect_inst(
/*    input             */  .clock             (clock                          ),
/*    input             */  .rst_n             (rst_n                          ),
/*    input             */  .clk_en            (1'b1                           ),
/*    input             */  .vld_sw            (bsw_vld                        ),
/*    input [2:0]       */  .sw                (bsw_path                       ),
/*    output logic[2:0] */  .curr_path         (),

/*    data_inf.slaver   */  .s00               (s00_bdata_inf[NUM-1:0]         ),
/*    data_inf.master   */  .m00               (m00_bdata_inf                  )
);

//---<< RD DATA CHANNEL >>-------------------

endmodule
