/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.1 2017/5/24 
    use axi4_data_convert_A1
Version: VERA.1.0 2017/9/30 
    can discard partition
Version: VERB.0.0 2017/12/7 
    if slaver_inf.DSIZE is not 2**N,then 'width_convert' fisrt
Version: VERB.1.0 2021/10/03
    axi4_direct_verc replace axi4_direct_verb
creaded: 2017/3/1 
madified:
***********************************************/
`timescale 1ns/1ps
`include "define_macro.sv"
module axi4_long_to_axi4_wide_B1 #(
    parameter PIPE      = "OFF",
    parameter PARTITION = "ON",         //ON OFF
    `parameter_string MODE  = "BOTH_to_BOTH",    //ONLY_READ to BOTH,ONLY_WRITE to BOTH,BOTH to BOTH,BOTH to ONLY_READ,BOTH to ONLY_WRITE
    `parameter_string SLAVER_MODE  = "BOTH",    //
    `parameter_string MASTER_MODE  = "BOTH"   //
)(
    axi_inf.slaver      slaver_inf,
    axi_inf.master      master_inf          //wide ADDR_STEP == 1
);

// localparam real ADDR_STEP = slaver_inf.DSIZE/(master_inf.DSIZE/8.0);            //addr burst == 8

import SystemPkg::*;

initial begin
    assert(slaver_inf.MODE == master_inf.MODE)
    else begin
        $error("SLAVER AXIS MODE != MASTER AXIS MODE");
        $stop;
    end
end


//--->> width first <<------------------------------

localparam  WCSIZE = 2**($clog2(slaver_inf.DSIZE));

axi_inf #(
    .IDSIZE    (slaver_inf.IDSIZE          ),
    .ASIZE     (slaver_inf.ASIZE           ),
    .LSIZE     (slaver_inf.LSIZE           ),
    .DSIZE     (WCSIZE                 ),
    .MODE      (slaver_inf.MODE            ),
    .ADDR_STEP (slaver_inf.ADDR_STEP*WCSIZE/slaver_inf.DSIZE       )
)axi_inf_first_wc(
    .axi_aclk      (slaver_inf.axi_aclk     ),
    .axi_aresetn    (slaver_inf.axi_aresetn   )
);

generate
if(WCSIZE != slaver_inf.DSIZE)
axi4_data_convert_A1 axi4_data_convert_inst(
/*    axi_inf.slaver_inf */ .axi_in     (slaver_inf             ),
/*    axi_inf.master_inf */ .axi_out    (axi_inf_first_wc   )
);
else
axi4_direct_verc #(
    .MODE           (MODE),    //ONLY_READ to BOTH,ONLY_WRITE to BOTH,BOTH to BOTH,BOTH to ONLY_READ,BOTH to ONLY_WRITE
    .SLAVER_MODE    (SLAVER_MODE),    //
    .MASTER_MODE    (MASTER_MODE)    //
)axi4_direct_verc_inst(
/*  axi_inf.slaver_inf   */ .slaver_inf     (slaver_inf             ),
/*  axi_inf.master_inf   */ .master_inf     (axi_inf_first_wc   )
);
endgenerate
//---<< width first >>------------------------------

axi_inf #(
    .IDSIZE    (master_inf.IDSIZE          ),
    .ASIZE     (axi_inf_first_wc.ASIZE           ),
    .LSIZE     (axi_inf_first_wc.LSIZE           ),
    .DSIZE     (axi_inf_first_wc.DSIZE           ),
    .MODE      (axi_inf_first_wc.MODE            ),
    .ADDR_STEP (axi_inf_first_wc.ADDR_STEP       )
)axi_inf_pout(
    .axi_aclk      (slaver_inf.axi_aclk     ),
    .axi_aresetn    (slaver_inf.axi_aresetn   )
);

axi_inf #(
    .IDSIZE    (master_inf.IDSIZE          ),
    .ASIZE     (master_inf.ASIZE           ),
    .LSIZE     (master_inf.LSIZE           ),
    .DSIZE     (master_inf.DSIZE           ),
    .MODE      (axi_inf_first_wc.MODE            ),
    .ADDR_STEP (master_inf.ADDR_STEP       )
)axi_inf_cdout(
    .axi_aclk      (slaver_inf.axi_aclk     ),
    .axi_aresetn    (slaver_inf.axi_aresetn   )
);


// localparam PSIZE = (((128/slaver_inf.DSIZE) * (slaver_inf.DSIZE+0.0)) * master_inf.DSIZE) / slaver_inf.DSIZE;
generate
if(PARTITION == "ON" || PARTITION == "TRUE")begin
axi4_partition_OD #(
    // .PSIZE          (master_inf.DSIZE*128/slaver_inf.DSIZE      ),
    .PSIZE          (int'((((128/axi_inf_first_wc.DSIZE) * (axi_inf_first_wc.DSIZE+0.0)) * master_inf.DSIZE) / axi_inf_first_wc.DSIZE      ))
    // .ADDR_STEP      (slaver_inf.DSIZE/(master_inf.DSIZE/8.0)  )
    // .ADDR_STEP      (4*slaver_inf.DSIZE/16.0  )
)axi4_partition_inst(
/*    axi_inf.slaver_inf */ .slaver_inf     (axi_inf_first_wc       ),
/*    axi_inf.master_inf */ .master_inf     (axi_inf_pout           )
);

axi4_data_convert_verb #(
    .SLAVER_MODE    (SLAVER_MODE),    //
    .MASTER_MODE    (MASTER_MODE)    //
)axi4_data_convert_inst(
/*    axi_inf.slaver_inf */ .axi_in     (axi_inf_pout   ),
/*    axi_inf.master_inf */ .axi_out    (axi_inf_cdout  )
);
end else begin
axi4_data_convert_verb #(
    .SLAVER_MODE    (SLAVER_MODE),    //
    .MASTER_MODE    (MASTER_MODE)    //
)axi4_data_convert_inst(
/*    axi_inf.slaver_inf */ .axi_in     (axi_inf_first_wc   ),
/*    axi_inf.master_inf */ .axi_out    (axi_inf_cdout      )
);

end
endgenerate


axi4_packet_fifo_verb #(             //512
    .PIPE       (PIPE   ),
    .DEPTH      (4      ),
    .SLAVER_MODE    (SLAVER_MODE ),    //
    .MASTER_MODE    (MASTER_MODE )   //
)axi4_packet_fifo_inst(
/*    axi_inf.slaver_inf */ .axi_in     (axi_inf_cdout  ),
/*    axi_inf.master_inf */ .axi_out    (master_inf        )
);

endmodule
