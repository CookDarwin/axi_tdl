/**********************************************
______________                ______________
______________ \  /\  /|\  /| ______________
______________  \/  \/ | \/ | ______________
descript:
author : Young
Version: VERA.0.0
creaded: 2015/7/23 13:56:28
madified:2015/10/30 10:56:34
***********************************************/
`timescale 1ns/1ps
module flooring #(
	parameter	DSIZE		= 16,
	parameter	CSIZE		= 4,		//must smaller than DSIZE
	parameter	OSIZE		= 8,        //must not bigger than DSIZE-CSIZE
	parameter	SEQUENTIAL	= "TRUE"
)(
	input				clock	,
	input [DSIZE-1:0]	indata  ,
	output[OSIZE-1:0]	outdata  
);


reg [OSIZE-1:0]		result;
wire[OSIZE-1:0]		cm_result;

assign	cm_result	= (indata[DSIZE-1-:CSIZE] == {CSIZE{1'b0}})? indata[DSIZE-1-CSIZE-:OSIZE] : {OSIZE{1'b1}}; 

always@(posedge clock)
	result	<= cm_result;


assign	outdata	= (SEQUENTIAL == "TRUE")? result : (SEQUENTIAL == "FALSE")? cm_result : {OSIZE{1'b0}};

endmodule

