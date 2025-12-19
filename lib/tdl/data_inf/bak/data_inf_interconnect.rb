require_relative ".././data_inf"
require_relative ".././axi_stream"

class DataInf
    attr_accessor :interconnect_mid
    def <<(*up_streams)
        unless @interconnect_up_streams.empty?
            suit_type  = @interconnect_up_streams.first
        else
            suit_type   = up_streams.reject { |e| (e.is_a? Clock) || (e.is_a? Reset) || (e.is_a? DataInf_C)}.first
            suit_type   = self unless suit_type
        end

        up_streams.each do |e|
            if (e.is_a? DataInf) || (e.is_a? DataInf_C)
                if (suit_type.is_a? DataInf)
                    if e.is_a? DataInf_C
                        @interconnect_up_streams << e.to_data_inf()
                    else
                        @interconnect_up_streams << e
                    end
                else
                    raise TdlError.new("DATA INF INTERCONNECT UP_STREAMS ERROR")
                end
            elsif e.is_a? Hash
                if suit_type.is_a? Hash
                    if e[:inf].is_a? DataInf_C
                        @interconnect_up_streams << {:inf=>e[:inf].to_data_inf(),:id=>e[:id]}
                    else
                        @interconnect_up_streams << e
                    end
                    @interconnect_idsize  = e[:id].dsize if e[:id].dsize > @interconnect_idsize
                else
                    raise TdlError.new("DATA INF INTERCONNECT UP_STREAMS ERROR")
                end
            elsif e.is_a? Clock
                @interconnect_clock = e
            elsif e.is_a? Reset
                if e.active != 'low'
                    @interconnect_reset = "~"+e.signal
                else
                    @interconnect_reset = e
                end
            else
                raise TdlError.new("DATA INF INTERCONNECT UP_STREAMS ERROR")
            end
        end
    end

    def sub_inst
        return '' if @interconnect_up_streams.empty?
        if @interconnect_up_streams.first.is_a? Hash
            id_str = "logic [#{signal}.DSIZE-1:0]   #{signal}_sid   [#{@interconnect_up_streams.length-1}:0];\n"
        else
            id_str = ""
        end
        id_str+"data_inf #(.DSIZE(#{dsize}))  sub_#{signal} [#{@interconnect_up_streams.length-1}:0]();\n"+sub_direct
    end


    def sub_direct
        str = ""
        for i in 0...(@interconnect_up_streams.length)
            if @interconnect_up_streams[i].is_a? DataInf
                up_stream   = @interconnect_up_streams[i]
            else
                up_stream   = @interconnect_up_streams[i][:inf]
                sid = @interconnect_up_streams[i][:id]
            end
            str +=
"
#{sid ? "assign #{signal}_sid[#{i}]  = #{sid.signal};" : ""}
assign sub_#{signal}[#{i}].valid        = #{up_stream.signal}.valid;
assign sub_#{signal}[#{i}].data         = #{up_stream.signal}.data;
assign #{up_stream.signal}.ready     = sub_#{signal}[#{i}].ready;
"
        end
        return str
    end

    def a_interconnect_draw(prio:"OFF")
        clock = @interconnect_clock
        reset = @interconnect_reset
        num = @interconnect_up_streams.length
        large_name_len(num,prio,clock,reset,"sub_#{signal}")
        sub_inst +
"data_inf_interconnect_M2S_noaddr #(
    .NUM    (#{align_signal(num)}),
    .PRIO   (#{align_signal(prio)})
)data_inf_interconnect_M2S_noaddr_#{signal}_inst(
/*  input           */ .clock       (#{align_signal(clock)}),
/*  input           */ .rst_n       (#{align_signal(reset)}),
/*  data_inf.slaver */ .s00         (#{align_signal("sub_#{signal}",false)}),//[NUM-1:0],
/*  data_inf.master */ .m00         (#{align_signal(self)})
);"
    end

def b_interconnect_draw(prio:"OFF")
        idsize= @interconnect_idsize
        clock = @interconnect_clock
        reset = @interconnect_reset
        num = @interconnect_up_streams.length
        large_name_len(num,prio,clock,reset,"sub_#{signal}",@interconnect_mid)
        sub_inst +
"data_inf_interconnect_M2S_with_id_noaddr #(
    .NUM    (#{align_signal(num)}),
    .IDSIZE (#{align_signal(idsize)}),
    .PRIO   (#{align_signal(prio)})
)data_inf_interconnect_M2S_with_id_noaddr_#{signal}_inst(
/*  input              */ .clock       (#{align_signal(clock)}),
/*  input              */ .rst_n       (#{align_signal(reset)}),
/*  input [IDSIZE-1:0] */ .sid         (#{align_signal("#{signal}_sid",false)})//[NUM-1:0],
/*  output[IDSIZE-1:0] */ .mid         (#{align_signal(@interconnect_mid)})//,
/*  data_inf.slaver    */ .s00         (#{align_signal("sub_#{signal}",false)}),//[NUM-1:0],
/*  data_inf.master    */ .m00         (#{align_signal(self)})
);"
    end

end

class TdlTest

    def self.test_data_inf_interconnect
        c0 = Clock.new(name:"clk",freqM:148.5)
        r0 = Reset.new(name:"rst_n",active:"low")
        d0 = DataInf.new(name:"D0",dsize:8)
        d1 = DataInf_C.new(name:"D1",dsize:8,clock:c0,reset:r0)
        d2 = DataInf.new(name:"D2",dsize:8)

        trigger = Logic.new(name:'trigger',dsize:9)
        gen_en = Logic.new(name:'gen_en',dsize:4)
        length = Logic.new(name:'length')

        d0.<< Hash[:inf => d1,:id => trigger]
        d0.<< Hash[inf:d2,id:length]
        d0.<< c0,r0

        puts_sv DataInf.inst,DataInf_C.inst,DataInf.draw,DataInf_C.draw
    end
end

# unless  ARGV.empty?
#     Test.test_data_inf_interconnect
# end
