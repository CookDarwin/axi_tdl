/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.0
created: 2019-12-12 15:19:27 +0800
madified:
***********************************************/
`timescale 1ns/1ps

module init_module(
    axi_stream_inf.slaver from_ethernet_udp_stream,
    axi_stream_inf.master to_ethernet_udp_stream,
    axi_inf.master        ddr_dma_inf,
    input[15:0]           source_port,
    input[15:0]           distance_port            [8-1:0]
);

//==========================================================================
//-------- define ----------------------------------------------------------
logic  clock;
logic  rst_n;
logic [3:0]  tmp0[5-1:0][5-1:0] ;
logic [0:63] from_ethernet_udp_stream_seq_value ;
logic [0:63] from_ethernet_udp_stream_full_seq_value ;
logic from_ethernet_udp_stream_seq_vld;
data_inf_c #(.DSIZE(132),.FreqM(125))  fiddidrange_inf (.clock(clock),.rst_n(rst_n));
axi_stream_inf #(.DSIZE(8),.FreqM(1.11))  cm_tb_m_from_ethernet_udp_stream (.aclk(from_ethernet_udp_stream.aclk),.aresetn(from_ethernet_udp_stream.aresetn),.aclken(1'b1));
axi_stream_inf #(.DSIZE(8),.FreqM(1.11))  from_ethernet_udp_stream_slaver_to_mirror (.aclk(from_ethernet_udp_stream.aclk),.aresetn(from_ethernet_udp_stream.aresetn),.aclken(1'b1));
//==========================================================================
//-------- instance --------------------------------------------------------
vcs_axis_comptable #(
    .ORIGIN ("slaver" ),
    .TO     ("mirror" )
)vcs_axis_comptable_from_ethernet_udp_stream_slaver_mirror_inst(
/* input        */.origin (from_ethernet_udp_stream                  ),
/* output logic */.to     (from_ethernet_udp_stream_slaver_to_mirror )
);
udp_socket_ddr_pump_A3 udp_socket_ddr_pump_a3_inst(
/* input                 */.source_port   (source_port            ),
/* input                 */.distance_port (distance_port          ),
/* input                 */.board_id      (0                      ),
/* data_inf_c.slaver     */.req_data_inf  (fiddidrange_inf        ),
/* axi_stream_inf.master */.udp_data_inf  (to_ethernet_udp_stream ),
/* axi_inf.master        */.ddr_dma_inf   (ddr_dma_inf            )
);
//==========================================================================
//-------- expression ------------------------------------------------------
assign   clock = from_ethernet_udp_stream.aclk;
assign   rst_n = from_ethernet_udp_stream.aresetn;

assign   100*78;
assign   tmp0[  100*78:89] = 90;

always_ff@(posedge clock,negedge rst_n) begin 
    if(~rst_n)begin
          fiddidrange_inf.data <= "'0";
    end
    else if(from_ethernet_udp_stream_seq_vld)begin
          fiddidrange_inf.data <= "{4'd0,from_ethernet_udp_stream_full_seq_value[0:31],from_ethernet_udp_stream_full_seq_value[32:63],from_ethernet_udp_stream_full_seq_value[0:31],from_ethernet_udp_stream_full_seq_value[32:63]}";
    end
    else begin
          fiddidrange_inf.data <= fiddidrange_inf.data;
    end
end

always_ff@(posedge clock,negedge rst_n) begin 
    if(~rst_n)begin
          fiddidrange_inf.valid <= 0;
    end
    else if(from_ethernet_udp_stream_seq_vld)begin
          fiddidrange_inf.valid <= 1;
    end
    else if(fiddidrange_inf.vld_rdy)begin
          fiddidrange_inf.valid <= 0;
    end
    else begin
          fiddidrange_inf.valid <= fiddidrange_inf.valid;
    end
end

assign   0*8;
assign   8*8 - 1;
assign   from_ethernet_udp_stream_full_seq_value[  0*8:  8*8 - 1] = from_ethernet_udp_stream_seq_value;


// FilePath:::E:/work/AXI/AXI_stream/parse_big_field_table_A2.sv
parse_big_field_table_A2#(
    .DSIZE         (8                                        ),
    .FIELD_LEN     (8                                        ),
    .FIELD_NAME    ("Big Filed"                              ),
    .TRY_PARSE     ("OFF"                                    )
) parse_big_field_table_A2_cm_tb_m_from_ethernet_udp_stream_inst(
/*  input                       */ .enable    (1'b1                                     ),
/*  output [0:DSIZE*FIELD_LEN-1]*/ .value     (from_ethernet_udp_stream_seq_value       ),
/*  output                      */ .out_valid (from_ethernet_udp_stream_seq_vld         ),
/*  axi_stream_inf.slaver       */ .cm_tb_s   (from_ethernet_udp_stream                 ),
/*  axi_stream_inf.master       */ .cm_tb_m   (cm_tb_m_from_ethernet_udp_stream         ),
/*  axi_stream_inf.mirror       */ .cm_mirror (from_ethernet_udp_stream_slaver_to_mirror)
);


// FilePath:::E:/work/AXI/AXI_stream/axis_slaver_empty.sv
axis_slaver_empty axis_slaver_empty_0_inst(
/*  axi_stream_inf.slaver*/ .slaver (cm_tb_m_from_ethernet_udp_stream)
);

endmodule
