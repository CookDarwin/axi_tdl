/**********************************************
______________                ______________
______________ \  /\  /|\  /| ______________
______________  \/  \/ | \/ | ______________
descript:
author : Young
Version: VERA.0.0
creaded: 2015/12/1 14:28:31
madified:
***********************************************/
`timescale 1ns/1ps
module latency_long_tb;

bit		clock = 0;
bit		rst_n = 0;

always #5 clock	= ~clock;

initial begin
	repeat(10)	@(posedge clock);
	rst_n	= 1;
end

bit		d;

initial begin
	d = 0   ;
	wait(rst_n);
	repeat(20) @(posedge clock);
	d = 1;
	repeat(1) @(posedge clock);
	d = 0;
end

latency_long #(
	.LAT		(5		)
)latency_long_inst(
	.clock 		(clock		),
	.rst_n	    (rst_n      ),
	.d          (d          ),
	.q          (           )
);


endmodule




