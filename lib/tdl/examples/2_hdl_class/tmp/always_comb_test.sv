/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.0
created: 2021-05-04 20:03:33 +0800
madified:
***********************************************/
`timescale 1ns/1ps

module always_comb_test ();
//==========================================================================
//-------- define ----------------------------------------------------------
logic [1-1:0]  tmp0[9-1:0][2-1:0] ;
logic tmp1;
data_inf_c #(.DSIZE(8),.FreqM(101)) a_inf (.clock(dclk),.rst_n(drstn)) ;
data_inf_c #(.DSIZE(18),.FreqM(101)) c_inf [2:0][6:0][7:0] (.clock(dclk),.rst_n(drstn)) ;
//==========================================================================
//-------- instance --------------------------------------------------------

//==========================================================================
//-------- expression ------------------------------------------------------
always_comb begin 
    tmp1 = a_inf.data[6-1];
    a_inf.valid = 1;
    if(0)begin
        tmp1 = 90;
        tmp1 = a_inf.data[6-1];
        a_inf.valid = 1;
        a_inf.data[6:3] = 12+(a_inf.data[6:0]+tmp1);
        a_inf.data[6:3] = 12+(tmp1+a_inf.data[6:0]);
        a_inf.data = 12+12;
        "90"+"0";
    end
    else if(1)begin
        c_inf[0][0][1].valid = 1;
        c_inf[0][0][1].data = 0;
        c_inf[0][0][1].data[0] = 3;
        c_inf[0][0][1].data[0] = 3<=7;
        c_inf.data[0][0][0] = 0;
    end
    else begin
        c_inf[0][0][1].valid = 1;
        c_inf[0][0][1].data = 0;
        c_inf[0][0][1].data[0] = 3;
        c_inf[0][0][1].data[0] = 3<=7;
        c_inf.data[0][0][0] = 0;
    end
end

always_comb begin 
    tmp1 = a_inf.data[6-1];
    a_inf.valid = 1;
    if(tmp1)begin
        tmp1 = 90;
        tmp1 = a_inf.data[6-1];
        a_inf.valid = 1;
        a_inf.data[6:3] = 12+(a_inf.data[6:0]+tmp1);
        a_inf.data[6:3] = 12+(tmp1+a_inf.data[6:0]);
        a_inf.data = 12+12;
        "90"+"0";
        if(9999)begin
            a_inf.valid = 1;
            a_inf.data[6:3] = 12+(a_inf.data[6:0]+tmp1);
            a_inf.data[6:3] = 12+(tmp1+a_inf.data[6:0]);
            a_inf.data = 12+12;
        end
    end
    else if(tmp1>1)begin
        c_inf[0][0][1].valid = 1;
        c_inf[0][0][1].data = 0;
        c_inf[0][0][1].data[0] = 3;
        c_inf[0][0][1].data[0] = 3<=7;
        c_inf.data[0][0][0] = 0;
    end
    else if(~tmp1)begin
        c_inf[0][0][1].valid = 1;
        c_inf[0][0][1].data = 0;
        c_inf[0][0][1].data[0] = 3;
        c_inf[0][0][1].data[0] = 3<=7;
        c_inf.data[0][0][0] = 0;
    end
    else if(tmp1>c_inf[0][0][1].data)begin
        c_inf[0][0][1].valid = 1;
        c_inf[0][0][1].data = 0;
        c_inf[0][0][1].data[0] = 3;
        c_inf[0][0][1].data[0] = 3<=7;
        c_inf.data[0][0][0] = 0;
    end
    else if(c_inf[0][0][1].data+tmp0[0][0][0])begin
        c_inf[0][0][1].valid = 1;
        c_inf[0][0][1].data = 0;
        c_inf[0][0][1].data[0] = 3;
        c_inf[0][0][1].data[0] = 3<=7;
        c_inf.data[0][0][0] = 0;
    end
    else begin
        c_inf[0][0][1].valid = 1;
        c_inf[0][0][1].data = 0;
        c_inf[0][0][1].data[0] = 3;
        c_inf[0][0][1].data[0] = 3<=7;
        c_inf.data[0][0][0] = 0;
    end
end

endmodule
