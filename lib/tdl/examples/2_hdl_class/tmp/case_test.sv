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

module case_test (
    input clock,
    input clock1,
    input rst_n,
    input rst_n1
);

//==========================================================================
//-------- define ----------------------------------------------------------
logic [1-1:0]  tmp0[9-1:0][2-1:0] ;
logic tmp1;
data_inf_c #(.DSIZE(8)) a_inf (.clock(dclk),.rst_n(drstn)) ;
data_inf_c #(.DSIZE(8)) c_inf [2:0][6:0][7:0] (.clock(dclk),.rst_n(drstn)) ;
//==========================================================================
//-------- instance --------------------------------------------------------

//==========================================================================
//-------- expression ------------------------------------------------------
always_ff@(posedge clock) begin 
    case(tmp0) 
        a_inf.data:begin 
            if(90)begin
                 tmp1 <= 0;
            end
            else begin
                 tmp1 <= 1;
            end
        end
        1,2:begin 
            if(90)begin
                 tmp1 <= 0;
            end
            else begin
                 tmp1 <= 1;
            end
        end
        c_inf[0][1][2].data,2:begin 
            if(c_inf[0][1][2].valid)begin
                 tmp1 <= 0;
            end
            else begin
                 tmp1 <= 1;
            end
        end
        default:begin 
            if(909)begin
                 tmp1 <= 0;
            end
            else begin
                 tmp1 <= 1;
            end
        end
    endcase
end

always_comb begin 
    case(tmp0) 
        a_inf.data:begin 
            if(90)begin
                 tmp1 = 0;
            end
            else begin
                 tmp1 = 1;
            end
        end
        1,2:begin 
            if(90)begin
                 tmp1 = 0;
            end
            else begin
                 tmp1 = 1;
            end
        end
        c_inf[0][1][2].data,2:begin 
            if(c_inf[0][1][2].valid)begin
                 tmp1 = 0;
            end
            else begin
                 tmp1 = 1;
            end
        end
        default:begin 
            if(909)begin
                 tmp1 = 0;
            end
            else begin
                 tmp1 = 1;
            end
        end
    endcase
end

endmodule
