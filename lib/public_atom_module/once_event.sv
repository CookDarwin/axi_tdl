/**********************************************
______________                ______________
______________ \  /\  /|\  /| ______________
______________  \/  \/ | \/ | ______________
descript:
author : Young
Version:
creaded: xxxx.xx.xx
madified:
***********************************************/
`timescale 1ns/1ps
module once_event #(
    parameter       MODE = "BOTH"           //RAISE FALL
)(
    input               clock,
    input               rst_n,
    input               signal,
    output logic        trigger
);

logic   signal_raising;
logic   signal_falling;

edge_generator edge_generator_inst(
/*input      */  .clk       (clock          ),
/*input      */  .rst_n     (rst_n          ),
/*input      */  .in        (signal         ),
/*output     */  .raising   (signal_raising ),
/*output     */  .falling   (signal_falling )
);

logic   raising;
logic   falling;

always_comb begin
    if(MODE=="BOTH" || MODE=="RAISE")
            raising     = signal_raising;
    else    raising     = 1'b0;
end

always_comb begin
    if(MODE=="BOTH" || MODE=="FALL")
            falling     = signal_falling;
    else    falling     = 1'b0;
end

always@(posedge clock,negedge  rst_n)begin:TRIGGER_RECORD_BLOCK
logic       record;
    if(~rst_n)begin
        record  <= 1'b0;
        trigger <= 1'b0;
    end else begin
        if(raising || falling)
                record  <= 1'b1;
        else    record  <= record;

        if(record)
                trigger <= 1'b0;
        else if(raising || falling)
                trigger <= 1'b1;
        else    trigger <= 1'b0;
    end
end

endmodule
