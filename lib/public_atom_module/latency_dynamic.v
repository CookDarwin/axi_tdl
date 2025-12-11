/**********************************************
______________                ______________
______________ \  /\  /|\  /| ______________
______________  \/  \/ | \/ | ______________
descript:
author : Young
Version: VERA.0.0
creaded: 2016/4/1 上午10:45:19
madified:
***********************************************/
`timescale 1ns/1ps
module latency_dynamic #(
	parameter	LSIZE	= 10
)(
	input		        clk	,
	input		        rst_n	,
    input [LSIZE-1:0]   lat     ,
	input		        d       ,
	output		        q
);

wire    clock;
assign  clock = clk;

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



reg [LSIZE-1:0]	fedge_cnt;
reg [LSIZE-1:0]	redge_cnt;

always@(posedge clock/*,negedge rst_n*/)begin
	if(~rst_n)	fedge_cnt	<= {LSIZE{1'b0}};
	else begin
		if(fedge_cnt == {LSIZE{1'b0}})begin
			if(d_falling)
					fedge_cnt	<= 10'd1;
			else	fedge_cnt	<= {LSIZE{1'b0}};
		end else begin
			if(fedge_cnt == lat-1'b1)
					fedge_cnt	<= {LSIZE{1'b0}};
			else	fedge_cnt	<= fedge_cnt + 1'd1;
end end end

always@(posedge clock/*,negedge rst_n*/)begin
	if(~rst_n)	redge_cnt	<= {LSIZE{1'b0}};
	else begin
		if(redge_cnt == {LSIZE{1'b0}})begin
			if(d_raising)
					redge_cnt	<= 10'd1;
			else	redge_cnt	<= {LSIZE{1'b0}};
		end else begin
			if(redge_cnt == lat-1'b1)
					redge_cnt	<= {LSIZE{1'b0}};
			else	redge_cnt	<= redge_cnt + 1'd1;
end end end

reg	q_reg;

always@(posedge clock/*,negedge rst_n*/)begin
	if(~rst_n)	q_reg	<= 1'b0;
	else if(fedge_cnt == lat-1'b1)
				q_reg	<= 1'b0;
	else if(redge_cnt == lat-1'b1)
				q_reg	<= 1'b1;
	else		q_reg	<= q_reg;
end


assign	q	= q_reg;

endmodule
