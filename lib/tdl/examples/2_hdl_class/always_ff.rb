require_relative '../../tdl.rb'

# require_relative "./../../class_hdl/hdl_redefine_opertor.rb"

TdlBuild.always_ff_test(File.join(__dir__,"tmp")) do 
    input.clock     - 'clock'
    input.clock     - 'clock1'
    input.reset('low')  - 'rst_n'
    input.reset('low')  - 'rst_n1'
    ##  定义logic
    logic[9,2,1] - 'tmp0'
    logic - 'tmp1'
    ## 定义 data_inf_c 
    data_inf_c(clock: "dclk",reset: "drstn",dsize:8,freqM: 101) - 'a_inf'
    data_inf_c(clock: "dclk",reset: "drstn",dsize:8,freqM: 101)[3,7,8] - 'c_inf'

    Always(posedge: clock,negedge: rst_n) do 
    
        32*2-5-6

    end


    # Always(posedge: clock) do 
    #     tmp1 <= a_inf.data[6-1]
    #     a_inf.valid <= 1

    #     IF 0 do 
    #         tmp1 <= "YYYYYY"
    #         tmp1 <= a_inf.data[6-1]
    #         a_inf.valid <= 1
    #         a_inf.data[6..3] <= 12 + (a_inf.data[6,0]+tmp1)
    #         a_inf.data[6..3] <= 12 + (tmp1+a_inf.data[6,0])
    #         a_inf.data <= 12 + 12
    #         a = "90"+"0"
    #     end
    #     ELSIF 1111 do 
    #         c_inf[0][0][1].valid    <= 1
    #         c_inf[0][0][1].data     <= 0
    #         c_inf[0][0][1].data[0]  <= 3
    #         c_inf[0][0][1].data[0]  <= 3 <= 7
    #         c_inf.data[0][0][0] <= 0
    #         IF 100 do 
    #             c_inf[0][0][1].data     <= 0
    #         end
    #         ELSE do 
    #             c_inf[0][0][1].data     <= 1
    #         end
    #     end
    #     ELSE do 
    #         c_inf[0][0][1].valid    <= 1
    #         c_inf[0][0][1].data     <= 0
    #         c_inf[0][0][1].data[0]  <= 3
    #         c_inf[0][0][1].data[0]  <= 3 <= 7
    #         c_inf.data[0][0][0] <= 0
    #     end 
    # end

    # Always(posedge: [clock,clock1],negedge: [rst_n,rst_n1]) do 
    #     tmp1 <= a_inf.data[6-1]
    #     a_inf.valid <= 1

    #     IF ~rst_n do 
    #         tmp1 <= 90
    #         tmp1 <= a_inf.data[6-1]
    #         a_inf.valid <= 1
    #         a_inf.data[6..3] <= 12 + (a_inf.data[6,0]+tmp1)
    #         a_inf.data[6..3] <= 12 + (tmp1+a_inf.data[6,0])
    #         a_inf.data <= 12 + 12
    #         a = "90"+"0"
    #     end
    #     ELSIF 1 do 
    #         c_inf[0][0][1].valid    <= 1
    #         c_inf[0][0][1].data     <= 0
    #         c_inf[0][0][1].data[0]  <= 3
    #         c_inf[0][0][1].data[0]  <= 3 <= 7
    #         c_inf.data[0][0][0] <= 0
    #     end
    #     ELSE do 
    #         c_inf[0][0][1].valid    <= 1
    #         c_inf[0][0][1].data     <= 0
    #         c_inf[0][0][1].data[0]  <= 3
    #         c_inf[0][0][1].data[0]  <= 3 <= 7
    #         c_inf.data[0][0][0] <= 0
    #     end 
    # end

    # Always(posedge: clock,negedge: rst_n) do 
    #     tmp1 <= a_inf.data[6-1]
    #     a_inf.valid <= 1

    #     IF tmp1 do 
    #         tmp1 <= 90
    #         tmp1 <= a_inf.data[6-1]
    #         a_inf.valid <= 1
    #         a_inf.data[6..3] <= 12 + (a_inf.data[6,0]+tmp1)
    #         a_inf.data[6..3] <= 12 + (tmp1+a_inf.data[6,0])
    #         a_inf.data <= 12 + 12
    #         a = "90"+"0"
    #     end
    #     ELSIF tmp1 > 1 do 
    #         c_inf[0][0][1].valid    <= 1
    #         c_inf[0][0][1].data     <= 0
    #         c_inf[0][0][1].data[0]  <= 3
    #         c_inf[0][0][1].data[0]  <= 3 <= 7
    #         c_inf.data[0][0][0] <= 0
    #     end
    #     ELSIF ~tmp1 do 
    #         c_inf[0][0][1].valid    <= 1
    #         c_inf[0][0][1].data     <= 0
    #         c_inf[0][0][1].data[0]  <= 3
    #         c_inf[0][0][1].data[0]  <= 3 <= 7
    #         c_inf.data[0][0][0] <= 0
    #     end
    #     ELSIF tmp1 > c_inf[0][0][1].data do 
    #         c_inf[0][0][1].valid    <= 1
    #         c_inf[0][0][1].data     <= 0
    #         c_inf[0][0][1].data[0]  <= 3
    #         c_inf[0][0][1].data[0]  <= 3 <= 7
    #         c_inf.data[0][0][0] <= 0
    #     end
    #     ELSIF c_inf[0][0][1].data + tmp0[0][0][0] do 
    #         c_inf[0][0][1].valid    <= 1
    #         c_inf[0][0][1].data     <= 0
    #         c_inf[0][0][1].data[0]  <= 3
    #         c_inf[0][0][1].data[0]  <= 3 <= 7
    #         c_inf.data[0][0][0] <= 0
    #     end
    #     ELSE do 
    #         c_inf[0][0][1].valid    <= 1
    #         c_inf[0][0][1].data     <= 0
    #         c_inf[0][0][1].data[0]  <= 3
    #         c_inf[0][0][1].data[0]  <= 3 <= 7
    #         c_inf.data[0][0][0] <= 0
    #     end 
    # end

    # always_ff(posedge.clock,negedge.rst_n) do 
    #     c_inf.data[0][0][0] <= 0
    # end

end

