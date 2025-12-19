/**********************************************
______________                ______________
______________ \  /\  /|\  /| ______________
______________  \/  \/ | \/ | ______________
descript:
author : Young
Version:
creaded: 2015/5/14 14:52:00
madified:
***********************************************/
`timescale 1ns/1ps
module broaden_and_cross_clk #(
    parameter        PHASE    = "POSITIVE",  //POSITIVE NEGATIVE
    parameter        LEN        = 4,
    parameter        LAT        = 2
)(
    input            rclk,
    input            rd_rst_n,
    input            wclk,
    input            wr_rst_n,
    input            d,
    output           q
);

wire        qq;

broaden #(
    .PHASE            (PHASE),
    .LEN            (LEN)            //delay = LEN + 1
)broaden_inst(
    wclk,
    wr_rst_n,
    d,
    qq
);

cross_clk_sync #(
    .DSIZE        (1),
    .LAT        (LAT)
)cross_clk_sync_false_path(
    rclk,
    rd_rst_n,
    qq,
    q
);

endmodule
