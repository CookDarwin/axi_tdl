
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def _stream_crc(
        crc:"crc",
        axis_in:"axis_in"
    )

        Tdl.add_to_all_file_paths('stream_crc','../../axi/AXI_stream/stream_crc.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['stream_crc','../../axi/AXI_stream/stream_crc.sv'])
        return_stream = self
        
        axis_in = AxiStream.same_name_socket(:mirror,mix=true,axis_in,nil,belong_to_module) unless axis_in.is_a? String
        
        
        


        belong_to_module.AxiStream_draw << _stream_crc_draw(
            crc:crc,
            axis_in:axis_in)
        return return_stream
    end

    private

    def _stream_crc_draw(
        crc:"crc",
        axis_in:"axis_in"
    )

        large_name_len(
            crc,
            axis_in
        )
        instance_name = "stream_crc_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/stream_crc.sv
stream_crc #{instance_name}(
/*  output [31:0]        */ .crc     (#{align_signal(crc,q_mark=false)}),
/*  axi_stream_inf.mirror*/ .axis_in (#{align_signal(axis_in,q_mark=false)})
);
"
    end
    
    public

    def self.stream_crc(
        crc:"crc",
        axis_in:"axis_in",
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [axis_in].first.belong_to_module unless belong_to_module
        
        
        belong_to_module.AxiStream_NC._stream_crc(
            crc:crc,
            axis_in:axis_in)
        return return_stream
    end
        

end

