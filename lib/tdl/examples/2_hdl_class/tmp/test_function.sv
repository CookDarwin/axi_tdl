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

module test_function (
    output  gp,
    input   inm
);

//==========================================================================
//-------- define ----------------------------------------------------------


//==========================================================================
//-------- instance --------------------------------------------------------

//==========================================================================
//-------- expression ------------------------------------------------------
typedef enum { 
    IDLE
} SE_STATE_ctrl;
SE_STATE_ctrl CSTATE_ctrl,NSTATE_ctrl;
function status(input [7:0] code,output logic [15:0] pl); 
    if(89)begin
         gp = code;
    end
endfunction:status

function logic status_xp(input [7:0] code,output logic [15:0] pl); 
     status_xp = ( ( inm!=0)|( inm!=1));
endfunction:status_xp

function SE_STATE_ctrl pre_status(input [7:0] code,output logic [15:0] pl,input SE_STATE_ctrl ll); 
    if(89)begin
         gp = code;
         pre_status = 0;
    end
endfunction:pre_status

assign  gp = status(67, gp+1,opop);
assign  gp = pre_status();
assign  gp = ( ( inm!=0)|( inm!=1));

endmodule
