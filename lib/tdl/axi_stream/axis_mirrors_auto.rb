
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def axis_mirrors(
        h:0,
        l:0,
        num:8,
        mode:"CDS_MODE",
        condition_data:"condition_data",
        axis_in:"axis_in",
        axis_mirror:"axis_mirror",
        up_stream:nil,
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('axis_mirrors','../../axi/AXI_stream/axis_mirrors.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axis_mirrors','../../axi/AXI_stream/axis_mirrors.sv'])
        return_stream = self
        
        axis_in = AxiStream.same_name_socket(:from_up,mix=true,axis_in,nil,belong_to_module) unless axis_in.is_a? String
        axis_mirror = AxiStream.same_name_socket(:to_down,mix=false,axis_mirror,nil,belong_to_module) unless axis_mirror.is_a? String
        
        if up_stream.nil? && axis_in.eql?("axis_in") && (!(axis_mirror.eql?("axis_mirror")) || !down_stream.nil?)
            # up_stream = self.copy(name:"axis_in")
            # return_stream = up_stream
            axis_mirror = down_stream if down_stream
            return down_stream.axis_mirrors(axis_in:self)
        end

        axis_in = up_stream if up_stream
        unless self.eql? belong_to_module.AxiStream_NC
            axis_mirror = self
        else
            if down_stream
                axis_mirror = down_stream
            end
        end


        belong_to_module.AxiStream_draw << axis_mirrors_draw(
            h:h,
            l:l,
            num:num,
            mode:mode,
            condition_data:condition_data,
            axis_in:axis_in,
            axis_mirror:axis_mirror,
            up_stream:up_stream,
            down_stream:down_stream)
        return return_stream
    end

    private

    def axis_mirrors_draw(
        h:0,
        l:0,
        num:8,
        mode:"CDS_MODE",
        condition_data:"condition_data",
        axis_in:"axis_in",
        axis_mirror:"axis_mirror",
        up_stream:nil,
        down_stream:nil
    )

        large_name_len(
            h,
            l,
            num,
            mode,
            condition_data,
            axis_in,
            axis_mirror
        )
        instance_name = "axis_mirrors_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/axis_mirrors.sv
axis_mirrors#(
    .H       (#{align_signal(h)}),
    .L       (#{align_signal(l)}),
    .NUM     (#{align_signal(num)}),
    .MODE    (#{align_signal(mode)})
) #{instance_name}(
/*  input  [H:L]         */ .condition_data (#{align_signal(condition_data,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .axis_in        (#{align_signal(axis_in,q_mark=false)}),
/*  axi_stream_inf.master*/ .axis_mirror    (#{align_signal(axis_mirror,q_mark=false)})
);
"
    end
    
    public

    def self.axis_mirrors(
        h:0,
        l:0,
        num:8,
        mode:"CDS_MODE",
        condition_data:"condition_data",
        axis_in:"axis_in",
        axis_mirror:"axis_mirror",
        up_stream:nil,
        down_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [axis_in,axis_mirror].first.belong_to_module unless belong_to_module
        
        if down_stream.nil? && axis_mirror.eql?("axis_mirror")
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
                up_stream = axis_mirror.copy
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? AxiStream
            down_stream.axis_mirrors(
                h:h,
                l:l,
                num:num,
                mode:mode,
                condition_data:condition_data,
                axis_in:axis_in,
                axis_mirror:axis_mirror,
                up_stream:up_stream,
                down_stream:down_stream)
        elsif axis_mirror.is_a? AxiStream
            axis_mirror.axis_mirrors(
                h:h,
                l:l,
                num:num,
                mode:mode,
                condition_data:condition_data,
                axis_in:axis_in,
                axis_mirror:axis_mirror,
                up_stream:up_stream,
                down_stream:down_stream)
        else
            belong_to_module.AxiStream_NC.axis_mirrors(
                h:h,
                l:l,
                num:num,
                mode:mode,
                condition_data:condition_data,
                axis_in:axis_in,
                axis_mirror:axis_mirror,
                up_stream:up_stream,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

