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

module axis_padding #(
    parameter  NUM = 8
)(
    axi_stream_inf.slaver   axis_in,
    axi_stream_inf.master   axis_out
);

//==========================================================================
//-------- define ----------------------------------------------------------
logic  clock;
logic  rst_n;
logic padding;
logic [$clog2(NUM+1)-1:0]  pad_cnt ;

//==========================================================================
//-------- instance --------------------------------------------------------
axis_valve axis_valve_inst(
/* input                 */.button   (~padding ),
/* axi_stream_inf.slaver */.axis_in  (axis_in  ),
/* axi_stream_inf.master */.axis_out (axis_out )
);
//==========================================================================
//-------- expression ------------------------------------------------------
assign clock = axis_in.aclk;
assign rst_n = axis_in.aresetn;

always@(posedge clock) begin 
    if(~rst_n)begin
        padding <= 1'b0;
        pad_cnt <= '0;
    end
    else begin
        if(axis_in.axis_tvalid && axis_in.axis_tready && axis_in.axis_tlast)begin
            padding <= 1'b1;
        end
        else begin
            padding <= pad_cnt>'0;
        end
        if(axis_in.axis_tvalid && axis_in.axis_tready && axis_in.axis_tlast)begin
            pad_cnt <= NUM;
        end
        else begin
            if(pad_cnt>'0)begin
                pad_cnt <= pad_cnt-1'b1;
            end
            else begin
                pad_cnt <= '0;
            end
        end
    end
end

endmodule
