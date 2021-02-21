require_relative ".././axi4"
require_relative ".././axi_stream"
require_relative "./axi4_lib"

class Axi4

    def axi4_partition_od(up_stream:nil,down_stream:nil,addr_step:"1.0")

        if down_stream && !up_stream
            down_stream.axi4_partition_od(up_stream:self,down_stream:down_stream,addr_step:addr_step)
            return down_stream
        end

        down_stream = self

        up_stream,down_stream = Axi4::sync_mode(up_stream:up_stream,down_stream:down_stream)

        # if(up_stream.dsize != down_stream.dsize)
        #     cv_down_stream = Axi4::axi4_data_convert(up_stream:up_stream,dsize:down_stream.dsize)
        # else
        #     cv_down_stream = up_stream
        # end
        cv_down_stream = up_stream
        $_draw = lambda { axi4_partition_od_draw(up_stream:cv_down_stream,down_stream:down_stream,addr_step:addr_step) }
        @correlation_proc +=$_draw.call
        return self
    end

    def axi4_partition_od_draw(up_stream:nil,down_stream:self,addr_step:"1.0")
        large_name_len(up_stream,down_stream)
"\naxi4_partition_OD #(
    .PSIZE          (#{down_stream.max_len}),
    .ADDR_STEP      (#{addr_step})
)axi4_partition_OD_#{signal}_inst(
/*  axi_inf.slaver */   .slaver     (#{align_signal(up_stream)}),
/*  axi_inf.master */   .master     (#{align_signal(down_stream)})
);\n"
    end

    def self.axi4_partition_od(up_stream:nil,down_stream:nil,addr_step:"1.0",copy_inf:nil,max_len:copy_inf.max_len)
        if up_stream==nil && down_stream==nil
            new_up_stream = copy_inf.copy(max_len:max_len)
            new_down_stream = copy_inf.copy(max_len:max_len)
        elsif up_stream==nil
            new_up_stream = down_stream.copy(max_len:max_len)
            new_down_stream = down_stream
        elsif down_stream==nil
            new_up_stream = up_stream
            new_down_stream = up_stream.copy(max_len:max_len)
        end


        new_down_stream.axi4_partition_od(up_stream:new_up_stream,down_stream:new_down_stream,addr_step:addr_step)

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

    def self.test_axi4_partition_od
        c0 = Clock.new(name:"pix",freqM:148.5)
        r0 = Reset.new(name:"pix",active:"low")
        a0 = Axi4.new(name:"UP",clock:c0,reset:r0,mode:Axi4::BOTH,dsize:32)
        a1 = Axi4.new(name:"DOWN",clock:c0,reset:r0,mode:Axi4::ONLY_WRITE)

        a1.axi4_partition_od(up_stream:a0)

        puts_sv Axi4.inst,Axi4.draw
    end

end

# unless ARGV.empty?
#     Test.test_axi4_partition_od
# end
