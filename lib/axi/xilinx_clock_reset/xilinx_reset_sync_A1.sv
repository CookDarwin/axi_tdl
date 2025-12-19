/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.1.0 2018/3/7 
    long latency
creaded: 2016/12/9 
madified:
***********************************************/
`timescale 1ps/1ps

(* dont_touch = "yes" *)
module xilinx_reset_sync_A1 #(
  parameter INITIALISE = 1'b1,
  parameter DEPTH = 5
)
(
   input       reset_in,
   input       clk,
   input       enable,
   output      reset_out
);


logic           long_rst;
logic[15:0]     long_rst_cnt;

always@(posedge clk,posedge reset_in)
    if(reset_in)    long_rst_cnt    <= '0;
    else begin
        if(long_rst_cnt < 16'd1024)
                long_rst_cnt <= long_rst_cnt + 1'b1;
        else    long_rst_cnt <= long_rst_cnt;
    end

always@(posedge clk,posedge reset_in)
    if(reset_in)    long_rst <= 1'b1;
    else begin
        if(long_rst_cnt >= 16'd1024)
                long_rst <= 1'b0;
        else    long_rst <= 1'b1;
    end


  wire     reset_sync_reg0;
  wire     reset_sync_reg1;
  wire     reset_sync_reg2;
  wire     reset_sync_reg3;
  wire     reset_sync_reg4;

  (* ASYNC_REG = "TRUE", SHREG_EXTRACT = "NO" *)
  FDPE #(
   .INIT (INITIALISE[0])
  ) reset_sync0 (
  .C  (clk),
  .CE (enable),
  .PRE(reset_in || long_rst),
  .D  (1'b0),
  .Q  (reset_sync_reg0)
  );

  (* ASYNC_REG = "TRUE", SHREG_EXTRACT = "NO" *)
  FDPE #(
   .INIT (INITIALISE[0])
  ) reset_sync1 (
  .C  (clk),
  .CE (enable),
  .PRE(reset_in || long_rst),
  .D  (reset_sync_reg0),
  .Q  (reset_sync_reg1)
  );

  (* ASYNC_REG = "TRUE", SHREG_EXTRACT = "NO" *)
  FDPE #(
   .INIT (INITIALISE[0])
  ) reset_sync2 (
  .C  (clk),
  .CE (enable),
  .PRE(reset_in || long_rst),
  .D  (reset_sync_reg1),
  .Q  (reset_sync_reg2)
  );

  (* ASYNC_REG = "TRUE", SHREG_EXTRACT = "NO" *)
  FDPE #(
   .INIT (INITIALISE[0])
  ) reset_sync3 (
  .C  (clk),
  .CE (enable),
  .PRE(reset_in || long_rst),
  .D  (reset_sync_reg2),
  .Q  (reset_sync_reg3)
  );

  (* ASYNC_REG = "TRUE", SHREG_EXTRACT = "NO" *)
  FDPE #(
   .INIT (INITIALISE[0])
  ) reset_sync4 (
  .C  (clk),
  .CE (enable),
  .PRE(reset_in || long_rst),
  .D  (reset_sync_reg3),
  .Q  (reset_sync_reg4)
  );


assign reset_out = reset_sync_reg4;


endmodule
