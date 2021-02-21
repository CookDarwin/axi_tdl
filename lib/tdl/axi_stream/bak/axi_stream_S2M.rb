# require_relative "./axi_stream_lib"
# require_relative ".././axi_stream"
require_relative ".././tdl"

class AxiStream

    def axi_stream_s2m(addr,*down_streams)
        $_draw = lambda { s2m_sub_inst(down_streams.length) + s2m_sub_direct(*down_streams)+ axi_stream_s2m_draw(addr,down_streams.length) }
        @correlation_proc += $_draw.call
        return self
    end

    def s2m_sub_inst(num=0)
        return '' if num == 0
"
axi_stream_inf #(.DSIZE(#{signal}.DSIZE))  sub_#{(signal)}[#{num}-1:0](.aclk(#{signal}.aclk),.aresetn(#{signal}.aresetn),.aclken(1'b1));\n
"
    end

    def s2m_sub_direct(*down_streams)
        str = ""
        for i in 0...(down_streams.length)
            str +=
"\naxis_direct  axis_direct_#{signal}_inst#{i} (
/*  axi_stream_inf.slaver*/ .slaver (sub_#{(signal)}[#{i}]),
/*  axi_stream_inf.master*/ .master (#{down_streams[i].signal})
);\n"
        end
        return str
    end

    def axi_stream_s2m_draw(addr,num=0)
"
axi_stream_interconnect_S2M  #(
    .NUM        (#{num})
)axi_stream_interconnect_S2M_#{signal}_inst(
/*  input [NSIZE-1:0]     */ addr   (#{align_signal(addr)}),
/*  axi_stream_inf.slaver */ s00    (#{signal}),
/*  axi_stream_inf.master */ m00    (sub_#{(signal)})//[NUM-1:0],
);
"
    end

end

class TdlTest

    def self.test_axi_streams_s2m
        c0 = Clock.new(name:"clk",freqM:148.5)
        r0 = Reset.new(name:"rst_n",active:"low")
        addr = Logic.new(name:'new_body_len')

        head_inf = AxiStream.new(name:"head_inf",clock:c0,reset:r0)
        body_inf = AxiStream.new(name:"body_inf",clock:c0,reset:r0)
        end_inf = AxiStream.new(name:"end_inf",clock:c0,reset:r0)

        m00 = AxiStream.new(name:"m00",clock:c0,reset:r0)
        m00.axi_stream_s2m(addr, head_inf,body_inf,end_inf)

        puts_sv Tdl.inst,Tdl.draw
    end

end
