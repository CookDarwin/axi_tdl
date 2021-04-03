/**********************************************
______________                ______________
______________ \  /\  /|\  /| ______________
______________  \/  \/ | \/ | ______________
descript:
author : Young
Version: VERA.0.0
creaded: 2015/6/5 17:26:19
madified:
***********************************************/
`timescale 1ns/1ps
module latch_data #(
	parameter	DSIZE	= 8
)(
	input				enable,
	input [DSIZE-1:0]	in,
	output[DSIZE-1:0]	out
);


reg	[DSIZE-1:0]	data;

always@(enable)
	if(enable)
			data	= in;
	else	data	= data;

assign	out	= data;

endmodule
