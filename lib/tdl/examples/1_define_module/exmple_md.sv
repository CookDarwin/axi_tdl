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

module exmple_md #(
    parameter  DSIZE  = 8,
    parameter real MK = 1.1
)(
    input                   insdata,
    output                  outsdata,
    input [7:0]             inpdata,
    output [15:0]           outpdata,
    output logic[DSIZE-1:0] ldata,
    input                   clock,
    input                   rst_n
);

//==========================================================================
//-------- define ----------------------------------------------------------
logic [6-1:0]  tmp_data[9-1:0][7-1:0] ;

//==========================================================================
//-------- instance --------------------------------------------------------

//==========================================================================
//-------- expression ------------------------------------------------------
assign outsdata = insdata;

always_comb begin 
    outpdata[8:0] = inpdata;
end

always@(posedge clock,negedge rst_n) begin 
    if(~rst_n)begin
        ldata <= '0;
    end
    else begin
        ldata[DSIZE-1:0] <= (outpdata[7:0]+insdata);
    end
end

endmodule
