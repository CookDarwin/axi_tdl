/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.1.0
    just fot tdl
Version: VERC.0.0 
    just fot tdl, use class parameter
creaded: 2017/4/5 
madified:
***********************************************/
`timescale 1ns/1ps
`include "define_macro.sv"
module axi4_direct_algin_addr_step #(
    // parameter ABANDON = "MASTER";
    parameter SLAVER_ADDR_STEP = 1024,
    // parameter MASTER_ADDR_STEP = 1024,
    parameter TERMENAL_ADDR_STEP = 1024,
    parameter TERMENAL_DSIZE = 128,
    `parameter_string MODE  = "BOTH_to_BOTH",    //ONLY_READ to BOTH,ONLY_WRITE to BOTH,BOTH to BOTH,BOTH to ONLY_READ,BOTH to ONLY_WRITE
    `parameter_string SLAVER_MODE  = "BOTH",    //
    `parameter_string MASTER_MODE  = "BOTH",    //
    //(* show = "false" *)
    `parameter_string IGNORE_IDSIZE = "FALSE",  //(* show = "false" *)
    `parameter_string IGNORE_DSIZE  = "FALSE",  //(* show = "false" *)
    `parameter_string IGNORE_ASIZE = "FALSE",   //(* show = "false" *)
    `parameter_string IGNORE_LSIZE = "FALSE"    //(* show = "false" *)
)(
    axi_inf.slaver      slaver_inf,
    axi_inf.master      master_inf
);


import SystemPkg::*;

initial begin
    #(1us);
    if(IGNORE_IDSIZE == "FALSE")begin
        assert(slaver_inf.IDSIZE <= master_inf.IDSIZE)      //idsize of slaver_inf can be smaller thane master_inf's
        else begin
            $error("SLAVER AXIS IDSIZE != MASTER AXIS IDSIZE");
            $finish;
        end
    end
    if(IGNORE_DSIZE == "FALSE")begin
        assert(slaver_inf.DSIZE == master_inf.DSIZE)
        else $error("SLAVER AXIS DSIZE != MASTER AXIS DSIZE");
    end
    // if(IGNORE_ASIZE == "FALSE")begin
    //     assert(slaver_inf.ASIZE == master_inf.ASIZE)
    //     else $error("SLAVER AXIS ASIZE != MASTER AXIS ASIZE");
    // end
    if(IGNORE_LSIZE == "FALSE")begin
        assert(slaver_inf.LSIZE == master_inf.LSIZE)
        else $error("SLAVER AXIS LSIZE != MASTER AXIS LSIZE");
    end
    case(MODE)
    "BOTH_to_BOTH","BOTH_to_ONLY_READ","BOTH_to_ONLY_WRITE":
        assert(slaver_inf.MODE =="BOTH" && SLAVER_MODE=="BOTH")
        else $error("SLAVER AXIS MODE<%s> != BOTH",slaver_inf.MODE);
    "ONLY_READ_to_BOTH":
        assert(slaver_inf.MODE == "ONLY_READ" && SLAVER_MODE=="ONLY_READ")
        else $error("SLAVER AXIS MODE != ONLY_READ");
    "ONLY_WRITE_to_BOTH","ONLY_WRITE_to_ONLY_WRITE":
        assert(slaver_inf.MODE == "ONLY_WRITE" && SLAVER_MODE=="ONLY_WRITE")
        else begin
            $error("SLAVER AXIS MODE != ONLY_WRITE");
            $finish;
        end
    "ONLY_READ_to_ONLY_READ","ONLY_READ_TO_ONLY_READ":
        assert(slaver_inf.MODE == "ONLY_READ" && SLAVER_MODE=="ONLY_READ")
        else $error("SLAVER AXIS MODE != ONLY_READ");
    "ONLY_WRITE_TO_ONLY_WRITE":
        assert(slaver_inf.MODE == "ONLY_WRITE" && SLAVER_MODE=="ONLY_WRITE")
        else $error("SLAVER AXIS MODE != ONLY_WRITE");
    default:
        assert(slaver_inf.MODE == "_____")
        else $error("SLAVER AXIS MODE ERROR")  ;
    endcase

    case(MODE)
    "ONLY_WRITE_to_BOTH","ONLY_READ_to_BOTH","BOTH_to_BOTH":
        assert(master_inf.MODE == "BOTH" && MASTER_MODE=="BOTH")
        else $error("MASTER AXIS MODE != BOTH");
    "BOTH_to_ONLY_READ":
        assert(master_inf.MODE == "ONLY_READ" && MASTER_MODE=="ONLY_READY")
        else $error("MASTER AXIS MODE != ONLY_READ");
    "BOTH_to_ONLY_WRITE","ONLY_WRITE_to_ONLY_WRITE":
        assert(master_inf.MODE == "ONLY_WRITE" && MASTER_MODE=="ONLY_WRITE")
        else $error("MASTER AXIS MODE != ONLY_WRITE");
    "ONLY_READ_to_ONLY_READ","ONLY_READ_TO_ONLY_READ":
        assert(master_inf.MODE == "ONLY_READ" && MASTER_MODE=="ONLY_READ")
        else $error("MASTER AXIS MODE != ONLY_READ");
    "ONLY_WRITE_TO_ONLY_WRITE":
        assert(master_inf.MODE == "ONLY_WRITE" && MASTER_MODE=="ONLY_WRITE")
        else $error("MASTER AXIS MODE != ONLY_WRITE");
    default:
        assert(master_inf.MODE == "_____")
        else $error("MASTER AXIS MODE<%0s> ERROR",MODE);
    endcase

end

localparam RF = $clog2(TERMENAL_DSIZE) - $clog2(slaver_inf.DSIZE) + $clog2(SLAVER_ADDR_STEP) - $clog2(TERMENAL_ADDR_STEP);

localparam FR = $clog2(TERMENAL_DSIZE) + $clog2(SLAVER_ADDR_STEP);
localparam FL = $clog2(slaver_inf.DSIZE) + $clog2(TERMENAL_ADDR_STEP);

generate
    if( (MASTER_MODE=="ONLY_WRITE") || (MASTER_MODE=="BOTH" && (SLAVER_MODE=="ONLY_WRITE" || SLAVER_MODE=="BOTH") ) )begin
        assign master_inf.axi_awid     = slaver_inf.axi_awid   ;
        
        if(FR == FL)
            assign master_inf.axi_awaddr   = slaver_inf.axi_awaddr ;
        else if(FR < FL)
            assign master_inf.axi_awaddr   = slaver_inf.axi_awaddr << (FL - FR) ;
        else if(FR > FL)
            assign master_inf.axi_awaddr   = slaver_inf.axi_awaddr >> (FR - FL) ;
        
        assign master_inf.axi_awlen    = slaver_inf.axi_awlen  ;
        assign master_inf.axi_awsize   = slaver_inf.axi_awsize ;
        assign master_inf.axi_awburst  = slaver_inf.axi_awburst;
        assign master_inf.axi_awlock   = slaver_inf.axi_awlock ;
        assign master_inf.axi_awcache  = slaver_inf.axi_awcache;
        assign master_inf.axi_awprot   = slaver_inf.axi_awprot ;
        assign master_inf.axi_awqos    = slaver_inf.axi_awqos  ;
        assign master_inf.axi_awvalid  = slaver_inf.axi_awvalid;
        assign slaver_inf.axi_awready  = master_inf.axi_awready;
        assign master_inf.axi_wdata    = slaver_inf.axi_wdata  ;
        assign master_inf.axi_wstrb    = slaver_inf.axi_wstrb  ;
        assign master_inf.axi_wlast    = slaver_inf.axi_wlast  ;
        assign master_inf.axi_wvalid   = slaver_inf.axi_wvalid ;
        assign slaver_inf.axi_wready   = master_inf.axi_wready ;
        assign master_inf.axi_bready   = slaver_inf.axi_bready ;
        assign slaver_inf.axi_bid      = master_inf.axi_bid    ;
        assign slaver_inf.axi_bresp    = master_inf.axi_bresp  ;
        assign slaver_inf.axi_bvalid   = master_inf.axi_bvalid ;
    end
endgenerate


generate
    if( (MASTER_MODE=="ONLY_READ") || (MASTER_MODE=="BOTH" && (SLAVER_MODE=="ONLY_READ" || SLAVER_MODE=="BOTH") ) )begin
        assign master_inf.axi_arid     = slaver_inf.axi_arid   ;
        // assign master_inf.axi_araddr   = slaver_inf.axi_araddr ;

        if(FR == FL)
            assign master_inf.axi_araddr   = slaver_inf.axi_araddr ;
        else if(FR < FL)
            assign master_inf.axi_araddr   = slaver_inf.axi_araddr << (FL - FR) ;
        else if(FR > FL)
            assign master_inf.axi_araddr   = slaver_inf.axi_araddr >> (FR - FL) ;

        assign master_inf.axi_arlen    = slaver_inf.axi_arlen  ;
        assign master_inf.axi_arsize   = slaver_inf.axi_arsize ;
        assign master_inf.axi_arburst  = slaver_inf.axi_arburst;
        assign master_inf.axi_arlock   = slaver_inf.axi_arlock ;
        assign master_inf.axi_arcache  = slaver_inf.axi_arcache;
        assign master_inf.axi_arprot   = slaver_inf.axi_arprot ;
        assign master_inf.axi_arqos    = slaver_inf.axi_arqos  ;
        assign master_inf.axi_arvalid  = slaver_inf.axi_arvalid;
        assign slaver_inf.axi_arready  = master_inf.axi_arready;
        assign master_inf.axi_rready   = slaver_inf.axi_rready ;
        assign slaver_inf.axi_rid      = master_inf.axi_rid    ;
        assign slaver_inf.axi_rdata    = master_inf.axi_rdata  ;
        assign slaver_inf.axi_rresp    = master_inf.axi_rresp  ;
        assign slaver_inf.axi_rlast    = master_inf.axi_rlast  ;
        assign slaver_inf.axi_rvalid   = master_inf.axi_rvalid ;
    end
endgenerate

generate 
    if(MASTER_MODE=="BOTH")begin
        if(SLAVER_MODE == "ONLY_READ")begin 
            assign master_inf.axi_awid     = '0;
            assign master_inf.axi_awaddr   = '0;
            assign master_inf.axi_awlen    = '0;
            assign master_inf.axi_awsize   = '0;
            assign master_inf.axi_awburst  = '0;
            assign master_inf.axi_awlock   = '0;
            assign master_inf.axi_awcache  = '0;
            assign master_inf.axi_awprot   = '0;
            assign master_inf.axi_awqos    = '0;
            assign master_inf.axi_awvalid  = '0;
            assign master_inf.axi_wdata    = '0;
            assign master_inf.axi_wstrb    = '0;
            assign master_inf.axi_wlast    = '0;
            assign master_inf.axi_wvalid   = '0;
            assign master_inf.axi_bready   = 1'b1;
        end if(SLAVER_MODE == "ONLY_WRITE")begin 
            assign master_inf.axi_arid     = '0;
            assign master_inf.axi_araddr   = '0;
            assign master_inf.axi_arlen    = '0;
            assign master_inf.axi_arsize   = '0;
            assign master_inf.axi_arburst  = '0;
            assign master_inf.axi_arlock   = '0;
            assign master_inf.axi_arcache  = '0;
            assign master_inf.axi_arprot   = '0;
            assign master_inf.axi_arqos    = '0;
            assign master_inf.axi_arvalid  = '0;
            assign master_inf.axi_rready   = 1'b1;
        end
    end else if(SLAVER_MODE == "BOTH")begin 
        if(MASTER_MODE == "ONLY_READ")begin 
            assign slaver_inf.axi_awready  = 1'b1;
            assign slaver_inf.axi_wready   = 1'b1;
            assign slaver_inf.axi_bid      = '0;
            assign slaver_inf.axi_bresp    = '0;
            assign slaver_inf.axi_bvalid   = '0;
        end else if(SLAVER_MODE == "ONLY_WRITE")begin 
            assign slaver_inf.axi_arready  = 1'b1;
            assign slaver_inf.axi_rid      = '0;
            assign slaver_inf.axi_rdata    = '0;
            assign slaver_inf.axi_rresp    = '0;
            assign slaver_inf.axi_rlast    = '0;
            assign slaver_inf.axi_rvalid   = '0;
        end
    end
endgenerate

endmodule
