/**********************************************
______________                ______________
______________ \  /\  /|\  /| ______________
______________  \/  \/ | \/ | ______________
descript:
author : Young
Version:
creaded: 2015/5/14 14:37:22
madified:
***********************************************/
`timescale 1ns/1ps
module broaden #(
	parameter		PHASE	= "POSITIVE",  //POSITIVE NEGATIVE
	parameter		LEN		= 4
)(
	input			clk,
	input			rst_n,
	input			d,
	output			q
);


reg	[LEN-1:0]		dq;
reg					q_reg;
always@(posedge clk/*,negedge rst_n*/)
	if(~rst_n)
		if(PHASE == "POSITIVE")
				dq	<= {LEN{1'b0}};
		else	dq	<= {LEN{1'b1}};
	else		dq	<= {dq[LEN-2:0],d};

always@(posedge clk/*,negedge rst_n*/)
	if(PHASE == "POSITIVE")
		if(~rst_n)	q_reg	<= 1'b0;
		else		q_reg	<= |dq;
	else if(PHASE == "NEGATIVE")
		if(~rst_n)	q_reg	<= 1'b1;
		else		q_reg	<= &dq;


assign	q	= q_reg;

endmodule
