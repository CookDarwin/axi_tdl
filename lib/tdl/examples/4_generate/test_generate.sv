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

module test_generate #(
    parameter  NUM = 8
)(
    input [7:0]      ain,
    output [7:0]     bout,
    input [5:0]      cin  [NUM-1:0],
    output [NUM-1:0] dout [6-1:0],
    input [NUM-1:0]  ein,
    output [NUM-1:0] fout
);

//==========================================================================
//-------- define ----------------------------------------------------------


//==========================================================================
//-------- instance --------------------------------------------------------

//==========================================================================
//-------- expression ------------------------------------------------------
generate
for(genvar KK0=0;KK0 < 8;KK0++)begin
    assign bout[KK0] = ain[7-(KK0)];
end
endgenerate

generate
for(genvar KK0=0;KK0 < NUM;KK0++)begin

    if(KK0<4)begin
        assign dout[KK0] = cin[KK0];
    end 
    else begin
        assign dout[KK0] = cin[KK0]+(KK0);
    end
end
endgenerate

generate
for(genvar KK0=0;KK0 < NUM;KK0++)begin
    for(genvar KK1=0;KK1 < 6;KK1++)begin
        assign fout[KK0][KK1] = ein[KK1][KK0];
    end
end
endgenerate

endmodule
