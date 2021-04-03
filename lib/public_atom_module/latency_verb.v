/**********************************************
______________                ______________
______________ \  /\  /|\  /| ______________
______________  \/  \/ | \/ | ______________
descript:
author : Young
Version: VERB.0.0 :2015/12/1 15:06:34
	optimize long latency
creaded: 2015/12/1 15:05:58
madified:
***********************************************/
`timescale 1ns/1ps
module latency_verb #(
	parameter	LAT		= 10,
	parameter	DSIZE	= 1
)(
	input				clk		,
	input				rst_n	,
	input [DSIZE-1:0]	d		,
	output[DSIZE-1:0]	q
);

genvar II;

generate
if(LAT<40)begin
latency #(
	.LAT		(LAT		),
	.DSIZE		(DSIZE		)
)lat_int(
	.clk		(clk		),
	.rst_n		(rst_n		),
	.d			(d			),
	.q			(q			)
);
end else begin
for(II=0;II<DSIZE;II=II+1)begin:FOR_BLOCK
latency_long #(
	.LAT		(LAT		)
)lat_int(
	.clock		(clk		),
	.rst_n		(rst_n		),
	.d			(d[II]		),
	.q			(q[II]		)
);
end
end
endgenerate

endmodule

	
