/**********************************************
______________                ______________
______________ \  /\  /|\  /| ______________
______________  \/  \/ | \/ | ______________
descript:
author : Young
Version:
creaded: XXXX.XX.XX
madified:
***********************************************/
`timescale 1ns/1ps
module bits_decode_nc #(
    parameter NUM       = 16,
    parameter NSIZE     = $clog2(NUM),
    parameter MODE      = "H"       //Hight BIT first
)(
    input [NUM-1:0]             bits,
    output logic [NSIZE-1:0]    code
);

int KK;
generate
if(MODE!="H")begin
    always_comb begin
        code = NUM-1;
        for(KK=NUM;KK>0;KK--)begin
            if(bits[KK-1])
                    code    = KK-1;
            else    code    = code;
        end
    end
end else begin
    always_comb begin
        code = 0;
        for(KK=0;KK<NUM;KK++)begin
            if(bits[KK])
                    code    = KK;
            else    code    = code;
        end
    end
end
endgenerate

endmodule : bits_decode_nc

module bits_decode #(
    parameter NUM       = 16,
    parameter NSIZE     = $clog2(NUM),
    parameter MODE      = "H"       //Hight BIT first
)(
    input                       clock,
    input                       rst_n,
    input [NUM-1:0]             bits,
    output logic [NSIZE-1:0]    code
);

logic [NSIZE-1:0]   tmp;

bits_decode_nc #(
    .NUM    (NUM    ),
    .MODE   (MODE   )            //Hight BIT first
)bits_decode_nc_inst(
/*  input [NUM-1:0]          */   .bits     (bits   ),
/*  output logic [NSIZE-1:0] */   .code     (tmp    )
);

always@(posedge clock,negedge rst_n)
    if(~rst_n)  code    <= '0;
    else        code    <= tmp;

endmodule:bits_decode
