/**********************************************
______________                ______________
______________ \  /\  /|\  /| ______________
______________  \/  \/ | \/ | ______________
descript:
author : Young
Version: VERA.0.1 : 2015/10/30 10:57:22
	xxxxx = xxxx_{|x12}
Version: VERA.1.0 : 2016/3/29 下午3:26:26
    add reset signal
creaded: 2015/7/23 13:56:28
madified:2015/10/30 10:57:18
***********************************************/
`timescale 1ns/1ps
module ceiling_A1 #(
	parameter	DSIZE		= 16,
	parameter	CSIZE		= 4,		//must smaller than DSIZE
	parameter	OSIZE		= 8,        //must not bigger than DSIZE-CSIZE
	parameter	SEQUENTIAL	= "TRUE"
)(
	input				clock	,
    input               rst_n   ,
	input [DSIZE-1:0]	indata  ,
	output[OSIZE-1:0]	outdata
);


reg [OSIZE-1:0]		result;
wire[OSIZE-1:0]		cm_result;
wire				carry_bit;
assign	carry_bit	= (DSIZE>(CSIZE+OSIZE))? indata[DSIZE-1-CSIZE-OSIZE] : 1'b0;

assign	cm_result	= (indata[DSIZE-1-:CSIZE] == {CSIZE{1'b0}})? indata[DSIZE-1-CSIZE-:OSIZE]+carry_bit : {OSIZE{1'b1}};

always@(posedge clock/*,negedge rst_n*/)
    if(~rst_n)  result  <= {OSIZE{1'b0}};
    else        result	<= cm_result;


assign	outdata	= (SEQUENTIAL == "TRUE")? result : (SEQUENTIAL == "FALSE")? cm_result : {OSIZE{1'b0}};

endmodule
