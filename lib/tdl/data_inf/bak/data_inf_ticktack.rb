require_relative ".././data_inf"
require_relative ".././axi_stream"

class DataInf

    def data_inf_ticktack(sub_hbit:@dsize-1,sub_lbit:0,mode:"COMPARE:<",index_data:nil,compare_data:nil,up_stream:nil,down_stream:self,clock:nil,reset:nil)
        if down_stream && !up_stream
            down_stream.data_inf_planer(sub_hbit:sub_hbit,sub_lbit:sub_lbit,mode:mode,index_data:index_data,compare_data:compare_data,up_stream:self,down_stream:down_stream,clock:clock,reset:reset)
            return down_stream
        end

        down_stream = self

        if (reset.is_a? Reset) && (reset.active != 'low')
            reset_str = "~"+reset.signal
        else
            reset_str = reset;
        end

        $_draw = lambda { data_inf_ticktack_draw(sub_hbit:sub_hbit,sub_lbit:sub_lbit,mode:mode,index_data:index_data,compare_data:compare_data,up_stream:self,down_stream:down_stream,clock:clock,reset:reset_str) }
        @correlation_proc +=$_draw.call
        return self
    end


    def data_inf_ticktack_draw(sub_hbit:@dsize-1,sub_lbit:0,mode:"COMPARE:<",index_data:nil,compare_data:nil,up_stream:nil,down_stream:self,clock:nil,reset:nil)
        large_name_len(sub_hbit,sub_lbit,mode,index_data,compare_data,up_stream,down_stream,clock,reset)
"data_inf_ticktack #(
    .DSIZE      (#{signal}.DSIZE),
    .SUB_HBIT   (#{align_signal(sub_hbit)}),
    .SUB_LBIT   (#{align_signal(sub_lbit)}),
    .MODE       (#{align_signal(mode)}), //COMPARE:< COMPARE:> COMPARE:<= COMPARE:>= COMPARE:== COMPARE:!= ,INDEX
    .ISIZE      (#{align_signal(index_data.dsize)})        // ONLY INDEX MODE
)data_inf_ticktack_#{signal}_inst(
/*  input             */  .clock        (#{align_signal(clock)}),
/*  input             */  .rst_n        (#{align_signal(reset)}),
/*  input [DSIZE-1:0] */  .compare_data (#{align_signal(compare_data)}),
/*  input [ISIZE-1:0] */  .index_data   (#{align_signal(index_data)}),
/*  data_inf.slaver   */  .slaver       (#{align_signal(up_stream)}),
/*  data_inf.master   */  .master       (#{align_signal(down_stream)})
);"
    end
end

class DataInf_C

    def data_inf_ticktack(sub_hbit:@dsize-1,sub_lbit:0,mode:"COMPARE:<",index_data:nil,compare_data:nil,up_stream:nil,down_stream:self)
        if down_stream && !up_stream
            down_stream.data_inf_ticktack(sub_hbit:sub_hbit,sub_lbit:sub_lbit,mode:mode,index_data:index_data,compare_data:compare_data,up_stream:self,down_stream:down_stream)
            return down_stream
        end

        down_stream_nc = self.from_data_inf
        up_stream_nc = up_stream.to_data_inf

        down_stream_nc.data_inf_ticktack(sub_hbit:sub_hbit,sub_lbit:sub_lbit,mode:mode,index_data:index_data,compare_data:compare_data,up_stream:self,down_stream:down_stream,clock:@clock,reset:@reset)

        return up_stream
    end
end

class TdlTest

    def self.test_data_inf_ticktack
        c0 = Clock.new(name:"clk",freqM:148.5)
        r0 = Reset.new(name:"rst_n",active:"low")
        trigger = Logic.new(name:'trigger',dsize:9)
        d0 = DataInf_C.new(name:"D0",dsize:8,clock:c0,reset:r0)
        d1 = DataInf_C.new(name:"D1",dsize:8,clock:c0,reset:r0)
        # d0 = DataInf.new(name:"D0",dsize:8)
        # d1 = DataInf.new(name:"D1",dsize:8)
        d0.data_inf_ticktack(down_stream:d1,index_data:trigger,compare_data:trigger)
        # d0.data_inf_planer(up_stream:d1,pack_data:trigger,clock:c0,reset:r0)
        puts_sv DataInf.inst,DataInf_C.inst,DataInf.draw,DataInf_C.draw
    end
end

# unless ARGV.empty?
#     Test.test_data_inf_ticktack
# end
