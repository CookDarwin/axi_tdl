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
module data_c_sim_master_model #(
    parameter   LOOP        = "TRUE",
    parameter   RAM_DEPTH   = 10000
)(
    input               load_trigger,
    input [31:0]        total_length,
    input[512*8-1:0]    mem_file,
    data_inf_c.master   out_inf
);


logic [out_inf.DSIZE+1-1:0] BRAM [RAM_DEPTH-1:0];
int  total_length_lock;
initial begin
    #(5ns);
    total_length_lock = RAM_DEPTH;
    $display(" -- Load File %0s",mem_file);
    $readmemh(mem_file, BRAM, 0, RAM_DEPTH-1);
end

always@(posedge load_trigger)begin 
    total_length_lock = total_length;
    $display(" -- Load File %0s",mem_file);
    $readmemh(mem_file, BRAM, 0, RAM_DEPTH-1);
end

int     index;
logic   disable_coe;
initial begin
    index = 0;
    disable_coe = 1'b0;
end


always@(posedge out_inf.clock) begin 
    if(~out_inf.rst_n) index     <= 0;
    else begin 
        if(out_inf.ready) begin 
            if(index >= total_length_lock-1)begin 
                if(LOOP == "TRUE" || LOOP == "ON")begin 
                    index <= 0;
                end else begin 
                    index   <= total_length_lock-1;
                    disable_coe <= 1'b1;
                end 
            end else begin 
                index <= index + 1;
            end 
        end else begin 
            index <= index;
        end 
    end 
end 

assign out_inf.data     = BRAM[index][out_inf.DSIZE-1:0];
assign out_inf.valid    = BRAM[index][out_inf.DSIZE] && ~disable_coe; 

endmodule