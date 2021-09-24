/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.0
creaded: XXXX.XX.XX
madified:
***********************************************/
`timescale 1ns/1ps

module data_c_pipe_sync_seam #(
    parameter  LAT   = 4,
    parameter  DSIZE = 32
)(
    input [DSIZE-1:0]   in_datas  [LAT-1:0],
    output [DSIZE-1:0]  out_datas [LAT-1:0],
    data_inf_c.slaver   in_inf,
    data_inf_c.master   out_inf
);

//==========================================================================
//-------- define ----------------------------------------------------------

data_inf_c #(.DSIZE(in_inf.DSIZE),.FreqM(in_inf.FreqM)) in_inf_array[LAT-1:0] (.clock(in_inf.clock),.rst_n(in_inf.rst_n)) ;
data_inf_c #(.DSIZE(out_inf.DSIZE),.FreqM(out_inf.FreqM)) out_inf_array[LAT-1:0] (.clock(out_inf.clock),.rst_n(out_inf.rst_n)) ;
//==========================================================================
//-------- instance --------------------------------------------------------

//==========================================================================
//-------- expression ------------------------------------------------------
generate
for(genvar KK0=0;KK0 < LAT;KK0++)begin
    data_c_pipe_sync #(
        .DSIZE (DSIZE )
    )data_c_pipe_sync_inst(
    /* input             */.in_data  (in_datas[KK0]      ),
    /* output            */.out_data (out_datas[KK0]     ),
    /* data_inf_c.slaver */.in_inf   (in_inf_array[KK0]  ),
    /* data_inf_c.master */.out_inf  (out_inf_array[KK0] )
    );
    if(KK0!=0)begin
        assign in_inf_array[KK0].valid = out_inf_array[KK0-1].valid;
        assign in_inf_array[KK0].data = out_inf_array[KK0-1].data;
        assign out_inf_array[KK0-1].ready = in_inf_array[KK0].ready;
    end end
endgenerate
//-------- CLOCKs Total 2 ----------------------
//--->> CheckClock <<----------------
logic cc_done_10,cc_same_10;
integer cc_afreq_10,cc_bfreq_10;
ClockSameDomain CheckPClock_inst_10(
/*  input         */      .aclk     (in_inf.clock           ),
/*  input         */      .bclk     (out_inf.clock          ),
/*  output logic  */      .done     (cc_done_10),
/*  output logic  */      .same     (cc_same_10),
/*  output integer */     .aFreqK   (cc_afreq_10),
/*  output integer */     .bFreqK   (cc_bfreq_10)
);

initial begin
    wait(cc_done_10);
    assert(cc_same_10)
    else begin
        $error("--- Error : `data_c_pipe_sync_seam` clock is not same, in_inf.clock< %0f M> != out_inf.clock<%0f M>",1000000.0/cc_afreq_10, 1000000.0/cc_bfreq_10);
        repeat(10)begin 
            @(posedge in_inf.clock);
        end
        $stop;
    end
end
//---<< CheckClock >>----------------

//======== CLOCKs Total 2 ======================
assign in_inf_array[0].valid = in_inf.valid;
assign in_inf_array[0].data = in_inf.data;
assign in_inf.ready = in_inf_array[0].ready;

assign out_inf.data = out_inf_array[LAT-1].data;
assign out_inf.valid = out_inf_array[LAT-1].valid;
assign out_inf_array[LAT-1].ready = out_inf.ready;

endmodule
