require_relative ".././axi4"
require_relative ".././axi_stream"
require_relative "./axi4_lib"

class Axi4

    def axi4_data_convert(up_stream:nil,down_stream:nil)
        if down_stream && !up_stream
            down_stream.axi4_data_convert(up_stream:self,down_stream:down_stream)
            return down_stream
        end

        down_stream = self

        up_stream,down_stream = Axi4::sync_mode(up_stream:up_stream,down_stream:down_stream)

        if up_stream.dsize == down_stream.dsize
            $_draw = lambda { axi4_direct_draw(up_stream:up_stream,down_stream:down_stream) }
        else
            $_draw = lambda { axi4_data_convert_draw(up_stream:up_stream,down_stream:down_stream) }
        end
        @correlation_proc +=$_draw.call
        return self
    end

    def axi4_data_convert_draw(up_stream:nil,down_stream:nil)
        large_name_len(up_stream,down_stream)
"\naxi4_data_convert axi4_data_convert_#{signal}_inst(
/* axi_inf.slaver */ .axi_in    (#{align_signal(up_stream)}),
/* axi_inf.master */ .axi_out   (#{align_signal(down_stream)})
);\n"
    end

    def self.axi4_data_convert(up_stream:nil,down_stream:nil,dsize:8,copy_inf:nil)
        if up_stream==nil && down_stream==nil
            new_up_stream = copy_inf.copy(dsize:dsize)
            new_down_stream = copy_inf.copy(dsize:dsize)
        elsif up_stream==nil
            new_up_stream = down_stream.copy(dsize:dsize)
            new_down_stream = down_stream
        elsif down_stream==nil
            new_up_stream = up_stream
            new_down_stream = up_stream.copy(dsize:dsize)
        end

        new_down_stream.axi4_data_convert(up_stream:new_up_stream,down_stream:new_down_stream)

        if up_stream==nil && down_stream==nil
            return [new_up_stream,new_down_stream]
        elsif up_stream==nil
            return new_up_stream
        elsif down_stream==nil
            return new_down_stream
        end

    end

end


class TdlTest

    def self.test_axi4_data_convert
        c0 = Clock.new(name:"clk",freqM:148.5)
        r0 = Reset.new(name:"rst_n",active:"low")
        a0 = Axi4.new(name:"UP",clock:c0,reset:r0,mode:Axi4::BOTH,dsize:32)
        a1 = Axi4.new(name:"DOWN",clock:c0,reset:r0,mode:Axi4::ONLY_WRITE)

        a1.axi4_data_convert(up_stream:a0)

        puts_sv Axi4.inst,Axi4.draw
    end

end
