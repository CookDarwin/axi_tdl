/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.0
created: 2021-09-24 23:32:18 +0800
madified:
***********************************************/
`timescale 1ns/1ps

module exp_test_unit_sim (
    input clock,
    input rst_n
);

//==========================================================================
//-------- define ----------------------------------------------------------
logic enable;
axi_stream_inf #(.DSIZE(8),.FreqM(100),.USIZE(1)) axis_data_inf (.aclk(clock),.aresetn(rst_n),.aclken(1'b1)) ;
//==========================================================================
//-------- instance --------------------------------------------------------
sub_md1 sub_md1_inst(
/* axi_stream_inf.master */.axis_out (axis_data_inf ),
/* output                */.enable   (enable        )
);
sub_md0 sub_md0_inst(
/* axi_stream_inf.slaver */.axis_in (axis_data_inf ),
/* input                 */.enable  (enable        )
);
//==========================================================================
//-------- expression ------------------------------------------------------

endmodule
