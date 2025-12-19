/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.0
created: 2021-05-04 20:03:33 +0800
madified:
***********************************************/
`timescale 1ns/1ps

module sub_md0 (
    axi_stream_inf.slaver   axis_in,
    input                   enable
);

//==========================================================================
//-------- define ----------------------------------------------------------
logic  clock;
logic  rst_n;
logic [10-1:0]  cnt ;
data_inf_c #(.DSIZE(8),.FreqM(axis_in.FreqM)) inter_tf (.clock(clock),.rst_n(rst_n)) ;
//==========================================================================
//-------- instance --------------------------------------------------------

//==========================================================================
//-------- expression ------------------------------------------------------
assign clock = axis_in.aclk;
assign rst_n = axis_in.aresetn;

always_ff@(posedge clock,negedge rst_n) begin 
    if(~rst_n)begin
        cnt <= '0;
    end
    else begin
        cnt <= (cnt+1'b1);
    end
end

endmodule
