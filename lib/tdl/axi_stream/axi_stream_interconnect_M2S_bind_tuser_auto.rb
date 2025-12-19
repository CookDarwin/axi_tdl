
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def axi_stream_interconnect_m2s_bind_tuser(
        num:8,
        s00:"s00",
        m00:"m00",
        up_stream:nil,
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('axi_stream_interconnect_m2s_bind_tuser','../../axi/AXI_stream/axi_stream_interconnect_M2S_bind_tuser.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axi_stream_interconnect_m2s_bind_tuser','../../axi/AXI_stream/axi_stream_interconnect_M2S_bind_tuser.sv'])
        return_stream = self
        
        s00 = AxiStream.same_name_socket(:from_up,mix=false,s00,nil,belong_to_module) unless s00.is_a? String
        m00 = AxiStream.same_name_socket(:to_down,mix=true,m00,nil,belong_to_module) unless m00.is_a? String
        
        if up_stream.nil? && s00.eql?("s00") && (!(m00.eql?("m00")) || !down_stream.nil?)
            # up_stream = self.copy(name:"s00")
            # return_stream = up_stream
            m00 = down_stream if down_stream
            return down_stream.axi_stream_interconnect_m2s_bind_tuser(s00:self)
        end

        s00 = up_stream if up_stream
        unless self.eql? belong_to_module.AxiStream_NC
            m00 = self
        else
            if down_stream
                m00 = down_stream
            end
        end


        belong_to_module.AxiStream_draw << axi_stream_interconnect_m2s_bind_tuser_draw(
            num:num,
            s00:s00,
            m00:m00,
            up_stream:up_stream,
            down_stream:down_stream)
        return return_stream
    end

    private

    def axi_stream_interconnect_m2s_bind_tuser_draw(
        num:8,
        s00:"s00",
        m00:"m00",
        up_stream:nil,
        down_stream:nil
    )

        large_name_len(
            num,
            s00,
            m00
        )
        instance_name = "axi_stream_interconnect_M2S_bind_tuser_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/axi_stream_interconnect_M2S_bind_tuser.sv
axi_stream_interconnect_M2S_bind_tuser#(
    .NUM    (#{align_signal(num)})
) #{instance_name}(
/*  axi_stream_inf.slaver*/ .s00 (#{align_signal(s00,q_mark=false)}),
/*  axi_stream_inf.master*/ .m00 (#{align_signal(m00,q_mark=false)})
);
"
    end
    
    public

    def self.axi_stream_interconnect_m2s_bind_tuser(
        num:8,
        s00:"s00",
        m00:"m00",
        up_stream:nil,
        down_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [s00,m00].first.belong_to_module unless belong_to_module
        
        if down_stream.nil? && m00.eql?("m00")
            if up_stream.is_a? AxiStream
                down_stream = up_stream.copy
            else
                down_stream = s00.copy
            end
            return_stream = down_stream
        end

        
        if up_stream.nil? && s00.eql?("s00")
            if down_stream.is_a? AxiStream
                up_stream = down_stream.copy
            else
                up_stream = m00.copy
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? AxiStream
            down_stream.axi_stream_interconnect_m2s_bind_tuser(
                num:num,
                s00:s00,
                m00:m00,
                up_stream:up_stream,
                down_stream:down_stream)
        elsif m00.is_a? AxiStream
            m00.axi_stream_interconnect_m2s_bind_tuser(
                num:num,
                s00:s00,
                m00:m00,
                up_stream:up_stream,
                down_stream:down_stream)
        else
            belong_to_module.AxiStream_NC.axi_stream_interconnect_m2s_bind_tuser(
                num:num,
                s00:s00,
                m00:m00,
                up_stream:up_stream,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

