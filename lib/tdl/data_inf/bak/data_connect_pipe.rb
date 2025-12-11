# require_relative ".././tdlerror"
# require_relative ".././clock"
# require_relative ".././Reset"
# require_relative ".././logic"
# require_relative ".././basefunc"
require_relative ".././data_inf"
require_relative ".././axi_stream"

class DataInf_C

    def data_connect_pipe(up_stream:nil,down_stream:nil)
        if down_stream && !up_stream
            down_stream.data_connect_pipe(up_stream:self,down_stream:down_stream)
            return down_stream
        end

        if (@reset.is_a? Reset) && (@reset.active != 'low')
            reset_str = "~"+reset.signal
        else
            reset_str = @reset;
        end

        $_draw = lambda { data_connect_pipe_draw(clock:@clock,reset:reset_str,up_stream:up_stream,down_stream:self) }
        @correlation_proc +=$_draw.call
        return self
    end

    def data_connect_pipe_draw(clock:nil,reset:nil,up_stream:nil,down_stream:nil)
        large_name_len(clock,reset,up_stream,down_stream,up_stream.signal+'"valid"')
"data_connect_pipe #(
    .DSIZE      (#{align_signal("#{signal}.DSIZE",false)})
)data_connect_pipe_#{signal}inst(
/*  input             */  .clock            (#{align_signal(clock)}),
/*  input             */  .rst_n            (#{align_signal(reset)}),
/*  input             */  .clk_en           (#{align_signal("1'b1")}),
/*  input             */  .from_up_vld      (#{align_signal("#{up_stream.signal}.valid",false)}),
/*  input [DSIZE-1:0] */  .from_up_data     (#{align_signal("#{up_stream.signal}.data",false)}),
/*  output            */  .to_up_ready      (#{align_signal("#{up_stream.signal}.ready",false)}),
/*  input             */  .from_down_ready  (#{align_signal("#{down_stream.signal}.ready",false)}),
/*  output            */  .to_down_vld      (#{align_signal("#{down_stream.signal}.valid",false)}),
/*  output[DSIZE-1:0] */  .to_down_data     (#{align_signal("#{down_stream.signal}.data",false)})
);"
    end

end

class DataInf

    def data_connect_pipe(clock:nil,reset:nil,up_stream:nil,down_stream:nil)
        if down_stream && !up_stream
            down_stream.data_connect_pipe(clock:clock,reset:reset,up_stream:self,down_stream:nil)
            return down_stream
        end

        down_stream = self

        if up_stream.is_a? DataInf
            up_stream_c = up_stream.to_data_inf_c(clock:clock,reset:reset)
        else
            up_stream_c = up_stream
        end
        down_stream_c = self.from_data_inf_c(clock:clock,reset:reset)
        down_stream_c.data_connect_pipe(up_stream:up_stream_c)
        return up_stream
    end
end

class TdlTest

    def self.test_data_connect_pipe
        c0 = Clock.new(name:"clk",freqM:148.5)
        r0 = Reset.new(name:"rst_n",active:"low")
        d0 = DataInf.new(name:"D0",dsize:8)
        d1 = DataInf.new(name:"D1",dsize:8)
        d0.data_connect_pipe(up_stream:d1,clock:c0,reset:r0)
        puts_sv DataInf.inst,DataInf_C.inst,DataInf.draw,DataInf_C.draw
    end
end

# Test.test_data_connect_pipe
