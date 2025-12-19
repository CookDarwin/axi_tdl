
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def axis_ram_buffer(
        length:4096,
        wr_en:"wr_en",
        gen_en:"gen_en",
        gen_ready:"gen_ready",
        axis_wr_inf:"axis_wr_inf",
        axis_data_inf:"axis_data_inf",
        up_stream:nil,
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('axis_ram_buffer','../../axi/AXI_stream/axis_ram_buffer.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axis_ram_buffer','../../axi/AXI_stream/axis_ram_buffer.sv'])
        return_stream = self
        
        axis_wr_inf = AxiStream.same_name_socket(:from_up,mix=true,axis_wr_inf,nil,belong_to_module) unless axis_wr_inf.is_a? String
        axis_data_inf = AxiStream.same_name_socket(:to_down,mix=true,axis_data_inf,nil,belong_to_module) unless axis_data_inf.is_a? String
        
        if up_stream.nil? && axis_wr_inf.eql?("axis_wr_inf") && (!(axis_data_inf.eql?("axis_data_inf")) || !down_stream.nil?)
            # up_stream = self.copy(name:"axis_wr_inf")
            # return_stream = up_stream
            axis_data_inf = down_stream if down_stream
            return down_stream.axis_ram_buffer(axis_wr_inf:self)
        end

        axis_wr_inf = up_stream if up_stream
        unless self.eql? belong_to_module.AxiStream_NC
            axis_data_inf = self
        else
            if down_stream
                axis_data_inf = down_stream
            end
        end


        belong_to_module.AxiStream_draw << axis_ram_buffer_draw(
            length:length,
            wr_en:wr_en,
            gen_en:gen_en,
            gen_ready:gen_ready,
            axis_wr_inf:axis_wr_inf,
            axis_data_inf:axis_data_inf,
            up_stream:up_stream,
            down_stream:down_stream)
        return return_stream
    end

    private

    def axis_ram_buffer_draw(
        length:4096,
        wr_en:"wr_en",
        gen_en:"gen_en",
        gen_ready:"gen_ready",
        axis_wr_inf:"axis_wr_inf",
        axis_data_inf:"axis_data_inf",
        up_stream:nil,
        down_stream:nil
    )

        large_name_len(
            length,
            wr_en,
            gen_en,
            gen_ready,
            axis_wr_inf,
            axis_data_inf
        )
        instance_name = "axis_ram_buffer_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/axis_ram_buffer.sv
axis_ram_buffer#(
    .LENGTH    (#{align_signal(length)})
) #{instance_name}(
/*  input                */ .wr_en         (#{align_signal(wr_en,q_mark=false)}),
/*  input                */ .gen_en        (#{align_signal(gen_en,q_mark=false)}),
/*  output               */ .gen_ready     (#{align_signal(gen_ready,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .axis_wr_inf   (#{align_signal(axis_wr_inf,q_mark=false)}),
/*  axi_stream_inf.master*/ .axis_data_inf (#{align_signal(axis_data_inf,q_mark=false)})
);
"
    end
    
    public

    def self.axis_ram_buffer(
        length:4096,
        wr_en:"wr_en",
        gen_en:"gen_en",
        gen_ready:"gen_ready",
        axis_wr_inf:"axis_wr_inf",
        axis_data_inf:"axis_data_inf",
        up_stream:nil,
        down_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [axis_wr_inf,axis_data_inf].first.belong_to_module unless belong_to_module
        
        if down_stream.nil? && axis_data_inf.eql?("axis_data_inf")
            if up_stream.is_a? AxiStream
                down_stream = up_stream.copy
            else
                down_stream = axis_wr_inf.copy
            end
            return_stream = down_stream
        end

        
        if up_stream.nil? && axis_wr_inf.eql?("axis_wr_inf")
            if down_stream.is_a? AxiStream
                up_stream = down_stream.copy
            else
                up_stream = axis_data_inf.copy
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? AxiStream
            down_stream.axis_ram_buffer(
                length:length,
                wr_en:wr_en,
                gen_en:gen_en,
                gen_ready:gen_ready,
                axis_wr_inf:axis_wr_inf,
                axis_data_inf:axis_data_inf,
                up_stream:up_stream,
                down_stream:down_stream)
        elsif axis_data_inf.is_a? AxiStream
            axis_data_inf.axis_ram_buffer(
                length:length,
                wr_en:wr_en,
                gen_en:gen_en,
                gen_ready:gen_ready,
                axis_wr_inf:axis_wr_inf,
                axis_data_inf:axis_data_inf,
                up_stream:up_stream,
                down_stream:down_stream)
        else
            belong_to_module.AxiStream_NC.axis_ram_buffer(
                length:length,
                wr_en:wr_en,
                gen_en:gen_en,
                gen_ready:gen_ready,
                axis_wr_inf:axis_wr_inf,
                axis_data_inf:axis_data_inf,
                up_stream:up_stream,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

