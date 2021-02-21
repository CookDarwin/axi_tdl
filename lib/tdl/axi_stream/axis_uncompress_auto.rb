
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def _axis_uncompress(
        asize:8,
        lsize:8,
        axis_zip:"axis_zip",
        axis_unzip:"axis_unzip"
    )

        Tdl.add_to_all_file_paths('axis_uncompress','../../axi/AXI_stream/axis_uncompress.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axis_uncompress','../../axi/AXI_stream/axis_uncompress.sv'])
        return_stream = self
        
        axis_zip = AxiStream.same_name_socket(:from_up,mix=true,axis_zip,nil,belong_to_module) unless axis_zip.is_a? String
        axis_unzip = AxiStream.same_name_socket(:to_down,mix=true,axis_unzip,nil,belong_to_module) unless axis_unzip.is_a? String
        
        
        


        belong_to_module.AxiStream_draw << _axis_uncompress_draw(
            asize:asize,
            lsize:lsize,
            axis_zip:axis_zip,
            axis_unzip:axis_unzip)
        return return_stream
    end

    private

    def _axis_uncompress_draw(
        asize:8,
        lsize:8,
        axis_zip:"axis_zip",
        axis_unzip:"axis_unzip"
    )

        large_name_len(
            asize,
            lsize,
            axis_zip,
            axis_unzip
        )
        instance_name = "axis_uncompress_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/axis_uncompress.sv
axis_uncompress#(
    .ASIZE    (#{align_signal(asize)}),
    .LSIZE    (#{align_signal(lsize)})
) #{instance_name}(
/*  axi_stream_inf.slaver*/ .axis_zip   (#{align_signal(axis_zip,q_mark=false)}),
/*  axi_stream_inf.master*/ .axis_unzip (#{align_signal(axis_unzip,q_mark=false)})
);
"
    end
    
    public

    def self.axis_uncompress(
        asize:8,
        lsize:8,
        axis_zip:"axis_zip",
        axis_unzip:"axis_unzip",
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [axis_zip,axis_unzip].first.belong_to_module unless belong_to_module
        
        
        belong_to_module.AxiStream_NC._axis_uncompress(
            asize:asize,
            lsize:lsize,
            axis_zip:axis_zip,
            axis_unzip:axis_unzip)
        return return_stream
    end
        

end

