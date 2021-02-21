
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def _axi_stream_interconnect_s2m_auto(
        head_dummy:4,
        num:4,
        slaver:"slaver",
        sub_tx_inf:"sub_tx_inf",
        up_stream:nil
    )

        Tdl.add_to_all_file_paths('axi_stream_interconnect_s2m_auto','../../axi/AXI_stream/axi_stream_interconnect_S2M_auto.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axi_stream_interconnect_s2m_auto','../../axi/AXI_stream/axi_stream_interconnect_S2M_auto.sv'])
        return_stream = self
        
        slaver = AxiStream.same_name_socket(:from_up,mix=true,slaver,nil,belong_to_module) unless slaver.is_a? String
        sub_tx_inf = AxiStream.same_name_socket(:to_down,mix=false,sub_tx_inf,nil,belong_to_module) unless sub_tx_inf.is_a? String
        
        slaver = up_stream if up_stream
        


        belong_to_module.AxiStream_draw << _axi_stream_interconnect_s2m_auto_draw(
            head_dummy:head_dummy,
            num:num,
            slaver:slaver,
            sub_tx_inf:sub_tx_inf,
            up_stream:up_stream)
        return return_stream
    end

    private

    def _axi_stream_interconnect_s2m_auto_draw(
        head_dummy:4,
        num:4,
        slaver:"slaver",
        sub_tx_inf:"sub_tx_inf",
        up_stream:nil
    )

        large_name_len(
            head_dummy,
            num,
            slaver,
            sub_tx_inf
        )
        instance_name = "axi_stream_interconnect_S2M_auto_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/axi_stream_interconnect_S2M_auto.sv
axi_stream_interconnect_S2M_auto#(
    .HEAD_DUMMY    (#{align_signal(head_dummy)}),
    .NUM           (#{align_signal(num)})
) #{instance_name}(
/*  axi_stream_inf.slaver*/ .slaver     (#{align_signal(slaver,q_mark=false)}),
/*  axi_stream_inf.master*/ .sub_tx_inf (#{align_signal(sub_tx_inf,q_mark=false)})
);
"
    end
    
    public

    def self.axi_stream_interconnect_s2m_auto(
        head_dummy:4,
        num:4,
        slaver:"slaver",
        sub_tx_inf:"sub_tx_inf",
        up_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [slaver,sub_tx_inf].first.belong_to_module unless belong_to_module
        
        
        belong_to_module.AxiStream_NC._axi_stream_interconnect_s2m_auto(
            head_dummy:head_dummy,
            num:num,
            slaver:slaver,
            sub_tx_inf:sub_tx_inf,
            up_stream:up_stream)
        return return_stream
    end
        

end

