
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def axis_append(
        mode:"BOTH",
        dsize:8,
        head_field_len:16*8,
        head_field_name:"HEAD Filed",
        end_field_len:16*8,
        end_field_name:"END Filed",
        head_value:"head_value",
        end_value:"end_value",
        origin_in:"origin_in",
        append_out:"append_out",
        up_stream:nil,
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('axis_append','../../axi/AXI_stream/axis_append.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axis_append','../../axi/AXI_stream/axis_append.sv'])
        return_stream = self
        
        origin_in = AxiStream.same_name_socket(:from_up,mix=true,origin_in,nil,belong_to_module) unless origin_in.is_a? String
        append_out = AxiStream.same_name_socket(:to_down,mix=true,append_out,nil,belong_to_module) unless append_out.is_a? String
        
        if up_stream.nil? && origin_in.eql?("origin_in") && (!(append_out.eql?("append_out")) || !down_stream.nil?)
            # up_stream = self.copy(name:"origin_in")
            # return_stream = up_stream
            append_out = down_stream if down_stream
            return down_stream.axis_append(origin_in:self)
        end

        origin_in = up_stream if up_stream
        unless self.eql? belong_to_module.AxiStream_NC
            append_out = self
        else
            if down_stream
                append_out = down_stream
            end
        end


        belong_to_module.AxiStream_draw << axis_append_draw(
            mode:mode,
            dsize:dsize,
            head_field_len:head_field_len,
            head_field_name:head_field_name,
            end_field_len:end_field_len,
            end_field_name:end_field_name,
            head_value:head_value,
            end_value:end_value,
            origin_in:origin_in,
            append_out:append_out,
            up_stream:up_stream,
            down_stream:down_stream)
        return return_stream
    end

    private

    def axis_append_draw(
        mode:"BOTH",
        dsize:8,
        head_field_len:16*8,
        head_field_name:"HEAD Filed",
        end_field_len:16*8,
        end_field_name:"END Filed",
        head_value:"head_value",
        end_value:"end_value",
        origin_in:"origin_in",
        append_out:"append_out",
        up_stream:nil,
        down_stream:nil
    )

        large_name_len(
            mode,
            dsize,
            head_field_len,
            head_field_name,
            end_field_len,
            end_field_name,
            head_value,
            end_value,
            origin_in,
            append_out
        )
        instance_name = "axis_append_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/axis_append.sv
axis_append#(
    .MODE               (#{align_signal(mode)}),
    .DSIZE              (#{align_signal(dsize)}),
    .HEAD_FIELD_LEN     (#{align_signal(head_field_len)}),
    .HEAD_FIELD_NAME    (#{align_signal(head_field_name)}),
    .END_FIELD_LEN      (#{align_signal(end_field_len)}),
    .END_FIELD_NAME     (#{align_signal(end_field_name)})
) #{instance_name}(
/*  input  [HEAD_FIELD_LEN*DSIZE-1:0]*/ .head_value (#{align_signal(head_value,q_mark=false)}),
/*  input  [END_FIELD_LEN*DSIZE-1:0] */ .end_value  (#{align_signal(end_value,q_mark=false)}),
/*  axi_stream_inf.slaver            */ .origin_in  (#{align_signal(origin_in,q_mark=false)}),
/*  axi_stream_inf.master            */ .append_out (#{align_signal(append_out,q_mark=false)})
);
"
    end
    
    public

    def self.axis_append(
        mode:"BOTH",
        dsize:8,
        head_field_len:16*8,
        head_field_name:"HEAD Filed",
        end_field_len:16*8,
        end_field_name:"END Filed",
        head_value:"head_value",
        end_value:"end_value",
        origin_in:"origin_in",
        append_out:"append_out",
        up_stream:nil,
        down_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [origin_in,append_out].first.belong_to_module unless belong_to_module
        
        if down_stream.nil? && append_out.eql?("append_out")
            if up_stream.is_a? AxiStream
                down_stream = up_stream.copy
            else
                down_stream = origin_in.copy
            end
            return_stream = down_stream
        end

        
        if up_stream.nil? && origin_in.eql?("origin_in")
            if down_stream.is_a? AxiStream
                up_stream = down_stream.copy
            else
                up_stream = append_out.copy
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? AxiStream
            down_stream.axis_append(
                mode:mode,
                dsize:dsize,
                head_field_len:head_field_len,
                head_field_name:head_field_name,
                end_field_len:end_field_len,
                end_field_name:end_field_name,
                head_value:head_value,
                end_value:end_value,
                origin_in:origin_in,
                append_out:append_out,
                up_stream:up_stream,
                down_stream:down_stream)
        elsif append_out.is_a? AxiStream
            append_out.axis_append(
                mode:mode,
                dsize:dsize,
                head_field_len:head_field_len,
                head_field_name:head_field_name,
                end_field_len:end_field_len,
                end_field_name:end_field_name,
                head_value:head_value,
                end_value:end_value,
                origin_in:origin_in,
                append_out:append_out,
                up_stream:up_stream,
                down_stream:down_stream)
        else
            belong_to_module.AxiStream_NC.axis_append(
                mode:mode,
                dsize:dsize,
                head_field_len:head_field_len,
                head_field_name:head_field_name,
                end_field_len:end_field_len,
                end_field_name:end_field_name,
                head_value:head_value,
                end_value:end_value,
                origin_in:origin_in,
                append_out:append_out,
                up_stream:up_stream,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

