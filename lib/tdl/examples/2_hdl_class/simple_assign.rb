require_relative '../../tdl.rb'

TdlBuild.simple_assign_test(File.join(__dir__,"tmp")) do 
    ##  定义logic
    logic[9,2,1] - 'tmp0'
    logic - 'tmp1'
    ## 定义 data_inf_c 
    data_inf_c(clock: "dclk",reset: "drstn",dsize:8,freqM: 101) - 'a_inf'
    data_inf_c(clock: "dclk",reset: "drstn",dsize:8,freqM: 101)[3,7,8] - 'c_inf'

    Assign do 
        # puts tmp0[0].method("==").source_location
        # puts (tmp0[0]==0).method("|").source_location
        # puts (tmp1 <= (tmp0[0]==0) | (tmp0[1]==2 )).tree
        # tmp1 <= ~(tmp0[0] == tmp0[1])
        tmp1 <= (tmp0[0] & "FALSE").and( (c_inf.data==3).or(a_inf.valid | 1.b0) )
        # 32*3
        # tmp1 <= 90
        # tmp1 <= "opopopopop"

        # tmp1 <= a_inf.data[6-1]
        # a_inf.valid <= 1
        # a_inf.data[6..3] <= 12 + (a_inf.data[6,0]+tmp1)
        # a_inf.data[6..3] <= 12 + (tmp1+a_inf.data[6,0])
        # a_inf.data <= 12 + 12
        # tmp0[0][1][0] <= 0
        # tmp0[0][1][2,0] <= 0

        # c_inf[0][0][1].valid    <= 1
        # c_inf[0][0][1].data     <= 0
        # c_inf[0][0][1].data[0]  <= 3
        # c_inf[0][0][1].data[0]  <= 3 <= 7
        # c_inf.data[0][0][0] <= 0
 
    end

    # puts a_inf.data[6-1,0]
end

