/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.0
created: 2021-05-04 20:03:32 +0800
madified:
***********************************************/
`timescale 1ns/1ps

module state_case_test (
    input clock,
    input clock1,
    input rst_n,
    input rst_n1
);

//==========================================================================
//-------- define ----------------------------------------------------------
logic [1-1:0]  tmp0[9-1:0][2-1:0] ;
logic tmp1;
data_inf_c #(.DSIZE(8),.FreqM(101)) a_inf (.clock(dclk),.rst_n(drstn)) ;
data_inf_c #(.DSIZE(8),.FreqM(101)) c_inf [2:0][6:0][7:0] (.clock(dclk),.rst_n(drstn)) ;
//==========================================================================
//-------- instance --------------------------------------------------------

//==========================================================================
//-------- expression ------------------------------------------------------
typedef enum { 
    IDLE,
    EXEC,
    DONE
} SE_STATE_ctrl_state;
SE_STATE_ctrl_state CSTATE_ctrl_state,NSTATE_ctrl_state;
always_comb begin 
    case(CSTATE_ctrl_state) 
        IDLE:begin 
            NSTATE_ctrl_state = EXEC;
        end
        EXEC:begin 
            if(90)begin
                NSTATE_ctrl_state = DONE;
            end
            else begin
                NSTATE_ctrl_state = EXEC;
            end
        end
        DONE:begin 
            NSTATE_ctrl_state = IDLE;
        end
        default:begin 
            NSTATE_ctrl_state = IDLE;
        end
    endcase
end

always@(posedge clock,negedge rst_n) begin 
    if(~rst_n)begin
        a_inf.data <= '0;
    end
    else begin
        case(NSTATE_ctrl_state) 
            IDLE:begin 
                a_inf.data <= 8'd9;
            end
            EXEC:begin 
                a_inf.data <= 8'h12;
            end
            default:begin 
                a_inf.data <= ~('0);
            end
        endcase
    end
end

endmodule
