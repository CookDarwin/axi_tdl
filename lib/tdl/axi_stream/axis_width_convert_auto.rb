
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def axis_width_convert(
        in_axis:"in_axis",
        out_axis:"out_axis",
        up_stream:nil,
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('axis_width_convert','../../axi/AXI_stream/data_width/axis_width_convert.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axis_width_convert','../../axi/AXI_stream/data_width/axis_width_convert.sv'])
        return_stream = self
        
        in_axis = AxiStream.same_name_socket(:from_up,mix=true,in_axis,nil,belong_to_module) unless in_axis.is_a? String
        out_axis = AxiStream.same_name_socket(:to_down,mix=true,out_axis,nil,belong_to_module) unless out_axis.is_a? String
        
        if up_stream.nil? && in_axis.eql?("in_axis") && (!(out_axis.eql?("out_axis")) || !down_stream.nil?)
            # up_stream = self.copy(name:"in_axis")
            # return_stream = up_stream
            out_axis = down_stream if down_stream
            return down_stream.axis_width_convert(in_axis:self)
        end

        in_axis = up_stream if up_stream
        unless self.eql? belong_to_module.AxiStream_NC
            out_axis = self
        else
            if down_stream
                out_axis = down_stream
            end
        end


        belong_to_module.AxiStream_draw << axis_width_convert_draw(
            in_axis:in_axis,
            out_axis:out_axis,
            up_stream:up_stream,
            down_stream:down_stream)
        return return_stream
    end

    private

    def axis_width_convert_draw(
        in_axis:"in_axis",
        out_axis:"out_axis",
        up_stream:nil,
        down_stream:nil
    )

        large_name_len(
            in_axis,
            out_axis
        )
        instance_name = "axis_width_convert_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/data_width/axis_width_convert.sv
axis_width_convert #{instance_name}(
/*  axi_stream_inf.slaver*/ .in_axis  (#{align_signal(in_axis,q_mark=false)}),
/*  axi_stream_inf.master*/ .out_axis (#{align_signal(out_axis,q_mark=false)})
);
"
    end
    
    public

    def self.axis_width_convert(
        in_axis:"in_axis",
        out_axis:"out_axis",
        up_stream:nil,
        down_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [in_axis,out_axis].first.belong_to_module unless belong_to_module
        
        if down_stream.nil? && out_axis.eql?("out_axis")
            if up_stream.is_a? AxiStream
                down_stream = up_stream.copy
            else
                down_stream = in_axis.copy
            end
            return_stream = down_stream
        end

        
        if up_stream.nil? && in_axis.eql?("in_axis")
            if down_stream.is_a? AxiStream
                up_stream = down_stream.copy
            else
                up_stream = out_axis.copy
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? AxiStream
            down_stream.axis_width_convert(
                in_axis:in_axis,
                out_axis:out_axis,
                up_stream:up_stream,
                down_stream:down_stream)
        elsif out_axis.is_a? AxiStream
            out_axis.axis_width_convert(
                in_axis:in_axis,
                out_axis:out_axis,
                up_stream:up_stream,
                down_stream:down_stream)
        else
            belong_to_module.AxiStream_NC.axis_width_convert(
                in_axis:in_axis,
                out_axis:out_axis,
                up_stream:up_stream,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

