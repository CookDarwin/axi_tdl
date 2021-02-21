
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def _check_stream_crc(
        axis_in:"axis_in"
    )

        Tdl.add_to_all_file_paths('check_stream_crc','../../axi/AXI_stream/check_stream_crc.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['check_stream_crc','../../axi/AXI_stream/check_stream_crc.sv'])
        return_stream = self
        
        axis_in = AxiStream.same_name_socket(:mirror,mix=true,axis_in,nil,belong_to_module) unless axis_in.is_a? String
        
        
        


        belong_to_module.AxiStream_draw << _check_stream_crc_draw(
            axis_in:axis_in)
        return return_stream
    end

    private

    def _check_stream_crc_draw(
        axis_in:"axis_in"
    )

        large_name_len(
            axis_in
        )
        instance_name = "check_stream_crc_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/check_stream_crc.sv
check_stream_crc #{instance_name}(
/*  axi_stream_inf.mirror*/ .axis_in (#{align_signal(axis_in,q_mark=false)})
);
"
    end
    
    public

    def self.check_stream_crc(
        axis_in:"axis_in",
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [axis_in].first.belong_to_module unless belong_to_module
        
        
        belong_to_module.AxiStream_NC._check_stream_crc(
            axis_in:axis_in)
        return return_stream
    end
        

end

