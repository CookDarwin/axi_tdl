/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.0
created: xxxx.xx.xx
madified:
***********************************************/
`timescale 1ns/1ps

module tb_axis_split_channel_verb ();
//==========================================================================
//-------- define ----------------------------------------------------------
logic  clock;
logic  rst_n;
logic [16-1:0]  split_len ;
logic [32-1:0]  first_inf_rdy_percetage_index ;
logic [32-1:0]  first_inf_rdy_percetage[2-1:0] ;
axi_stream_inf #(.DSIZE(8),.USIZE(1)) origin_inf (.aclk(clock),.aresetn(rst_n),.aclken(1'b1)) ;
axi_stream_inf #(.DSIZE(8),.USIZE(1)) first_inf (.aclk(clock),.aresetn(rst_n),.aclken(1'b1)) ;
axi_stream_inf #(.DSIZE(8),.USIZE(1)) end_inf (.aclk(clock),.aresetn(rst_n),.aclken(1'b1)) ;
//==========================================================================
//-------- instance --------------------------------------------------------
axis_split_channel_verb axis_split_channel_verb_inst(
/* input                 */.split_len  (split_len  ),
/* axi_stream_inf.slaver */.origin_inf (origin_inf ),
/* axi_stream_inf.master */.first_inf  (first_inf  ),
/* axi_stream_inf.master */.end_inf    (end_inf    )
);
logic_sim_model #(
    .LOOP      ("TRUE" ),
    .DSIZE     (16     ),
    .RAM_DEPTH (4      )
)split_len_sim_model_inst(
/* input  */.next_at_negedge_of (origin_inf.axis_tvalid && origin_inf.axis_tready && origin_inf.axis_tlast            ),
/* input  */.next_at_posedge_of (1'b0                                                                                 ),
/* input  */.load_trigger       (1'b0                                                                                 ),
/* input  */.total_length       (4                                                                                    ),
/* input  */.mem_file           ("/var/lib/gems/2.5.0/gems/axi_tdl-0.0.10/lib/tdl/auto_script/tmp/split_len_R372.coe" ),
/* output */.data               (split_len                                                                            )
);
axis_sim_master_model #(
    .LOOP      ("TRUE" ),
    .RAM_DEPTH (246    )
)sim_model_inst_origin_inf(
/* input                 */.load_trigger (1'b0                                                                                  ),
/* input                 */.total_length (246                                                                                   ),
/* input                 */.mem_file     ("/var/lib/gems/2.5.0/gems/axi_tdl-0.0.10/lib/tdl/auto_script/tmp/origin_inf_R994.coe" ),
/* axi_stream_inf.master */.out_inf      (origin_inf                                                                            )
);
axis_sim_verify_by_coe #(
    .RAM_DEPTH   (21    ),
    .VERIFY_KEEP ("OFF" ),
    .VERIFY_USER ("OFF" )
)axis_sim_verify_by_coe_inst_first_inf(
/* input                 */.load_trigger (1'b0                                                                                 ),
/* input                 */.total_length (21                                                                                   ),
/* input                 */.mem_file     ("/var/lib/gems/2.5.0/gems/axi_tdl-0.0.10/lib/tdl/auto_script/tmp/first_inf_R285.coe" ),
/* axi_stream_inf.mirror */.mirror_inf   (first_inf                                                                            )
);
axis_sim_verify_by_coe #(
    .RAM_DEPTH   (118   ),
    .VERIFY_KEEP ("OFF" ),
    .VERIFY_USER ("OFF" )
)axis_sim_verify_by_coe_inst_end_inf(
/* input                 */.load_trigger (1'b0                                                                                ),
/* input                 */.total_length (118                                                                                 ),
/* input                 */.mem_file     ("/var/lib/gems/2.5.0/gems/axi_tdl-0.0.10/lib/tdl/auto_script/tmp/end_inf_R1971.coe" ),
/* axi_stream_inf.mirror */.mirror_inf   (end_inf                                                                             )
);
//==========================================================================
//-------- expression ------------------------------------------------------
initial begin
     clock = 1'b0;
     #(100ns);
     forever begin #(5.0ns);clock = ~clock;end;
end

initial begin
     rst_n = 1'b0;
     #(200ns);
     rst_n = ~rst_n;
end

initial begin
     first_inf_rdy_percetage_index = 0;
     first_inf_rdy_percetage[0] = 100;
     first_inf_rdy_percetage[1] = 50;
end

always@(posedge clock) begin 
    if(first_inf.axis_tvalid && first_inf.axis_tready && first_inf.axis_tlast)begin
        if( first_inf_rdy_percetage_index>=( 2-1))begin
             first_inf_rdy_percetage_index <= 0;
        end
        else begin
             first_inf_rdy_percetage_index <= ( first_inf_rdy_percetage_index+1'b1);
        end
    end
    else begin
         first_inf_rdy_percetage_index <= first_inf_rdy_percetage_index;
    end
end

always@(posedge clock) begin 
    if(~rst_n)begin
         first_inf.axis_tready <= 1'b0;
    end
    else begin
         first_inf.axis_tready <= ($urandom_range(0,99) <= first_inf_rdy_percetage[first_inf_rdy_percetage_index]);
    end
end

always@(posedge clock) begin 
    if(~rst_n)begin
         end_inf.axis_tready <= 1'b0;
    end
    else begin
         end_inf.axis_tready <= ($urandom_range(0,99) <= 50);
    end
end

endmodule
