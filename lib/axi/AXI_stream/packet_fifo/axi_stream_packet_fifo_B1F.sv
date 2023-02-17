/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERB.0.0 :
    add custom signalssync to last
Version: VERB.1.0 :2017/3/15 
    add empty size
Version: VERB.1.1 :2017/11/3 
    user xilinx_fifo_verb
Version: VERB.1.F 
    longer fifo
creaded:
madified:
***********************************************/
`timescale 1ns/1ps
module axi_stream_packet_fifo_B1F #(
    parameter DEPTH   = 2,   //2-4
    parameter CSIZE   = 1,
    parameter DSIZE   = 24,
    parameter MAX_DATA_LEN = 1024*16
)(
    input [CSIZE-1:0]        in_cdata,
    output[CSIZE-1:0]        out_cdata,
    axi_stream_inf.slaver    slaver_inf,
    axi_stream_inf.master    master_inf
);


parameter LSIZE = $clog2(1024+1);

logic   data_fifo_full;
logic   data_fifo_empty;


long_fifo_verb #(
    .DSIZE          (DSIZE         ),
    .LENGTH         (MAX_DATA_LEN  )
)long_fifo_verb_inst(
/*  input              */ .wr_clk       (slaver_inf.aclk        ),
/*  input              */ .wr_rst       (!slaver_inf.aresetn    ),
/*  input              */ .rd_clk       (master_inf.aclk       ),
/*  input              */ .rd_rst       (!master_inf.aresetn   ),
/*  input [DSIZE-1:0]  */ .din          (slaver_inf.axis_tdata  ),
/*  input              */ .wr_en        ((slaver_inf.axis_tvalid && slaver_inf.axis_tready)      ),
/*  input              */ .rd_en        ((master_inf.axis_tvalid && master_inf.axis_tready)    ),
/*  output [DSIZE-1:0] */ .dout         (master_inf.axis_tdata ),
/*  output             */ .full         (data_fifo_full      ),
/*  output             */ .empty        (data_fifo_empty     )
);

//---<< NATIVE FIFO IP >>------------------------------

//--->> PACKET <<--------------------------------------
logic   packet_fifo_full;
logic   packet_fifo_empty;
logic [15:0]      w_bytes_total;
logic [15:0]      r_bytes_total;
logic             w_total_eq_1;
logic             r_total_eq_1;

// assign w_total_eq_1 = w_bytes_total=='0;
assign w_total_eq_1 = slaver_inf.axis_tcnt =='0;

localparam IDEPTH   = (DEPTH<4)? 4 : DEPTH;

independent_clock_fifo #(
    .DEPTH      (IDEPTH     ),
    .DSIZE      (16+1+CSIZE      )
)common_independent_clock_fifo_inst(
/*    input                     */  .wr_clk     (slaver_inf.aclk        ),
/*    input                     */  .wr_rst_n   (slaver_inf.aresetn     ),
/*    input                     */  .rd_clk     (master_inf.aclk       ),
/*    input                     */  .rd_rst_n   (master_inf.aresetn    ),
/*    input [DSIZE-1:0]         */  .wdata      ({w_total_eq_1,w_bytes_total,in_cdata}      ),
/*    input                     */  .wr_en      ((slaver_inf.axis_tvalid && slaver_inf.axis_tlast && slaver_inf.axis_tready)      ),
/*    output logic[DSIZE-1:0]   */  .rdata      ({r_total_eq_1,r_bytes_total,out_cdata}      ),
/*    input                     */  .rd_en      ((master_inf.axis_tvalid && master_inf.axis_tlast && master_inf.axis_tready)    ),
/*    output logic              */  .empty      (packet_fifo_empty   ),
/*    output logic              */  .full       (packet_fifo_full    )
);

assign slaver_inf.axis_tready  = !packet_fifo_full && !data_fifo_full;
assign master_inf.axis_tvalid = !packet_fifo_empty && !data_fifo_empty;
//---<< PACKET >>--------------------------------------
//--->> bytes counter <<-------------------------------
logic reset_w_bytes;
assign #1 reset_w_bytes = slaver_inf.axis_tvalid && slaver_inf.axis_tlast && slaver_inf.axis_tready;

always@(posedge slaver_inf.aclk,negedge slaver_inf.aresetn)
    if(~slaver_inf.aresetn)    w_bytes_total   <= '0;
    else begin
        if(reset_w_bytes)
                w_bytes_total   <= '0;
        else if(slaver_inf.axis_tvalid && slaver_inf.axis_tready)
                w_bytes_total   <= w_bytes_total + 1'b1;
        else    w_bytes_total   <= w_bytes_total;
    end

logic [15:0]    out_cnt;

always@(posedge master_inf.aclk,negedge master_inf.aresetn)
    if(~master_inf.aresetn)   out_cnt <= '0;
    else begin
        if(master_inf.axis_tvalid && master_inf.axis_tlast && master_inf.axis_tready)
                out_cnt   <= '0;
        else if(master_inf.axis_tvalid && master_inf.axis_tready)
                out_cnt   <= out_cnt + 1'b1;
        else    out_cnt   <= out_cnt;
    end
//---<< bytes counter >>-------------------------------
//--->> READ LAST <<-----------------------------------
logic   native_last;

always@(posedge master_inf.aclk,negedge master_inf.aresetn)
    if(~master_inf.aresetn) native_last   <= 1'b0;
    else begin
        if(master_inf.axis_tvalid && native_last && master_inf.axis_tready)
                native_last <= 1'b0;
        else if(out_cnt == (r_bytes_total-1) && master_inf.axis_tvalid  && master_inf.axis_tready)
                native_last <= 1'b1;
        else    native_last <= native_last;
    end

assign master_inf.axis_tlast  = native_last || r_total_eq_1;
//---<< READ LAST >>-----------------------------------
endmodule
