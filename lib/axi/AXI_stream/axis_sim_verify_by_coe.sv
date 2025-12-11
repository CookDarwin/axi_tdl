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
module axis_sim_verify_by_coe #(
    parameter  RAM_DEPTH    = 10000,
    parameter  VERIFY_KEEP  = "OFF",
    parameter  VERIFY_USER  = "OFF"
)(
    input                   load_trigger,
    input [31:0]            total_length,
    input [4095:0]          mem_file,
    axi_stream_inf.mirror   mirror_inf
);



logic [mirror_inf.DSIZE+mirror_inf.USIZE+mirror_inf.KSIZE+1-1:0] BRAM [RAM_DEPTH-1:0];
int  total_length_lock;
initial begin
    #(1ns);
    total_length_lock = RAM_DEPTH;
    $readmemh(mem_file, BRAM, 0, RAM_DEPTH-1);
end

always@(posedge load_trigger)begin 
    total_length_lock = total_length;
    $readmemh(mem_file, BRAM, 0, RAM_DEPTH-1);
end

int     index;
initial begin
    index = 0;
end

always@(posedge mirror_inf.aclk) begin 
    if(~mirror_inf.aresetn) index     <= 0;
    else begin 
        if(mirror_inf.axis_tready && mirror_inf.axis_tvalid) begin 
            if(index >= total_length_lock-1)begin 
                // index <= 0;
                index <= total_length_lock;
                if(index != total_length_lock)
                    $display(" COE READ VERIFY DONE. \n %0s\n",mem_file);
            end else begin 
                index <= index + 1;
            end 
        end else begin 
            index <= index;
        end 
    end 
end 

logic[mirror_inf.DSIZE-1:0]     axis_tdata;
logic[mirror_inf.KSIZE-1:0]     axis_tkeep;
logic[mirror_inf.USIZE-1:0]     axis_tuser;
logic                           axis_tlast;

assign {axis_tuser,axis_tkeep,axis_tlast,axis_tdata}    = BRAM[index];
// assign mirror_inf.data     = BRAM[index][mirror_inf.DSIZE-1:0];
// assign mirror_inf.valid    = BRAM[index][mirror_inf.DSIZE]; 

always@(negedge mirror_inf.aclk)begin 
    if(mirror_inf.axis_tvalid && mirror_inf.axis_tready && index < total_length_lock)begin 
        assert(axis_tdata == mirror_inf.axis_tdata)
        else begin 
            $error("coe axis_tdata<%0h> != mirror_inf.axis_tdata<%0h>",axis_tdata, mirror_inf.axis_tdata);
            $stop();
        end

        assert(axis_tlast == mirror_inf.axis_tlast)
        else begin 
            $error("coe axis_tlast<%0h> != mirror_inf.axis_tlast<%0h>",axis_tlast, mirror_inf.axis_tlast);
            $stop();
        end

        if(VERIFY_KEEP=="ON" || VERIFY_KEEP=="TRUE")begin 
            assert(axis_tkeep == mirror_inf.axis_tkeep)
            else begin 
                $error("coe axis_tkeep<%0h> != mirror_inf.axis_tkeep<%0h>",axis_tkeep, mirror_inf.axis_tkeep);
                $stop();
            end
        end

        if(VERIFY_USER=="ON" || VERIFY_USER=="TRUE")begin 
            assert(axis_tuser == mirror_inf.axis_tuser)
            else begin 
                $error("coe axis_tuser<%0h> != mirror_inf.axis_tuser<%0h>",axis_tuser, mirror_inf.axis_tuser);
            end
        end 
    end 
end 

endmodule