require_relative ".././data_inf"
require_relative ".././axi_stream"

class DataInf_C
    attr_accessor :interconnect_mid
    def <<(*up_streams)
        up_streams.each do |e|

            if e.is_a? DataInf
                @interconnect_up_streams << e.to_data_inf_c()
            elsif e.is_a? DataInf_C
                @interconnect_up_streams << e
            elsif e.is_a? String
                @interconnect_up_streams << e
            else
                raise TdlError.new("\nDATA INF INTERCONNECT UP_STREAMS ERROR\n")
            end
        end
        unless @_execed_mix
            @@pre_inst << method(:sub_inst).to_proc
        end
        @_execed_mix = true
        return self
    end

    def sub_inst
        return '' if @interconnect_up_streams.empty?
        # "data_inf_c #(.DSIZE(#{dsize}))  sub_#{signal} [#{@interconnect_up_streams.length-1}:0](#{align_signal(clock)},#{align_signal(reset)});\n"+sub_direct
         @interconnect_sub_set = DataInf_C.same_name_socket(:from_up,mix=false,@interconnect_up_streams,self.copy(name:"sub_#{@name}"))
         return ""
    end



#     def interconnect_draw(prio:"OFF")
#         # sub_inst
#         num = @interconnect_up_streams.length
#         large_name_len(@interconnect_sub_set,self)
#         # p @interconnect_sub_set
#
# "data_inf_c_interconnect_M2S #(
#     .NUM    (#{align_signal(num)}),
#     .PRIO   (#{align_signal(prio)})
# )M2S_noaddr_#{signal}_inst(
# /*  data_inf_c.slaver */ .s00         (#{align_signal(@interconnect_sub_set)}),//[NUM-1:0],
# /*  data_inf_c.master */ .m00         (#{align_signal(self)})
# );"
#     end

    def interconnect_draw(prio:"ROBIN")
        # sub_inst
        num = @interconnect_up_streams.length
        large_name_len(@interconnect_sub_set,self)
        # p @interconnect_sub_set
"data_c_pipe_intc_M2S_verc #(
    .PRIO   (#{align_signal(prio)}),   //BEST_ROBIN BEST_LAST ROBIN LAST WAIT_IDLE
    .NUM    (#{align_signal(num)})
)M2S_noaddr_#{signal}_inst(
/*  input [NUM-1:0]    */     .last     ('1),             //ctrl prio
/*  data_inf_c.slaver  */     .s00      (#{align_signal(@interconnect_sub_set)}),//[NUM-1:0],
/*  data_inf_c.master  */     .m00      (#{align_signal(self)})
);
"
    end

end

class TdlTest

    def self.test_data_inf_interconnect
        c0 = Clock.new(name:"clk",freqM:148.5)
        r0 = Reset.new(name:"rst_n",active:"low")
        d0 = DataInf.new(name:"D0",dsize:8)
        d1 = DataInf_C.new(name:"D1",dsize:8,clock:c0,reset:r0)
        d2 = DataInf.new(name:"D2",dsize:8)


        d1.<< d0,d2

        puts_sv DataInf.inst,DataInf_C.inst,DataInf.draw,DataInf_C.draw
    end
end

# unless  ARGV.empty?
#     Test.test_data_inf_interconnect
# end
