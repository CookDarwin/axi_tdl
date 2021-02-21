
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def _axi_stream_interconnect_m2s(
        num:8,
        nsize:"NUM <= 2? 1 :",
        addr:"addr",
        s00:"s00",
        m00:"m00"
    )

        Tdl.add_to_all_file_paths('axi_stream_interconnect_m2s','../../axi/AXI_stream/axi_stream_interconnect_M2S.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axi_stream_interconnect_m2s','../../axi/AXI_stream/axi_stream_interconnect_M2S.sv'])
        return_stream = self
        
        s00 = AxiStream.same_name_socket(:from_up,mix=false,s00,nil,belong_to_module) unless s00.is_a? String
        m00 = AxiStream.same_name_socket(:to_down,mix=true,m00,nil,belong_to_module) unless m00.is_a? String
        
        
        


        belong_to_module.AxiStream_draw << _axi_stream_interconnect_m2s_draw(
            num:num,
            nsize:nsize,
            addr:addr,
            s00:s00,
            m00:m00)
        return return_stream
    end

    private

    def _axi_stream_interconnect_m2s_draw(
        num:8,
        nsize:"NUM <= 2? 1 :",
        addr:"addr",
        s00:"s00",
        m00:"m00"
    )

        large_name_len(
            num,
            nsize,
            addr,
            s00,
            m00
        )
        instance_name = "axi_stream_interconnect_M2S_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/axi_stream_interconnect_M2S.sv
axi_stream_interconnect_M2S#(
    .NUM      (#{align_signal(num)}),
    .NSIZE    (#{align_signal(nsize)})
) #{instance_name}(
/*  input  [NSIZE-1:0]   */ .addr (#{align_signal(addr,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .s00  (#{align_signal(s00,q_mark=false)}),
/*  axi_stream_inf.master*/ .m00  (#{align_signal(m00,q_mark=false)})
);
"
    end
    
    public

    def self.axi_stream_interconnect_m2s(
        num:8,
        nsize:"NUM <= 2? 1 :",
        addr:"addr",
        s00:"s00",
        m00:"m00",
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [s00,m00].first.belong_to_module unless belong_to_module
        
        
        belong_to_module.AxiStream_NC._axi_stream_interconnect_m2s(
            num:num,
            nsize:nsize,
            addr:addr,
            s00:s00,
            m00:m00)
        return return_stream
    end
        

end

