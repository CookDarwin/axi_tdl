
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def axi_stream_packet_fifo_with_info(
        depth:2,
        esize:8,
        info_in:"info_in",
        info_out:"info_out",
        axis_in:"axis_in",
        axis_out:"axis_out",
        up_stream:nil,
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('axi_stream_packet_fifo_with_info','../../axi/AXI_stream/packet_fifo/axi_stream_packet_fifo_with_info.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axi_stream_packet_fifo_with_info','../../axi/AXI_stream/packet_fifo/axi_stream_packet_fifo_with_info.sv'])
        return_stream = self
        
        axis_in = AxiStream.same_name_socket(:from_up,mix=true,axis_in,nil,belong_to_module) unless axis_in.is_a? String
        axis_out = AxiStream.same_name_socket(:to_down,mix=true,axis_out,nil,belong_to_module) unless axis_out.is_a? String
        
        if up_stream.nil? && axis_in.eql?("axis_in") && (!(axis_out.eql?("axis_out")) || !down_stream.nil?)
            # up_stream = self.copy(name:"axis_in")
            # return_stream = up_stream
            axis_out = down_stream if down_stream
            return down_stream.axi_stream_packet_fifo_with_info(axis_in:self)
        end

        axis_in = up_stream if up_stream
        unless self.eql? belong_to_module.AxiStream_NC
            axis_out = self
        else
            if down_stream
                axis_out = down_stream
            end
        end


        belong_to_module.AxiStream_draw << axi_stream_packet_fifo_with_info_draw(
            depth:depth,
            esize:esize,
            info_in:info_in,
            info_out:info_out,
            axis_in:axis_in,
            axis_out:axis_out,
            up_stream:up_stream,
            down_stream:down_stream)
        return return_stream
    end

    private

    def axi_stream_packet_fifo_with_info_draw(
        depth:2,
        esize:8,
        info_in:"info_in",
        info_out:"info_out",
        axis_in:"axis_in",
        axis_out:"axis_out",
        up_stream:nil,
        down_stream:nil
    )

        large_name_len(
            depth,
            esize,
            info_in,
            info_out,
            axis_in,
            axis_out
        )
        instance_name = "axi_stream_packet_fifo_with_info_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/packet_fifo/axi_stream_packet_fifo_with_info.sv
axi_stream_packet_fifo_with_info#(
    .DEPTH    (#{align_signal(depth)}),
    .ESIZE    (#{align_signal(esize)})
) #{instance_name}(
/*  input  [ESIZE-1:0]   */ .info_in  (#{align_signal(info_in,q_mark=false)}),
/*  output [ESIZE-1:0]   */ .info_out (#{align_signal(info_out,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .axis_in  (#{align_signal(axis_in,q_mark=false)}),
/*  axi_stream_inf.master*/ .axis_out (#{align_signal(axis_out,q_mark=false)})
);
"
    end
    
    public

    def self.axi_stream_packet_fifo_with_info(
        depth:2,
        esize:8,
        info_in:"info_in",
        info_out:"info_out",
        axis_in:"axis_in",
        axis_out:"axis_out",
        up_stream:nil,
        down_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [axis_in,axis_out].first.belong_to_module unless belong_to_module
        
        if down_stream.nil? && axis_out.eql?("axis_out")
            if up_stream.is_a? AxiStream
                down_stream = up_stream.copy
            else
                down_stream = axis_in.copy
            end
            return_stream = down_stream
        end

        
        if up_stream.nil? && axis_in.eql?("axis_in")
            if down_stream.is_a? AxiStream
                up_stream = down_stream.copy
            else
                up_stream = axis_out.copy
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? AxiStream
            down_stream.axi_stream_packet_fifo_with_info(
                depth:depth,
                esize:esize,
                info_in:info_in,
                info_out:info_out,
                axis_in:axis_in,
                axis_out:axis_out,
                up_stream:up_stream,
                down_stream:down_stream)
        elsif axis_out.is_a? AxiStream
            axis_out.axi_stream_packet_fifo_with_info(
                depth:depth,
                esize:esize,
                info_in:info_in,
                info_out:info_out,
                axis_in:axis_in,
                axis_out:axis_out,
                up_stream:up_stream,
                down_stream:down_stream)
        else
            belong_to_module.AxiStream_NC.axi_stream_packet_fifo_with_info(
                depth:depth,
                esize:esize,
                info_in:info_in,
                info_out:info_out,
                axis_in:axis_in,
                axis_out:axis_out,
                up_stream:up_stream,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

