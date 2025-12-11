require_relative '../../tdl.rb'
# require_relative "./../../class_hdl/hdl_redefine_opertor.rb"


TdlBuild.always_comb_test(File.join(__dir__,"tmp")) do 
    # puts method(:logic).source_location
    ##  定义logic
    logic[9,2,1] - 'tmp0'
    logic - 'tmp1'
    ## 定义 data_inf_c 
    data_inf_c(clock: "dclk",reset: "drstn",dsize:8,freqM: 101) - 'a_inf'
    data_inf_c(clock: "dclk",reset: "drstn",dsize:18,freqM: 101)[3,7,8] - 'c_inf'

    AlwaysComb do 
        tmp1 <= a_inf.data[6-1]
        a_inf.valid <= 1

        IF 0 do 
            tmp1 <= 90
            tmp1 <= a_inf.data[6-1]
            a_inf.valid <= 1
            a_inf.data[6..3] <= 12 + (a_inf.data[6,0]+tmp1)
            a_inf.data[6..3] <= 12 + (tmp1+a_inf.data[6,0])
            a_inf.data <= 12 + 12
            a = "90"+"0"
        end
        ELSIF 1 do 
            c_inf[0][0][1].valid    <= 1
            c_inf[0][0][1].data     <= 0
            c_inf[0][0][1].data[0]  <= 3
            c_inf[0][0][1].data[0]  <= 3 <= 7
            c_inf.data[0][0][0] <= 0
        end
        ELSE do 
            c_inf[0][0][1].valid    <= 1
            c_inf[0][0][1].data     <= 0
            c_inf[0][0][1].data[0]  <= 3
            c_inf[0][0][1].data[0]  <= 3 <= 7
            c_inf.data[0][0][0] <= 0
        end 
    end

    AlwaysComb do 
        tmp1 <= a_inf.data[6-1]
        a_inf.valid <= 1

        IF tmp1 do 
            tmp1 <= 90
            tmp1 <= a_inf.data[6-1]
            a_inf.valid <= 1
            a_inf.data[6..3] <= 12 + (a_inf.data[6,0]+tmp1)
            a_inf.data[6..3] <= 12 + (tmp1+a_inf.data[6,0])
            a_inf.data <= 12 + 12
            a = "90"+"0"
            IF 9999 do 
                a_inf.valid <= 1
                a_inf.data[6..3] <= 12 + (a_inf.data[6,0]+tmp1)
                a_inf.data[6..3] <= 12 + (tmp1+a_inf.data[6,0])
                a_inf.data <= 12 + 12
            end
        end
        ELSIF tmp1 > 1 do 
            c_inf[0][0][1].valid    <= 1
            c_inf[0][0][1].data     <= 0
            c_inf[0][0][1].data[0]  <= 3
            c_inf[0][0][1].data[0]  <= 3 <= 7
            c_inf.data[0][0][0] <= 0
        end
        ELSIF ~tmp1 do 
            c_inf[0][0][1].valid    <= 1
            c_inf[0][0][1].data     <= 0
            c_inf[0][0][1].data[0]  <= 3
            c_inf[0][0][1].data[0]  <= 3 <= 7
            c_inf.data[0][0][0] <= 0
        end
        ELSIF tmp1 > c_inf[0][0][1].data do 
            c_inf[0][0][1].valid    <= 1
            c_inf[0][0][1].data     <= 0
            c_inf[0][0][1].data[0]  <= 3
            c_inf[0][0][1].data[0]  <= 3 <= 7
            c_inf.data[0][0][0] <= 0
        end
        ELSIF c_inf[0][0][1].data + tmp0[0][0][0] do 
            c_inf[0][0][1].valid    <= 1
            c_inf[0][0][1].data     <= 0
            c_inf[0][0][1].data[0]  <= 3
            c_inf[0][0][1].data[0]  <= 3 <= 7
            c_inf.data[0][0][0] <= 0
        end
        ELSE do 
            c_inf[0][0][1].valid    <= 1
            c_inf[0][0][1].data     <= 0
            c_inf[0][0][1].data[0]  <= 3
            c_inf[0][0][1].data[0]  <= 3 <= 7
            c_inf.data[0][0][0] <= 0
        end 
    end
end

