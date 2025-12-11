
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def gen_origin_axis(
        mode:"RANGE",
        enable:"enable",
        ready:"ready",
        length:"length",
        axis_out:"axis_out",
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('gen_origin_axis','../../axi/AXI_stream/gen_origin_axis.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['gen_origin_axis','../../axi/AXI_stream/gen_origin_axis.sv'])
        return_stream = self
        
        axis_out = AxiStream.same_name_socket(:to_down,mix=true,axis_out,nil,belong_to_module) unless axis_out.is_a? String
        
        
        unless self.eql? belong_to_module.AxiStream_NC
            axis_out = self
        else
            if down_stream
                axis_out = down_stream
            end
        end


        belong_to_module.AxiStream_draw << gen_origin_axis_draw(
            mode:mode,
            enable:enable,
            ready:ready,
            length:length,
            axis_out:axis_out,
            down_stream:down_stream)
        return return_stream
    end

    private

    def gen_origin_axis_draw(
        mode:"RANGE",
        enable:"enable",
        ready:"ready",
        length:"length",
        axis_out:"axis_out",
        down_stream:nil
    )

        large_name_len(
            mode,
            enable,
            ready,
            length,
            axis_out
        )
        instance_name = "gen_origin_axis_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/gen_origin_axis.sv
gen_origin_axis#(
    .MODE    (#{align_signal(mode)})
) #{instance_name}(
/*  input                */ .enable   (#{align_signal(enable,q_mark=false)}),
/*  output               */ .ready    (#{align_signal(ready,q_mark=false)}),
/*  input  [31:0]        */ .length   (#{align_signal(length,q_mark=false)}),
/*  axi_stream_inf.master*/ .axis_out (#{align_signal(axis_out,q_mark=false)})
);
"
    end
    
    public

    def self.gen_origin_axis(
        mode:"RANGE",
        enable:"enable",
        ready:"ready",
        length:"length",
        axis_out:"axis_out",
        down_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [axis_out].first.belong_to_module unless belong_to_module
        
        
        
        if down_stream.is_a? AxiStream
            down_stream.gen_origin_axis(
                mode:mode,
                enable:enable,
                ready:ready,
                length:length,
                axis_out:axis_out,
                down_stream:down_stream)
        elsif axis_out.is_a? AxiStream
            axis_out.gen_origin_axis(
                mode:mode,
                enable:enable,
                ready:ready,
                length:length,
                axis_out:axis_out,
                down_stream:down_stream)
        else
            belong_to_module.AxiStream_NC.gen_origin_axis(
                mode:mode,
                enable:enable,
                ready:ready,
                length:length,
                axis_out:axis_out,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

