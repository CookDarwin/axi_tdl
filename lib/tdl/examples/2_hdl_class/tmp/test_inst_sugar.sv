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

module test_inst_sugar ();
//==========================================================================
//-------- define ----------------------------------------------------------


//==========================================================================
//-------- instance --------------------------------------------------------
axi_stream_cache axi_stream_cache_inst(
/* axi_stream_inf.slaver */.axis_in  ("x"  ),
/* axi_stream_inf.master */.axis_out ("xx" )
);
axi_stream_cache axi_stream_cache_inst1(
/* axi_stream_inf.slaver */.axis_in  ("x"  ),
/* axi_stream_inf.master */.axis_out ("xx" )
);
axi_stream_cache axi_stream_cache_inst2(
/* axi_stream_inf.slaver */.axis_in  ("x"  ),
/* axi_stream_inf.master */.axis_out ("xx" )
);
axis_append_A1 axis_append_A1_inst(
/* input                 */.enable     (1'b1 ),
/* input                 */.head_value (0    ),
/* input                 */.end_value  (0    ),
/* axi_stream_inf.slaver */.origin_in  ("x"  ),
/* axi_stream_inf.master */.append_out ("xx" )
);
//==========================================================================
//-------- expression ------------------------------------------------------

endmodule
