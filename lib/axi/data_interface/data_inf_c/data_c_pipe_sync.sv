/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:   covert A to B
author : Cook.Darwin
Version: VERA.0.0
creaded: 
madified:
***********************************************/
`timescale 1ns/1ps
(* data_inf_c = "true" *)
module data_c_pipe_sync #(
    parameter   DSIZE = 32

)(
    input [DSIZE-1:0]           in_data,   // as like: hdl``` assign in_data = in_inf.data + 1;
    output logic [DSIZE-1:0]    out_data,
    data_inf_c.slaver           in_inf,
    data_inf_c.master           out_inf
);

initial begin
    assert(in_inf.DSIZE == out_inf.DSIZE)
    else begin
        $error("in_inf DSIZE<%0d> != out_inf DSIZE<%0d>",in_inf.DSIZE,out_inf.DSIZE);
        $stop;
    end
end

logic   clock;
logic   rst_n;

assign  clock   = in_inf.clock;
assign  rst_n   = in_inf.rst_n;

always@(posedge clock,negedge rst_n)
    if(~rst_n)  out_inf.valid    <= 1'b0;
    else begin
        if(in_inf.valid && in_inf.ready)
                out_inf.valid    <= 1'b1;
        else if(out_inf.valid && out_inf.ready)
                out_inf.valid    <= 1'b0;
        else    out_inf.valid    <= out_inf.valid;
    end

assign in_inf.ready = !out_inf.valid || out_inf.ready;

// logic[in_inf.DSIZE-1:0] master_origin_data;


always@(posedge clock,negedge rst_n)
    if(~rst_n)begin  
        out_inf.data     <= '0;
        out_data        <= '0;
    end else begin
        if(in_inf.valid && in_inf.ready)begin 
            out_data        <= in_data;
            out_inf.data     <= in_inf.data;
        end else if(out_inf.valid && out_inf.ready)begin 
            out_inf.data     <= '0;
            out_data        <= '0;
        end else begin 
            out_inf.data     <= out_inf.data;
            out_data        <= out_data;
        end
    end
   

endmodule
