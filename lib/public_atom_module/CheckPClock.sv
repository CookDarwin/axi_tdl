/**********************************************
______________                ______________
______________ \  /\  /|\  /| ______________
______________  \/  \/ | \/ | ______________
descript:
author : Young
Version:
creaded: xxxx.xx.xx
madified:
***********************************************/
`timescale 1ns/1ps
module CheckPClock (
    input               aclk,
    input               bclk,
    output logic        done,
    output logic        same
);


realtime     a2b;
realtime     b2a;


initial begin
    done = 0;
    same = 1;
    repeat(100)begin
        @(posedge aclk);
        @(posedge bclk);
    end
    @(posedge aclk);
    a2b = $realtime;
    @(posedge bclk);
    a2b = $realtime - a2b;

    @(posedge bclk);
    b2a = $realtime;
    @(posedge aclk);
    b2a = $realtime - b2a;
    @(posedge aclk);
    if(a2b < (b2a + 0.001) || a2b > (b2a - 0.001))
            same = 1;
    else    same = 0;

    repeat(10)begin
        @(posedge aclk);
        @(posedge bclk);
    end

    done = 1;
end

endmodule
