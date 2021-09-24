
`timescale 1ns/1ps
module exp_test_unit();
initial begin
    #(1us);
    $warning("Check TopModule.sim,please!!!");
    $stop;
end
endmodule
