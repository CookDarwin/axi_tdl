
/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.0
creaded: 
madified:
***********************************************/
`timescale 1ns / 1ps
module xilinx_share_reset
(
    input           glbl_rstn,
    input           refclk,
    input           idelayctrl_ready,
    output          idelayctrl_reset_out,
    input           to_mmcm_inclk,
    input           from_mmcm_locked,
    output          to_mmcm_rst_out           // The reset pulse for the MMCM.
);

   wire             glbl_rst;

   wire             idelayctrl_reset_in;       // Used to trigger reset_sync generation in refclk domain.
   wire             idelayctrl_reset_sync;     // Used to create a reset pulse in the IDELAYCTRL refclk domain.
   reg   [3:0]      idelay_reset_cnt;          // Counter to create a long IDELAYCTRL reset pulse.
   reg              idelayctrl_reset;

   wire             gtx_mmcm_rst_in;
   wire             from_mmcm_locked_int;
   wire             from_mmcm_locked_sync;
   reg              from_mmcm_locked_reg = 1;
   reg              from_mmcm_locked_edge = 1;


 assign glbl_rst              = !glbl_rstn;

 //----------------------------------------------------------------------------
 // Reset circuitry associated with the IDELAYCTRL
 //----------------------------------------------------------------------------

 assign idelayctrl_reset_out  = idelayctrl_reset;
 assign idelayctrl_reset_in   = glbl_rst || !idelayctrl_ready;

   // Create a synchronous reset in the IDELAYCTRL refclk clock domain.
   xilinx_reset_sync idelayctrl_reset_gen (
      .clk              (refclk),
      .enable           (1'b1),
      .reset_in         (idelayctrl_reset_in),
      .reset_out        (idelayctrl_reset_sync)
   );

   // Reset circuitry for the IDELAYCTRL reset.

   // The IDELAYCTRL must experience a pulse which is at least 50 ns in
   // duration.  This is ten clock cycles of the 200MHz refclk.  Here we
   // drive the reset pulse for 12 clock cycles.
   always @(posedge refclk)
   begin
      if (idelayctrl_reset_sync) begin
         idelay_reset_cnt     <= 4'b0000;
         idelayctrl_reset     <= 1'b1;
      end
      else begin
         case (idelay_reset_cnt)
            4'b0000 : idelay_reset_cnt <= 4'b0001;
            4'b0001 : idelay_reset_cnt <= 4'b0010;
            4'b0010 : idelay_reset_cnt <= 4'b0011;
            4'b0011 : idelay_reset_cnt <= 4'b0100;
            4'b0100 : idelay_reset_cnt <= 4'b0101;
            4'b0101 : idelay_reset_cnt <= 4'b0110;
            4'b0110 : idelay_reset_cnt <= 4'b0111;
            4'b0111 : idelay_reset_cnt <= 4'b1000;
            4'b1000 : idelay_reset_cnt <= 4'b1001;
            4'b1001 : idelay_reset_cnt <= 4'b1010;
            4'b1010 : idelay_reset_cnt <= 4'b1011;
            4'b1011 : idelay_reset_cnt <= 4'b1100;
            default : idelay_reset_cnt <= 4'b1100;
         endcase
         if (idelay_reset_cnt == 4'b1100) begin
            idelayctrl_reset  <= 1'b0;
         end
         else begin
            idelayctrl_reset  <= 1'b1;
         end
      end
   end


  //----------------------------------------------------------------------------
  // Reset circuitry associated with the MMCM
  //----------------------------------------------------------------------------

  assign gtx_mmcm_rst_in = glbl_rst | from_mmcm_locked_edge;

  // Synchronise the async dcm_locked into the to_mmcm_inclk clock domain
   xilinx_sync_block lock_sync (
     .clk                   (to_mmcm_inclk),
     .data_in               (from_mmcm_locked),
     .data_out              (from_mmcm_locked_sync)
  );

  // for the falling edge detect we want to force this at power on so init the flop to 1
  always @(posedge to_mmcm_inclk)
  begin
     from_mmcm_locked_reg     <= from_mmcm_locked_sync;
     from_mmcm_locked_edge    <= from_mmcm_locked_reg & !from_mmcm_locked_sync;
  end

  // the MMCM reset should be at least 5ns - that is one cycle of the input clock -
  // since the source of the input reset is unknown (a push switch in board design)
  // this needs to be debounced
   xilinx_reset_sync mmcm_reset_gen (
      .clk                  (to_mmcm_inclk),
      .enable               (1'b1),
      .reset_in             (gtx_mmcm_rst_in),
      .reset_out            (to_mmcm_rst_out)
   );


endmodule
