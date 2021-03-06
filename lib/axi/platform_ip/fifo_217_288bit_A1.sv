/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.1.0 2018-4-23 14:54:42
creaded: 2018-4-23 14:54:49
madified:
***********************************************/
`timescale 1ns/1ps
module fifo_217_288bit_A1 #(
    parameter DSIZE = 256
)(
    input               wr_clk,
    input               wr_rst,
    input               rd_clk,
    input               rd_rst,
    input [DSIZE-1:0]   din   ,
    input               wr_en ,
    input               rd_en ,
    output [DSIZE-1:0]  dout  ,
    output              full  ,
    output              empty ,
    output logic[8:0]   wcount,
    output logic[8:0]   rcount
);

initial begin
    assert(DSIZE>217 && DSIZE<=288)
    else begin
        $error("\n fifo_217_288bit_A1's DSIZE[%d] must in range 217->288\n",DSIZE);
        $stop;
    end
end

// FIFO_DUALCLOCK_MACRO: Dual Clock First-In, First-Out (FIFO) RAM Buffer
//                       Artix-7
// Xilinx HDL Language Template, version 2016.3

/////////////////////////////////////////////////////////////////
// DATA_WIDTH | FIFO_SIZE | FIFO Depth | RDCOUNT/WRCOUNT Width //
// ===========|===========|============|=======================//
//   37-72    |  "36Kb"   |     512    |         9-bit         //
//   19-36    |  "36Kb"   |    1024    |        10-bit         //
//   19-36    |  "18Kb"   |     512    |         9-bit         //
//   10-18    |  "36Kb"   |    2048    |        11-bit         //
//   10-18    |  "18Kb"   |    1024    |        10-bit         //
//    5-9     |  "36Kb"   |    4096    |        12-bit         //
//    5-9     |  "18Kb"   |    2048    |        11-bit         //
//    1-4     |  "36Kb"   |    8192    |        13-bit         //
//    1-4     |  "18Kb"   |    4096    |        12-bit         //
/////////////////////////////////////////////////////////////////

logic  EMPTY,FULL,RST;

assign RST = wr_rst || rd_rst;

logic [8:0]     RDCOUNT;
logic [8:0]     WRCOUNT;

FIFO_DUALCLOCK_MACRO  #(
    .ALMOST_EMPTY_OFFSET      (9'h010), // Sets the almost empty threshold
    .ALMOST_FULL_OFFSET       (9'h010),  // Sets almost full threshold
    .DATA_WIDTH               (72 ),   // Valid values are 1-72 (37-72 only valid when FIFO_SIZE="36Kb")
    .DEVICE                   ("7SERIES"),  // Target device: "7SERIES"
    .FIFO_SIZE                ("36Kb"), // Target BRAM: "18Kb" or "36Kb"
    .FIRST_WORD_FALL_THROUGH  ("TRUE") // Sets the FIFO FWFT to "TRUE" or "FALSE"
) FIFO_DUALCLOCK_MACRO_inst0 (
    .ALMOSTEMPTY    (),     // 1-bit output almost empty
    .ALMOSTFULL     (),     // 1-bit output almost full
    .DO             (dout[71:0]   ),                   // Output data, width defined by DATA_WIDTH parameter
    .EMPTY          (empty  ),    // 1-bit output empty
    .FULL           (full   ),     // 1-bit output full
    .RDCOUNT        (RDCOUNT),         // Output read count, width determined by FIFO depth
    .RDERR          (),         // 1-bit output read error
    .WRCOUNT        (WRCOUNT),         // Output write count, width determined by FIFO depth
    .WRERR          (),         // 1-bit output write error
    .DI             (din[71:0]    ),                 // Input data, width defined by DATA_WIDTH parameter
    .RDCLK          (rd_clk   ),                                             // 1-bit input read clock
    .RDEN           (rd_en ),                 // 1-bit input read enable
    .RST            (RST),                                                          // 1-bit input reset
    .WRCLK          (wr_clk   ),                                             // 1-bit input write clock
    .WREN           (wr_en )                  // 1-bit input write enable
);


FIFO_DUALCLOCK_MACRO  #(
    .ALMOST_EMPTY_OFFSET      (9'h010), // Sets the almost empty threshold
    .ALMOST_FULL_OFFSET       (9'h010),  // Sets almost full threshold
    .DATA_WIDTH               (72),   // Valid values are 1-72 (37-72 only valid when FIFO_SIZE="36Kb")
    .DEVICE                   ("7SERIES"),  // Target device: "7SERIES"
    .FIFO_SIZE                ("36Kb"), // Target BRAM: "18Kb" or "36Kb"
    .FIRST_WORD_FALL_THROUGH  ("TRUE") // Sets the FIFO FWFT to "TRUE" or "FALSE"
) FIFO_DUALCLOCK_MACRO_inst1 (
    .ALMOSTEMPTY    (),     // 1-bit output almost empty
    .ALMOSTFULL     (),     // 1-bit output almost full
    .DO             (dout[72+:72]   ),                   // Output data, width defined by DATA_WIDTH parameter
    .EMPTY          (),    // 1-bit output empty
    .FULL           (),     // 1-bit output full
    .RDCOUNT        (),         // Output read count, width determined by FIFO depth
    .RDERR          (),         // 1-bit output read error
    .WRCOUNT        (),         // Output write count, width determined by FIFO depth
    .WRERR          (),         // 1-bit output write error
    .DI             (din[72+:72]    ),                 // Input data, width defined by DATA_WIDTH parameter
    .RDCLK          (rd_clk   ),                                             // 1-bit input read clock
    .RDEN           (rd_en),                 // 1-bit input read enable
    .RST            (RST),                                                          // 1-bit input reset
    .WRCLK          (wr_clk    ),                                             // 1-bit input write clock
    .WREN           (wr_en)                  // 1-bit input write enable
);

FIFO_DUALCLOCK_MACRO  #(
    .ALMOST_EMPTY_OFFSET      (9'h010), // Sets the almost empty threshold
    .ALMOST_FULL_OFFSET       (9'h010),  // Sets almost full threshold
    .DATA_WIDTH               (72),   // Valid values are 1-72 (37-72 only valid when FIFO_SIZE="36Kb")
    .DEVICE                   ("7SERIES"),  // Target device: "7SERIES"
    .FIFO_SIZE                ("36Kb"), // Target BRAM: "18Kb" or "36Kb"
    .FIRST_WORD_FALL_THROUGH  ("TRUE") // Sets the FIFO FWFT to "TRUE" or "FALSE"
) FIFO_DUALCLOCK_MACRO_inst2 (
    .ALMOSTEMPTY    (),     // 1-bit output almost empty
    .ALMOSTFULL     (),     // 1-bit output almost full
    .DO             (dout[72*2+:72]   ),                   // Output data, width defined by DATA_WIDTH parameter
    .EMPTY          (),    // 1-bit output empty
    .FULL           (),     // 1-bit output full
    .RDCOUNT        (),         // Output read count, width determined by FIFO depth
    .RDERR          (),         // 1-bit output read error
    .WRCOUNT        (),         // Output write count, width determined by FIFO depth
    .WRERR          (),         // 1-bit output write error
    .DI             (din[72*2+:72]    ),                 // Input data, width defined by DATA_WIDTH parameter
    .RDCLK          (rd_clk   ),                                             // 1-bit input read clock
    .RDEN           (rd_en),                 // 1-bit input read enable
    .RST            (RST),                                                          // 1-bit input reset
    .WRCLK          (wr_clk    ),                                             // 1-bit input write clock
    .WREN           (wr_en)                  // 1-bit input write enable
);

FIFO_DUALCLOCK_MACRO  #(
    .ALMOST_EMPTY_OFFSET      (9'h010), // Sets the almost empty threshold
    .ALMOST_FULL_OFFSET       (9'h010),  // Sets almost full threshold
    .DATA_WIDTH               (DSIZE-72*3),   // Valid values are 1-72 (37-72 only valid when FIFO_SIZE="36Kb")
    .DEVICE                   ("7SERIES"),  // Target device: "7SERIES"
    .FIFO_SIZE                ("36Kb"), // Target BRAM: "18Kb" or "36Kb"
    .FIRST_WORD_FALL_THROUGH  ("TRUE") // Sets the FIFO FWFT to "TRUE" or "FALSE"
) FIFO_DUALCLOCK_MACRO_inst3 (
    .ALMOSTEMPTY    (),     // 1-bit output almost empty
    .ALMOSTFULL     (),     // 1-bit output almost full
    .DO             (dout[DSIZE-1:72*3]   ),                   // Output data, width defined by DATA_WIDTH parameter
    .EMPTY          (),    // 1-bit output empty
    .FULL           (),     // 1-bit output full
    .RDCOUNT        (),         // Output read count, width determined by FIFO depth
    .RDERR          (),         // 1-bit output read error
    .WRCOUNT        (),         // Output write count, width determined by FIFO depth
    .WRERR          (),         // 1-bit output write error
    .DI             (din[DSIZE-1:72*3]    ),                 // Input data, width defined by DATA_WIDTH parameter
    .RDCLK          (rd_clk   ),                                             // 1-bit input read clock
    .RDEN           (rd_en),                 // 1-bit input read enable
    .RST            (RST),                                                          // 1-bit input reset
    .WRCLK          (wr_clk    ),                                             // 1-bit input write clock
    .WREN           (wr_en)                  // 1-bit input write enable
);

// End of FIFO_DUALCLOCK_MACRO_inst instantiation

//--->> CONT <<-------------------------
always@(posedge wr_clk ,posedge RST)
    if(RST)     wcount  <= '0;
    else begin
        if(full)
                wcount  <= '1;
        else if(WRCOUNT > RDCOUNT)
                wcount  <= WRCOUNT - RDCOUNT;
        else if(WRCOUNT < RDCOUNT)
                wcount  <= WRCOUNT+512 - RDCOUNT;
        else    wcount  <= '0;
    end

always@(posedge rd_clk ,posedge RST)
    if(RST)     rcount  <= '0;
    else begin
        if(empty)
                rcount  <= '0;
        else if(WRCOUNT > RDCOUNT)
                rcount  <= WRCOUNT - RDCOUNT;
        else if(WRCOUNT < RDCOUNT)
                rcount  <= WRCOUNT+512 - RDCOUNT;
        else    rcount  <= '0;
    end
//---<< CONT >>-------------------------

endmodule
