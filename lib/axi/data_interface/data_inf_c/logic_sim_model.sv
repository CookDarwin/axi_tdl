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
module logic_sim_model #(
    parameter   LOOP        = "TRUE",
    parameter   DSIZE       = 32,
    parameter   RAM_DEPTH   = 10000
)(
    input               next_at_negedge_of,
    input               next_at_posedge_of,
    input               load_trigger,
    input [31:0]        total_length,
    input[512*8-1:0]    mem_file,
    output[DSIZE-1:0]   data
);


logic [DSIZE+1-1:0] BRAM [RAM_DEPTH-1:0];
int  total_length_lock;
int  index;

initial begin
    #(1ns);
    total_length_lock = RAM_DEPTH;
    $readmemh(mem_file, BRAM, 0, RAM_DEPTH-1);
end

always@(posedge load_trigger)begin 
    total_length_lock = total_length;
    index = 0;
    $readmemh(mem_file, BRAM, 0, RAM_DEPTH-1);
end

logic init_lock;
initial begin
    index = 0;
    init_lock = 1'b0;
    #(100ns);
    init_lock = 1'b1;
end

always@(negedge next_at_negedge_of,posedge next_at_posedge_of) begin 
    if(index >= total_length_lock-1)begin 
        if(LOOP=="TRUE" || LOOP=="ON")begin 
            index <= 0;
        end else begin 
            index <= total_length_lock-1;
        end 
    end else begin 
        index <= index + init_lock;
    end 
end 

assign data     = BRAM[index];

endmodule