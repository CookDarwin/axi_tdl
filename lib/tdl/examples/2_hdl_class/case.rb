require_relative '../../tdl.rb'

TdlBuild.case_test( File.join(__dir__,"tmp")) do 
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


    Always(posedge: clock) do 
        CASE(tmp0) do 
            WHEN(a_inf.data) do 
                IF 90 do 
                    tmp1 <= 0
                end 
                ELSE do 
                    tmp1 <= 1
                end  
            end 
            WHEN(1,2) do 
                IF 90 do 
                    tmp1 <= 0
                end 
                ELSE do 
                    tmp1 <= 1
                end  
            end
            WHEN(c_inf[0][1][2].data,2) do 
                IF c_inf[0][1][2].valid do 
                    tmp1 <= 0
                end 
                ELSE do 
                    tmp1 <= 1
                end  
            end
            DEFAULT do 
                IF 909 do 
                    tmp1 <= 0
                end 
                ELSE do 
                    tmp1 <= 1
                end  
            end
        end
    end


    AlwaysComb do 
        CASE(tmp0) do 
            WHEN(a_inf.data) do 
                IF 90 do 
                    tmp1 <= 0
                end 
                ELSE do 
                    tmp1 <= 1
                end  
            end 
            WHEN(1,2) do 
                IF 90 do 
                    tmp1 <= 0
                end 
                ELSE do 
                    tmp1 <= 1
                end  
            end
            WHEN(c_inf[0][1][2].data,2) do 
                IF c_inf[0][1][2].valid do 
                    tmp1 <= 0
                end 
                ELSE do 
                    tmp1 <= 1
                end  
            end
            DEFAULT do 
                IF 909 do 
                    tmp1 <= 0
                end 
                ELSE do 
                    tmp1 <= 1
                end  
            end
        end
    end

    
end

