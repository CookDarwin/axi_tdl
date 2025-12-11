/**********************************************
______________                ______________
______________ \  /\  /|\  /| ______________
______________  \/  \/ | \/ | ______________
descript:
author : Young
Version: VERA.0.0
creaded: 2015/7/9 9:20:55
madified:
***********************************************/
`timescale 1ns/1ps
module pipe_reg_2write_port #(
	parameter		DSIZE	= 8
)(
	input				clock			,
	input				rst_n           ,
	input				wr_en0          ,
	input [DSIZE-1:0]	indata0         ,
	input				wr_en1          ,
	input [DSIZE-1:0]	indata1         ,
	input				low_empty       ,
	output				valid           ,
	output				curr_empty      ,
	output				sum_empty       ,
	output[DSIZE-1:0]	outdata          
);

wire[DSIZE-1:0]		indata;
wire				wr_en;

assign indata	= wr_en0? indata0 : (wr_en1? indata0 :{DSIZE{1'b0}});
assign wr_en	= wr_en0 | wr_en1;

/*
table  
higher_vld(wr_en)   curr_valid  low_empty :  next_valid   next_data  curr_empty sum_empty
     1                  1           1     :      1           U           0        curr_empty | low_empty  
     1                  1           0     :      1           K           0        curr_empty | low_empty
     1                  0           1     :      1           U           0        curr_empty | low_empty
     1                  0           0     :      1           U           0        curr_empty | low_empty
     0                  1           1     :      0           C           1        curr_empty | low_empty
     0                  1           0     :      1           K           0        curr_empty | low_empty
     0                  0           1     :      0           C           1        curr_empty | low_empty
     0                  0           0     :      0           C           1        curr_empty | low_empty
*/

reg					data_vld;
reg[DSIZE-1:0]		data_reg;

always@(posedge clock/*,negedge rst_n*/)
	if(~rst_n)	data_vld	<= 1'b0;
	else 
		case({wr_en,data_vld,low_empty})
		3'b111,
		3'b110,
		3'b101,
		3'b100,
		3'b010:	data_vld	<= 1'b1;
		default:data_vld	<= 1'b0;
		endcase

always@(posedge clock/*,negedge rst_n*/)
	if(~rst_n)	data_reg	<= {DSIZE{1'b0}};
	else 
		case({wr_en,data_vld,low_empty})
		3'b111:	data_reg	<= indata;
		3'b110:	data_reg	<= data_reg;
		3'b101:	data_reg	<= indata;
		3'b100:	data_reg	<= indata;
		3'b011:	data_reg	<= {DSIZE{1'b0}};
		3'b010: data_reg	<= data_reg;
		3'b001:	data_reg	<= {DSIZE{1'b0}};
		3'b000:	data_reg	<= {DSIZE{1'b0}};
		default:data_reg	<= {DSIZE{1'b0}};
		endcase


assign	curr_empty	= !data_vld;
assign	outdata		= data_reg;
assign	valid		= data_vld;
assign	sum_empty	= curr_empty | low_empty;

endmodule
	
