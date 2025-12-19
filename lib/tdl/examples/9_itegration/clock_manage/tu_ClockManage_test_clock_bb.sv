/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.0
created: 2022-07-10 11:14:33 +0800
madified:
***********************************************/
`timescale 1ns/1ps

module tu_ClockManage_test_clock_bb(
    input        from_up_pass,
    output logic to_down_pass
);

//==========================================================================
//-------- define ----------------------------------------------------------


//==========================================================================
//-------- instance --------------------------------------------------------

//==========================================================================
//-------- expression ------------------------------------------------------
initial begin
    to_down_pass = 1'b0;
    wait(from_up_pass);
    $root.tb_test_tttop_sim.test_unit_region = "tu_ClockManage_test_clock_bb";
    $display("--------------- Current test_unit <%0s> --------------------", "tu_ClockManage_test_clock_bb");
    to_down_pass = 1'b1;
end

endmodule
