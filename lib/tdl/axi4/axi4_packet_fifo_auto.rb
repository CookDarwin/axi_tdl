
#2018-05-04 14:40:11 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class Axi4


    def axi4_packet_fifo(
        pipe:"OFF",
        depth:4,
        mode:"BOTH",
        axi_in:"axi_in",
        axi_out:"axi_out",
        up_stream:nil,
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('axi4_packet_fifo','../../axi/AXI4/packet_fifo/axi4_packet_fifo.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axi4_packet_fifo','../../axi/AXI4/packet_fifo/axi4_packet_fifo.sv'])
        return_stream = self
        
        axi_in = Axi4.same_name_socket(:from_up,mix=true,axi_in,nil,belong_to_module) unless axi_in.is_a? String
        axi_out = Axi4.same_name_socket(:to_down,mix=true,axi_out,nil,belong_to_module) unless axi_out.is_a? String
        
        if up_stream.nil? && axi_in.eql?("axi_in") && (!(axi_out.eql?("axi_out")) || !down_stream.nil?)
            # up_stream = self.copy(name:"axi_in")
            # return_stream = up_stream
            axi_out = down_stream if down_stream
            return down_stream.axi4_packet_fifo(axi_in:self)
        end

        axi_in = up_stream if up_stream
        unless self.eql? belong_to_module.Axi4_NC
            axi_out = self
        else
            if down_stream
                axi_out = down_stream
            end
        end


        belong_to_module.Axi4_draw << axi4_packet_fifo_draw(
            pipe:pipe,
            depth:depth,
            mode:mode,
            axi_in:axi_in,
            axi_out:axi_out,
            up_stream:up_stream,
            down_stream:down_stream)
        return return_stream
    end

    private

    def axi4_packet_fifo_draw(
        pipe:"OFF",
        depth:4,
        mode:"BOTH",
        axi_in:"axi_in",
        axi_out:"axi_out",
        up_stream:nil,
        down_stream:nil
    )

        large_name_len(
            pipe,
            depth,
            mode,
            axi_in,
            axi_out
        )
        instance_name = "axi4_packet_fifo_#{signal}_inst"
"
// FilePath:::../../axi/AXI4/packet_fifo/axi4_packet_fifo.sv
axi4_packet_fifo#(
    .PIPE     (#{align_signal(pipe)}),
    .DEPTH    (#{align_signal(depth)}),
    .MODE     (#{align_signal(mode)})
) #{instance_name}(
/*  axi_inf.slaver*/ .axi_in  (#{align_signal(axi_in,q_mark=false)}),
/*  axi_inf.master*/ .axi_out (#{align_signal(axi_out,q_mark=false)})
);
"
    end
    
    public

    def self.axi4_packet_fifo(
        pipe:"OFF",
        depth:4,
        mode:"BOTH",
        axi_in:"axi_in",
        axi_out:"axi_out",
        up_stream:nil,
        down_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [axi_in,axi_out].first.belong_to_module unless belong_to_module
        
        if down_stream.nil? && axi_out.eql?("axi_out")
            if up_stream.is_a? Axi4
                down_stream = up_stream.copy
            else
                down_stream = axi_in.copy
            end
            return_stream = down_stream
        end

        
        if up_stream.nil? && axi_in.eql?("axi_in")
            if down_stream.is_a? Axi4
                up_stream = down_stream.copy
            else
                up_stream = axi_out.copy
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? Axi4
            down_stream.axi4_packet_fifo(
                pipe:pipe,
                depth:depth,
                mode:mode,
                axi_in:axi_in,
                axi_out:axi_out,
                up_stream:up_stream,
                down_stream:down_stream)
        elsif axi_out.is_a? Axi4
            axi_out.axi4_packet_fifo(
                pipe:pipe,
                depth:depth,
                mode:mode,
                axi_in:axi_in,
                axi_out:axi_out,
                up_stream:up_stream,
                down_stream:down_stream)
        else
            belong_to_module.Axi4_NC.axi4_packet_fifo(
                pipe:pipe,
                depth:depth,
                mode:mode,
                axi_in:axi_in,
                axi_out:axi_out,
                up_stream:up_stream,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

