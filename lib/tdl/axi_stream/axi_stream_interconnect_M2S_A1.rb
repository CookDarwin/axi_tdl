
#2018-01-18 10:41:44 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def axi_stream_interconnect_m2s_a1(
        num:nil,
        s00:"s00",
        m00:"m00",
        up_stream:nil,
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('axi_stream_interconnect_m2s_a1','../../axi/AXI_stream/axi_stream_interconnect_M2S_A1.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axi_stream_interconnect_m2s_a1','../../axi/AXI_stream/axi_stream_interconnect_M2S_A1.sv'])
        return_stream = self

        s00 = AxiStream.same_name_socket(:from_up,mix=false,s00,nil,belong_to_module) unless s00.is_a? String
        m00 = AxiStream.same_name_socket(:to_down,mix=true,m00,nil,belong_to_module) unless m00.is_a? String

        if up_stream.nil? && s00.eql?("s00")
            up_stream = self.copy(name:"s00")
            return_stream = up_stream
        end

        s00 = up_stream if up_stream
        m00 = self unless self==belong_to_module.AxiStream_NC

        num = dimension_num(s00)  unless num

        belong_to_module.AxiStream_draw << axi_stream_interconnect_m2s_a1_draw(
            num:num,
            s00:s00,
            m00:m00,
            up_stream:up_stream,
            down_stream:down_stream)
        return return_stream
    end

    private

    def axi_stream_interconnect_m2s_a1_draw(
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
        instance_name = "axi_stream_interconnect_M2S_A1_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/axi_stream_interconnect_M2S_A1.sv
axi_stream_interconnect_M2S_A1#(
    .NUM    (#{align_signal(num)})
) #{instance_name}(
/*  axi_stream_inf.slaver*/ .s00 (#{align_signal(s00,q_mark=false)}),
/*  axi_stream_inf.master*/ .m00 (#{align_signal(m00,q_mark=false)})
);
"
    end

    public

    def self.axi_stream_interconnect_m2s_a1(
        num:nil,
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
                down_stream = up_stream.copy(name:"m00")
            else
                down_stream = s00.copy(name:"m00")
            end
            return_stream = down_stream
        end


        if up_stream.nil? && s00.eql?("s00")
            if down_stream.is_a? AxiStream
                up_stream = down_stream.copy(name:"s00")
            else
                up_stream = m00.copy(name:"s00")
            end
            return_stream = up_stream
        end


        if down_stream.is_a? AxiStream
            down_stream.axi_stream_interconnect_m2s_a1(
                num:num,
                s00:s00,
                m00:m00,
                up_stream:up_stream,
                down_stream:down_stream)
        elsif m00.is_a? AxiStream
            m00.axi_stream_interconnect_m2s_a1(
                num:num,
                s00:s00,
                m00:m00,
                up_stream:up_stream,
                down_stream:down_stream)
        else
            belong_to_module.AxiStream_NC.axi_stream_interconnect_m2s_a1(
                num:num,
                s00:s00,
                m00:m00,
                up_stream:up_stream,
                down_stream:down_stream)
        end
        return return_stream
    end


end
