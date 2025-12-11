require_relative ".././data_inf"
require_relative ".././axi_stream"

class DataInf


    def data_inf_planer(latency:3,clock:nil,reset:nil,pack_data:nil,up_stream:nil,down_stream:nil)
        if down_stream && !up_stream
            down_stream.data_inf_planer(latency:latency,clock:clock,reset:reset,pack_data:pack_data,up_stream:self,down_stream:down_stream)
            return down_stream
        end

        down_stream = self

        if (reset.is_a? Reset) && (reset.active != 'low')
            reset_str = "~"+reset.signal
        else
            reset_str = reset;
        end

        $_draw = lambda { data_inf_planer_draw(latency:latency,clock:clock,reset:reset_str,pack_data:pack_data,up_stream:up_stream,down_stream:down_stream) }
        @correlation_proc +=$_draw.call
        return self
    end


    def data_inf_planer_draw(latency:3,clock:nil,reset:nil,pack_data:nil,up_stream:nil,down_stream:self)
        large_name_len(latency,"#{signal}.DSIZE",up_stream,down_stream)
"data_inf_planer #(
    .LAT        (#{align_signal(latency)}),
    .DSIZE      (#{align_signal("#{signal}.DSIZE",false)})
)data_inf_planer_#{signal}_inst(
/*  input            */   .clock        (#{align_signal(clock)}),
/*  input            */   .rst_n        (#{align_signal(reset)}),
/*  input [DSIZE-1:0]*/   .pack_data    (#{align_signal(pack_data)}),
/*  data_inf.slaver  */   .slaver       (#{align_signal(up_stream)}),
/*  data_inf.master  */   .master       (#{align_signal(down_stream)})            //{pack_data,slaver.data}
);"
    end

end

class DataInf_C

    def data_inf_planer(latency:3,pack_data:nil,up_stream:nil,down_stream:nil)
        if down_stream && !up_stream
            down_stream.data_inf_planer(latency:latency,pack_data:pack_data,up_stream:self,down_stream:down_stream)
            return down_stream
        end

        down_stream_nc = self.from_data_inf
        up_stream_nc = up_stream.to_data_inf

        down_stream_nc.data_inf_planer(latency:latency,clock:@clock,reset:@reset,pack_data:pack_data,up_stream:up_stream_nc,down_stream:down_stream_nc)

        return up_stream
    end
end

class TdlTest

    def self.test_data_inf_planer
        c0 = Clock.new(name:"clk",freqM:148.5)
        r0 = Reset.new(name:"rst_n",active:"low")
        trigger = Logic.new(name:'trigger',dsize:9)
        d0 = DataInf_C.new(name:"D0",dsize:8,clock:c0,reset:r0)
        d1 = DataInf_C.new(name:"D1",dsize:8,clock:c0,reset:r0)
        # d0 = DataInf.new(name:"D0",dsize:8)
        # d1 = DataInf.new(name:"D1",dsize:8)
        d0.data_inf_planer(up_stream:d1,pack_data:trigger)
        # d0.data_inf_planer(up_stream:d1,pack_data:trigger,clock:c0,reset:r0)
        puts_sv DataInf.inst,DataInf_C.inst,DataInf.draw,DataInf_C.draw
    end
end

# unless ARGV.empty?
#     Test.test_data_inf_planer
# end
