
`timescale 1ns/1ps
module test_tttop();
initial begin
    #(1us);
    $warning("Check TopModule.sim,please!!!");
    $stop;
end
endmodule
