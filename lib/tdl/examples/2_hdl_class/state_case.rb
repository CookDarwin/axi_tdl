require_relative '../../tdl.rb'

TdlBuild.state_case_test( File.join(__dir__,"tmp") ) do 
    input.clock(100)    - 'clock'
    input.clock(100)    - 'clock1'
    input.reset('low')  - 'rst_n'
    input.reset('low')  - 'rst_n1'
    ##  定义logic
    logic[9,2,1] - 'tmp0'
    logic - 'tmp1'
    ## 定义 data_inf_c 
    data_inf_c(clock: "dclk",reset: "drstn",dsize:8,freqM: 101) - 'a_inf'
    data_inf_c(clock: "dclk",reset: "drstn",dsize:8,freqM: 101)[3,7,8] - 'c_inf'

    enum('IDLE','EXEC','DONE') - "ctrl_state"

    AlwaysComb do 
        CASE(ctrl_state.C) do 
            WHEN(ctrl_state.IDLE) do 
                ctrl_state.N <= ctrl_state.EXEC
            end 
            WHEN(ctrl_state.EXEC) do 
                IF 90 do 
                    ctrl_state.N <= ctrl_state.DONE
                end 
                ELSE do 
                    ctrl_state.N <= ctrl_state.EXEC
                end  
            end
            WHEN(ctrl_state.DONE) do 
                ctrl_state.N    <= ctrl_state.IDLE
            end
            DEFAULT do 
                ctrl_state.N    <= ctrl_state.IDLE
            end
        end
    end

    Always(posedge: clock,negedge: rst_n) do 
        IF ~rst_n do 
            a_inf.data  <= 0.A 
        end 
        ELSE do 
            CASE ctrl_state.N do 
                WHEN ctrl_state.IDLE do 
                    a_inf.data  <= 8.d9
                end 
                WHEN ctrl_state.EXEC do 
                    a_inf.data  <= 8.h12
                end 
                # WHEN ctrl_state.DONE do 
                #     a_inf.data  <= 8.b1110
                # end 
                ctrl_state.DONE do 
                    a_inf.data  <= 8.b1110
                end
                DEFAULT do 
                    a_inf.data  <= 1.A 
                end 
            end
        end
    end

    
end
