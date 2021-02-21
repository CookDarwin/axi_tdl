# require_relative ".././axi4"
# require_relative ".././axi_stream"

class Axi4

    def axi4_direct(up_stream:nil,down_stream:nil)
        if down_stream && !up_stream
            down_stream.axi4_direct(up_stream:self,down_stream:down_stream)
            return down_stream
        end

        down_stream = self

        # $_draw = lambda { axi4_direct_draw(up_stream:up_stream,down_stream:down_stream) }
        # @correlation_proc +=$_draw.call

        belong_to_module.Axi4_draw << axi4_direct_draw(up_stream:up_stream,down_stream:down_stream)
        return self
    end

    def axi4_direct_draw(up_stream:nil,down_stream:self)
        dmode = up_stream.mode+"_to_"+down_stream.mode
        large_name_len(dmode,up_stream,down_stream)
"\naxi4_direct #(
    .MODE       (#{align_signal(dmode)})    //ONLY_READ to BOTH,ONLY_WRITE to BOTH,BOTH to BOTH,BOTH to ONLY_READ,BOTH to ONLY_WRITE
)axi4_direct_#{signal}_inst(
/* axi_inf.slaver */  .slaver   (#{align_signal(up_stream)}),
/* axi_inf.master */  .master   (#{align_signal(down_stream)})
);\n"
    end
end


# unless ARGV.empty?
#     Test.test_axi4_direct
# end
