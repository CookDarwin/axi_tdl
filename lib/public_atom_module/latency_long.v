/**********************************************
______________                ______________
______________ \  /\  /|\  /| ______________
______________  \/  \/ | \/ | ______________
descript:
author : Young
Version: VERA.0.0
creaded: 2015/12/1 13:44:09
madified:
***********************************************/
`timescale 1ns/1ps
module latency_long #(
	parameter	LAT		= 100
)(
	input		clock	,
	input		rst_n	,
	input		d       ,
	output		q
);

wire	d_falling;
wire	d_raising;

edge_generator #(
	.MODE	("FAST")   // FAST NORMAL BEST
)edge_generator_inst(
	.clk			(clock			),
	.rst_n          (rst_n          ),
	.in             (d             	),
	.raising        (d_raising     	),
	.falling        (d_falling     	)
);


localparam	PLAT	= LAT-1;
localparam	DSIZE	= 	(LAT<=64)? 6 : (LAT<=128)? 7 : (LAT<=256)? 8 : 
						(LAT<=512)? 9 : (LAT<=1024)? 10 : (LAT<=2048)? 11 : (LAT<=4096)? 12 : 32;

reg [DSIZE-1:0]	fedge_cnt;
reg [DSIZE-1:0]	redge_cnt;

always@(posedge clock/*,negedge rst_n*/)begin
	if(~rst_n)	fedge_cnt	<= {DSIZE{1'b0}};
	else begin
		if(fedge_cnt == {DSIZE{1'b0}})begin
			if(d_falling)
					fedge_cnt	<= 10'd1;
			else	fedge_cnt	<= {DSIZE{1'b0}};
		end else begin
			if(fedge_cnt == PLAT)
					fedge_cnt	<= {DSIZE{1'b0}};
			else	fedge_cnt	<= fedge_cnt + 1'd1;
end end end

always@(posedge clock/*,negedge rst_n*/)begin
	if(~rst_n)	redge_cnt	<= {DSIZE{1'b0}};
	else begin
		if(redge_cnt == {DSIZE{1'b0}})begin
			if(d_raising)
					redge_cnt	<= 10'd1;
			else	redge_cnt	<= {DSIZE{1'b0}};
		end else begin
			if(redge_cnt == PLAT)
					redge_cnt	<= {DSIZE{1'b0}};
			else	redge_cnt	<= redge_cnt + 1'd1;
end end end

reg	q_reg;

always@(posedge clock/*,negedge rst_n*/)begin
	if(~rst_n)	q_reg	<= 1'b0;
	else if(fedge_cnt == PLAT)
				q_reg	<= 1'b0;
	else if(redge_cnt == PLAT)
				q_reg	<= 1'b1;
	else		q_reg	<= q_reg;
end


assign	q	= q_reg;

endmodule

	
