/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.1 2018-4-19 12:03:39
    use data_c_pipe_in to replace data_connect_pipe_inf
creaded: 2017/7/28 
madified:
***********************************************/
`timescale 1ns/1ps
`include "define_macro.sv"
(* data_inf_c = "true" *)
module data_mirrors #(
    parameter H     = 0,
    parameter L     = 0,
    parameter NUM   = 8,
    `parameter_string MODE  = "CDS_MODE"         //(* show = "true" *)//CDS_MODE FULL_MODE
)(
    input [H:L]                   condition_data,
    (* data_up = "true" *)
    data_inf_c.slaver             data_in,
    (* data_down = "true" *)
    data_inf_c.master             data_mirror [NUM-1:0]
);

logic               clock;
logic               rst_n;

assign  clock   = data_in.clock;
assign  rst_n   = data_in.rst_n;

data_inf_c #(data_in.DSIZE) data_in_post (clock,rst_n);
// data_inf_c #(data_in.DSIZE) tmp (clock,rst_n);
data_inf_c #(data_in.DSIZE) data_out_pre (clock,rst_n);
data_inf_c #(data_in.DSIZE) data_mirror_pre [NUM-1:0](clock,rst_n);

// data_connect_pipe_inf data_connect_pipe_inf_inst1(
// /*  data_inf_c.slaver  */   .indata       (data_in        ),
// /*  data_inf_c.master  */   .outdata      (data_in_post   )
// );

data_c_pipe_inf data_c_pipe_inf_inst(
/*  data_inf_c.slaver  */   .slaver     (data_in        ),
/*  data_inf_c.master  */   .master     (data_in_post   )
);

// assign tmp.ready = 1'b0;

genvar CC;
logic [NUM-1:0] ready;
generate
for(CC=0;CC<NUM;CC++)
    assign ready[CC]    = data_mirror_pre[CC].ready;
endgenerate

logic   button;

generate
if(MODE == "CDS_MODE")
    assign  button = (&ready && data_in_post.data[H:L] == condition_data) || (data_in_post.data[H:L] != condition_data);
    // assign  button = 1 ;
else if(MODE == "FULL_MODE")
    assign  button = &ready ;
else
    assign  button = 0 ;
endgenerate

data_valve data_valve_inst(
/*  input              */   .button     (button         ),          //[1] OPEN ; [0] CLOSE
/*  data_inf_c.slaver    */   .data_in    (data_in_post   ),
/*  data_inf_c.master    */   .data_out   (data_out_pre   )
);

assign data_out_pre.ready   = 1'b1;
// data_connect_pipe_inf data_connect_pipe_inf_inst2(
// /*  data_inf_c.slaver  */   .indata       (data_out_pre        ),
// /*  data_inf_c.master  */   .outdata      (data_out            )
// );

generate
for(CC=0;CC<NUM;CC++)begin
    if(MODE == "CDS_MODE")begin
        assign data_mirror_pre[CC].valid    = data_out_pre.valid && data_out_pre.data[H:L] == condition_data;
        assign data_mirror_pre[CC].data     = data_out_pre.data;
    end else if(MODE == "FULL_MODE")begin
        assign data_mirror_pre[CC].valid    = data_out_pre.valid;
        assign data_mirror_pre[CC].data     = data_out_pre.data;
    end
end
endgenerate

generate
for(CC=0;CC<NUM;CC++)begin
// data_connect_pipe_inf data_connect_pipe_inf_inst3(
// /*  data_inf_c.slaver  */   .indata       (data_mirror_pre[CC]        ),
// /*  data_inf_c.master  */   .outdata      (data_mirror[CC]            )
// );

data_c_pipe_inf data_c_pipe_inf_inst3(
/*  data_inf_c.slaver  */   .slaver     (data_mirror_pre[CC]        ),
/*  data_inf_c.master  */   .master     (data_mirror[CC]            )
);
end
endgenerate

endmodule
