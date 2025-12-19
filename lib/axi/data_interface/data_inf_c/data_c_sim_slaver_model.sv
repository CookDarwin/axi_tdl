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
module data_c_sim_slaver_model #(
    parameter   RAM_DEPTH   = 10000
)(
    input               load_trigger,
    input [31:0]        total_length,
    input[512*8-1:0]    mem_file,
    data_inf_c.slaver   in_inf
);

int  total_length_lock;

logic [0:0] BRAM [RAM_DEPTH-1:0];

initial begin
    #(1ns);
    total_length_lock = RAM_DEPTH;
    $readmemh(mem_file, BRAM, 0, RAM_DEPTH-1);
end

always@(posedge load_trigger)begin 
    total_length_lock   = total_length;
    $readmemh(mem_file, BRAM, 0, RAM_DEPTH-1);
end

int  index;
initial begin
    index = 0;
end

always@(posedge out_inf.clock) begin 
    if(~out_inf.rst_n) index     <= 0;
    else begin 
        if(out_inf.ready) begin 
            if(index >= total_length_lock-1)begin 
                index <= 0;
            end else begin 
                index <= index + 1;
            end 
        end else begin 
            index <= index;
        end 
    end 
end 

assign out_inf.ready    = BRAM[index]; 

endmodule