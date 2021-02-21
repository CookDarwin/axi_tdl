require_relative ".././data_inf"
require_relative ".././axi_stream"

class DataInf_C

    def data_inf_cross_clk(up_stream:nil,down_stream:nil)
        if down_stream && !up_stream
            down_stream.data_inf_cross_clk(up_stream:self,down_stream:down_stream)
            return down_stream
        end

        down_stream = self
        $_draw = lambda { data_inf_cross_clk_draw(up_stream:up_stream,down_stream:down_stream) }
        @correlation_proc +=$_draw.call
        return self
    end

    def data_inf_cross_clk_draw(up_stream:nil,down_stream:nil)
        large_name_len(up_stream,down_stream)
"data_inf_cross_clk data_inf_cross_clk_#{signal}_inst(
/*  data_inf_c.slaver */   .slaver  (#{align_signal(up_stream)}),
/*  data_inf_c.master */   .master  (#{align_signal(down_stream)})
);"
    end

end

class DataInf

    def data_inf_cross_clk(clock:nil,reset:nil,up_stream:nil,down_stream:nil)
        if down_stream && !up_stream
            down_stream.data_inf_cross_clk(up_stream:self,down_stream:down_stream,clock:clock,reset:reset)
            return down_stream
        end

        down_stream = self

        down_stream.from_data_inf_c(clock:clock,reset:reset).data_inf_cross_clk(up_stream:up_stream.to_data_inf_c(clock:clock,reset:reset))

        return up_stream

    end

end

class TdlTest

    def self.test_data_inf_cross_clk
        c0 = Clock.new(name:"clk",freqM:148.5)
        r0 = Reset.new(name:"rst_n",active:"low")
        d0 = DataInf.new(name:"D0",dsize:8)
        d1 = DataInf.new(name:"D1",dsize:8)
        d0.data_inf_cross_clk(up_stream:d1,clock:c0,reset:r0)
        puts_sv DataInf.inst,DataInf_C.inst,DataInf.draw,DataInf_C.draw
    end
end

# unless  ARGV.empty?
#     Test.test_data_inf_cross_clk
# end
