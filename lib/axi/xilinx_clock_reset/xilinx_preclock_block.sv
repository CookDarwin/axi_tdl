
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
`timescale 1ns/1ps
module xilinx_preclock_block (
    input   glbl_rstn,
    input   refclk,
    input   to_mmcm_inclk,
    input   from_mmcm_locked,
    output  to_mmcm_rst_out
);

wire idelayctrl_ready;
wire idelayctrl_reset;

// An IDELAYCTRL primitive needs to be instantiated for the Fixed Tap Delay
// mode of the IDELAY.
IDELAYCTRL  #(
   .SIM_DEVICE ("7SERIES")
)
IDELAYCTRL_inst (
   .RDY                  (idelayctrl_ready),
   .REFCLK               (refclk),
   .RST                  (idelayctrl_reset)
);

// Instantiate the sharable reset logic

xilinx_share_reset xilinx_share_reset_inst
(
/*  input        */   .glbl_rstn              (glbl_rstn            ),
/*  input        */   .refclk                 (refclk               ),
/*  input        */   .idelayctrl_ready       (idelayctrl_ready     ),
/*  output       */   .idelayctrl_reset_out   (idelayctrl_reset     ),
/*  input        */   .to_mmcm_inclk          (to_mmcm_inclk        ),
/*  input        */   .from_mmcm_locked       (from_mmcm_locked     ),
/*  output       */   .to_mmcm_rst_out        (to_mmcm_rst_out      )   // The reset pulse for the MMCM.
 );


 endmodule
