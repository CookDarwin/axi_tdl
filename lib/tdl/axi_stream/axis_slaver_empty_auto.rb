
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def _axis_slaver_empty(
        slaver:"slaver",
        up_stream:nil
    )

        Tdl.add_to_all_file_paths('axis_slaver_empty','../../axi/AXI_stream/axis_slaver_empty.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axis_slaver_empty','../../axi/AXI_stream/axis_slaver_empty.sv'])
        return_stream = self
        
        slaver = AxiStream.same_name_socket(:from_up,mix=true,slaver,nil,belong_to_module) unless slaver.is_a? String
        
        slaver = up_stream if up_stream
        


        belong_to_module.AxiStream_draw << _axis_slaver_empty_draw(
            slaver:slaver,
            up_stream:up_stream)
        return return_stream
    end

    private

    def _axis_slaver_empty_draw(
        slaver:"slaver",
        up_stream:nil
    )

        large_name_len(
            slaver
        )
        instance_name = "axis_slaver_empty_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/axis_slaver_empty.sv
axis_slaver_empty #{instance_name}(
/*  axi_stream_inf.slaver*/ .slaver (#{align_signal(slaver,q_mark=false)})
);
"
    end
    
    public

    def self.axis_slaver_empty(
        slaver:"slaver",
        up_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [slaver].first.belong_to_module unless belong_to_module
        
        
        belong_to_module.AxiStream_NC._axis_slaver_empty(
            slaver:slaver,
            up_stream:up_stream)
        return return_stream
    end
        

end

