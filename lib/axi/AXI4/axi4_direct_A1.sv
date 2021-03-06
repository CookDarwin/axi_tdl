/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.1.0
    just fot tdl
creaded: 2017/4/5 
madified:
***********************************************/
`timescale 1ns/1ps
`include "define_macro.sv"
(* axi4 = "true" *)
module axi4_direct_A1 #(
    `parameter_string MODE  = "BOTH_to_BOTH",    //ONLY_READ to BOTH,ONLY_WRITE to BOTH,BOTH to BOTH,BOTH to ONLY_READ,BOTH to ONLY_WRITE
    //(* show = "false" *)
    `parameter_string IGNORE_IDSIZE = "FALSE",  //(* show = "false" *)
    `parameter_string IGNORE_DSIZE  = "FALSE",  //(* show = "false" *)
    `parameter_string IGNORE_ASIZE = "FALSE",   //(* show = "false" *)
    `parameter_string IGNORE_LSIZE = "FALSE"    //(* show = "false" *)
)(
    (* axi4_up = "true" *)
    axi_inf.slaver      slaver,
    (* axi4_down = "true" *)
    axi_inf.master      master
);


import SystemPkg::*;

initial begin
    #(1us);
    if(IGNORE_IDSIZE == "FALSE")begin
        assert(slaver.IDSIZE <= master.IDSIZE)      //idsize of slaver can be smaller thane master's
        else begin
            $error("SLAVER AXIS IDSIZE != MASTER AXIS IDSIZE");
            $finish;
        end
    end
    if(IGNORE_DSIZE == "FALSE")begin
        assert(slaver.DSIZE == master.DSIZE)
        else $error("SLAVER AXIS DSIZE != MASTER AXIS DSIZE");
    end
    if(IGNORE_ASIZE == "FALSE")begin
        assert(slaver.ASIZE == master.ASIZE)
        else $error("SLAVER AXIS ASIZE != MASTER AXIS ASIZE");
    end
    if(IGNORE_LSIZE == "FALSE")begin
        assert(slaver.LSIZE == master.LSIZE)
        else $error("SLAVER AXIS LSIZE != MASTER AXIS LSIZE");
    end
    case(MODE)
    "BOTH_to_BOTH","BOTH_to_ONLY_READ","BOTH_to_ONLY_WRITE":
        assert(slaver.MODE =="BOTH")
        else $error("SLAVER AXIS MODE<%0s> != BOTH",slaver.MODE);
    "ONLY_READ_to_BOTH":
        assert(slaver.MODE == "ONLY_READ")
        else $error("SLAVER AXIS MODE != ONLY_READ");
    "ONLY_WRITE_to_BOTH","ONLY_WRITE_to_ONLY_WRITE":
        assert(slaver.MODE == "ONLY_WRITE")
        else begin
            $error("SLAVER AXIS MODE != ONLY_WRITE");
            $finish;
        end
    "ONLY_READ_to_ONLY_READ":
        assert(slaver.MODE == "ONLY_READ")
        else $error("SLAVER AXIS MODE != ONLY_READ");
    default:
        assert(slaver.MODE == "_____")
        else $error("SLAVER AXIS MODE ERROR")  ;
    endcase

    case(MODE)
    "ONLY_WRITE_to_BOTH","ONLY_READ_to_BOTH","BOTH_to_BOTH":
        assert(master.MODE == "BOTH")
        else $error("MASTER AXIS MODE != BOTH");
    "BOTH_to_ONLY_READ":
        assert(master.MODE == "ONLY_READ")
        else $error("MASTER AXIS MODE != ONLY_READ");
    "BOTH_to_ONLY_WRITE","ONLY_WRITE_to_ONLY_WRITE":
        assert(master.MODE == "ONLY_WRITE")
        else $error("MASTER AXIS MODE != ONLY_WRITE");
    "ONLY_READ_to_ONLY_READ":
        assert(master.MODE == "ONLY_READ")
        else $error("MASTER AXIS MODE != ONLY_READ");
    default:
        assert(master.MODE == "_____")
        else $error("MASTER AXIS MODE ERROR");
    endcase

end

generate
    if(master.MODE!="ONLY_READ")begin
        assign master.axi_awid     = slaver.axi_awid   ;
        assign master.axi_awaddr   = slaver.axi_awaddr ;
        assign master.axi_awlen    = slaver.axi_awlen  ;
        assign master.axi_awsize   = slaver.axi_awsize ;
        assign master.axi_awburst  = slaver.axi_awburst;
        assign master.axi_awlock   = slaver.axi_awlock ;
        assign master.axi_awcache  = slaver.axi_awcache;
        assign master.axi_awprot   = slaver.axi_awprot ;
        assign master.axi_awqos    = slaver.axi_awqos  ;
        assign master.axi_awvalid  = slaver.axi_awvalid;
        assign slaver.axi_awready  = master.axi_awready;
        assign master.axi_wdata    = slaver.axi_wdata  ;
        assign master.axi_wstrb    = slaver.axi_wstrb  ;
        assign master.axi_wlast    = slaver.axi_wlast  ;
        assign master.axi_wvalid   = slaver.axi_wvalid ;
        assign slaver.axi_wready   = master.axi_wready ;
        assign master.axi_bready   = slaver.axi_bready ;
        assign slaver.axi_bid      = master.axi_bid    ;
        assign slaver.axi_bresp    = master.axi_bresp  ;
        assign slaver.axi_bvalid   = master.axi_bvalid ;
    end
endgenerate


generate
    if(master.MODE!="ONLY_WRITE")begin
        assign master.axi_arid     = slaver.axi_arid   ;
        assign master.axi_araddr   = slaver.axi_araddr ;
        assign master.axi_arlen    = slaver.axi_arlen  ;
        assign master.axi_arsize   = slaver.axi_arsize ;
        assign master.axi_arburst  = slaver.axi_arburst;
        assign master.axi_arlock   = slaver.axi_arlock ;
        assign master.axi_arcache  = slaver.axi_arcache;
        assign master.axi_arprot   = slaver.axi_arprot ;
        assign master.axi_arqos    = slaver.axi_arqos  ;
        assign master.axi_arvalid  = slaver.axi_arvalid;
        assign slaver.axi_arready  = master.axi_arready;
        assign master.axi_rready   = slaver.axi_rready ;
        assign slaver.axi_rid      = master.axi_rid    ;
        assign slaver.axi_rdata    = master.axi_rdata  ;
        assign slaver.axi_rresp    = master.axi_rresp  ;
        assign slaver.axi_rlast    = master.axi_rlast  ;
        assign slaver.axi_rvalid   = master.axi_rvalid ;
    end
endgenerate

// generate
//     if(master.MODE == "BOTH" || master.MODE == "ONLY_WRITE")begin 
//         // if(master.MODE == "BOTH")begin 
//             if(slaver.MODE == "ONLY_WRITE")begin 
//                 assign master.axi_awid     = slaver.axi_awid   ;
//                 assign master.axi_awaddr   = slaver.axi_awaddr ;
//                 assign master.axi_awlen    = slaver.axi_awlen  ;
//                 assign master.axi_awsize   = slaver.axi_awsize ;
//                 assign master.axi_awburst  = slaver.axi_awburst;
//                 assign master.axi_awlock   = slaver.axi_awlock ;
//                 assign master.axi_awcache  = slaver.axi_awcache;
//                 assign master.axi_awprot   = slaver.axi_awprot ;
//                 assign master.axi_awqos    = slaver.axi_awqos  ;
//                 assign master.axi_awvalid  = slaver.axi_awvalid;
//                 assign slaver.axi_awready  = master.axi_awready;
//                 assign master.axi_wdata    = slaver.axi_wdata  ;
//                 assign master.axi_wstrb    = slaver.axi_wstrb  ;
//                 assign master.axi_wlast    = slaver.axi_wlast  ;
//                 assign master.axi_wvalid   = slaver.axi_wvalid ;
//                 assign slaver.axi_wready   = master.axi_wready ;
//                 assign master.axi_bready   = slaver.axi_bready ;
//                 assign slaver.axi_bid      = master.axi_bid    ;
//                 assign slaver.axi_bresp    = master.axi_bresp  ;
//                 assign slaver.axi_bvalid   = master.axi_bvalid ;

//                 assign master.axi_arid     = '0 ;
//                 assign master.axi_araddr   = '0 ;
//                 assign master.axi_arlen    = '0 ;
//                 assign master.axi_arsize   = '0 ;
//                 assign master.axi_arburst  = '0 ;
//                 assign master.axi_arlock   = '0 ;
//                 assign master.axi_arcache  = '0 ;
//                 assign master.axi_arprot   = '0 ;
//                 assign master.axi_arqos    = '0 ;
//                 assign master.axi_arvalid  = '0 ;
//                 assign slaver.axi_arready  = 1'b0;
//                 assign master.axi_rready   = 1'b0 ;
//                 assign slaver.axi_rid      = '0 ;
//                 assign slaver.axi_rdata    = '0 ;
//                 assign slaver.axi_rresp    = '0 ;
//                 assign slaver.axi_rlast    = '0 ;
//                 assign slaver.axi_rvalid   = '0 ;
//             end else if(slaver.MODE == "ONLY_READ")begin 
//                 assign master.axi_awid     = '0 ;
//                 assign master.axi_awaddr   = '0 ;
//                 assign master.axi_awlen    = '0 ;
//                 assign master.axi_awsize   = '0 ;
//                 assign master.axi_awburst  = '0 ;
//                 assign master.axi_awlock   = '0 ;
//                 assign master.axi_awcache  = '0 ;
//                 assign master.axi_awprot   = '0 ;
//                 assign master.axi_awqos    = '0 ;
//                 assign master.axi_awvalid  = '0 ;
//                 assign slaver.axi_awready  = '0 ;
//                 assign master.axi_wdata    = '0 ;
//                 assign master.axi_wstrb    = '0 ;
//                 assign master.axi_wlast    = '0 ;
//                 assign master.axi_wvalid   = '0 ;
//                 assign slaver.axi_wready   = '0 ;
//                 assign master.axi_bready   = '0 ;
//                 assign slaver.axi_bid      = '0 ;
//                 assign slaver.axi_bresp    = '0 ;
//                 assign slaver.axi_bvalid   = '0 ;

//                 assign master.axi_arid     = slaver.axi_arid   ;
//                 assign master.axi_araddr   = slaver.axi_araddr ;
//                 assign master.axi_arlen    = slaver.axi_arlen  ;
//                 assign master.axi_arsize   = slaver.axi_arsize ;
//                 assign master.axi_arburst  = slaver.axi_arburst;
//                 assign master.axi_arlock   = slaver.axi_arlock ;
//                 assign master.axi_arcache  = slaver.axi_arcache;
//                 assign master.axi_arprot   = slaver.axi_arprot ;
//                 assign master.axi_arqos    = slaver.axi_arqos  ;
//                 assign master.axi_arvalid  = slaver.axi_arvalid;
//                 assign slaver.axi_arready  = master.axi_arready;
//                 assign master.axi_rready   = slaver.axi_rready ;
//                 assign slaver.axi_rid      = master.axi_rid    ;
//                 assign slaver.axi_rdata    = master.axi_rdata  ;
//                 assign slaver.axi_rresp    = master.axi_rresp  ;
//                 assign slaver.axi_rlast    = master.axi_rlast  ;
//                 assign slaver.axi_rvalid   = master.axi_rvalid ;

//             end
//         // end
//     end
// endgenerate

endmodule
