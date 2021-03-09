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

module test_foreach #(
    parameter  NUM = 10
)();
//==========================================================================
//-------- define ----------------------------------------------------------
logic [32-1:0]  data[32-1:0] ;

//==========================================================================
//-------- instance --------------------------------------------------------

//==========================================================================
//-------- expression ------------------------------------------------------
always_comb begin 
    foreach(data[i1])begin
         4-i1;
        if( i1==( NUM* 4-i1))begin
             data[i1] = '0;
        end
    end
end

endmodule