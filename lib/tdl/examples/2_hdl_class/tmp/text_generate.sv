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

module text_generate #(
    parameter  NUM         = 8,
    parameter  BOARD_TOTAL = 4,
    parameter  WW          = "OFF"
)(
    input [NUM-1:0]         ip_s_addr          [32-1:0],
    input [NUM-1:0]         ip_d_addr          [32-1:0],
    input [NUM-1:0]         mac_s_addr         [48-1:0],
    input [NUM-1:0]         mac_d_addr         [48-1:0],
    input [15:0]            fpga_udp_ctrl_port,
    input [15:0]            fpga_udp_data_port,
    input [15:0]            fpga_udp_dire_port,
    axi_stream_inf.slaver   g10_axis_rx,
    axi_stream_inf.master   g10_axis_tx,
    axi_stream_inf.slaver   txs_udp_8bit        [1:0],
    axi_stream_inf.master   rx_udp_data_8bit   [BOARD_TOTAL-1:0],
    axi_stream_inf.master   rx_udp_dire_8bit   [BOARD_TOTAL-1:0]
);

//==========================================================================
//-------- define ----------------------------------------------------------


//==========================================================================
//-------- instance --------------------------------------------------------

//==========================================================================
//-------- expression ------------------------------------------------------
generate
for(genvar KK0=0;KK0 < NUM;KK0++)begin
    for(genvar KK1=0;KK1 < 7;KK1++)begin
        for(genvar KK2=0;KK2 < 6;KK2++)begin

            if(KK0==2)begin
                assign rx_udp_data_8bit[8*1][1*2] = "90909";
            end end
    end
end
endgenerate
assign mac_s_addr[0][0] = mac_d_addr[0][0];

endmodule
