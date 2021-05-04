/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.0
created: 2021-05-04 20:03:48 +0800
madified:
***********************************************/
`timescale 1ns/1ps

module tu0 (
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
    $root.tb_exp_test_unit.test_unit_region = "tu0";
    $display("--------------- Current test_unit <%0s> --------------------", "tu0");
    $root.tb_exp_test_unit.rtl_top.sub_md1_inst.enable = 1'b1;
    #(1us);
    $root.tb_exp_test_unit.rtl_top.sub_md1_inst.enable = 1'b0;
    #(500us);
    to_down_pass = 1'b1;
end

endmodule
