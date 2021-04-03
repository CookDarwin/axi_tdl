/**********************************************
______________                ______________
______________ \  /\  /|\  /| ______________
______________  \/  \/ | \/ | ______________
descript:
author : Young
Version:
creaded:
madified:
***********************************************/
module edge_generator #(
    parameter    MODE    = "NORMAL"   // FAST NORMAL BEST
)(
    input        clk,
    input        rst_n,
    input        in,
    output       raising,
    output       falling
);

reg        in_d0;
reg        in_d1;
reg        raising_reg;
reg        falling_reg;

always@(posedge clk/*,negedge rst_n*/)begin
    if(~rst_n)begin
    in_d0           <= 1'b0;
        in_d1        <= 1'b0;
        raising_reg  <= 1'b0;
        falling_reg  <= 1'b0;
    end else begin
    in_d0        <= in;
        in_d1           <= in_d0;
    if(MODE == "NORMAL")begin
    raising_reg  <= {in_d0,in} == 2'b01 ;
    falling_reg     <= {in_d0,in} == 2'b10 ;
    end else if(MODE == "BEST")begin
    raising_reg  <= {in_d1,in_d0} == 2'b01 ;
    falling_reg  <= {in_d1,in_d0} == 2'b10 ;
    end else begin
    raising_reg  <= 1'b0;
    falling_reg  <= 1'b0;
end end end


assign    raising    = (MODE == "FAST")? {in_d0,in} == 2'b01 : raising_reg;
assign    falling    = (MODE == "FAST")? {in_d0,in} == 2'b10 : falling_reg;

endmodule
