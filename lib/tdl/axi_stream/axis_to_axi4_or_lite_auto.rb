
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def _axis_to_axi4_or_lite(
        lite:"lite",
        axis_in:"axis_in",
        rd_rel_axis:"rd_rel_axis",
        axi4:"axi4"
    )

        Tdl.add_to_all_file_paths('axis_to_axi4_or_lite','../../axi/AXI_stream/axis_to_axi4_or_lite.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axis_to_axi4_or_lite','../../axi/AXI_stream/axis_to_axi4_or_lite.sv'])
        return_stream = self
        
        lite = AxiLite.same_name_socket(:to_down,mix=true,lite,nil,belong_to_module) unless lite.is_a? String
        axis_in = AxiStream.same_name_socket(:from_up,mix=true,axis_in,nil,belong_to_module) unless axis_in.is_a? String
        rd_rel_axis = AxiStream.same_name_socket(:to_down,mix=true,rd_rel_axis,nil,belong_to_module) unless rd_rel_axis.is_a? String
        axi4 = Axi4.same_name_socket(:to_down,mix=true,axi4,nil,belong_to_module) unless axi4.is_a? String
        
        
        


        belong_to_module.AxiStream_draw << _axis_to_axi4_or_lite_draw(
            lite:lite,
            axis_in:axis_in,
            rd_rel_axis:rd_rel_axis,
            axi4:axi4)
        return return_stream
    end

    private

    def _axis_to_axi4_or_lite_draw(
        lite:"lite",
        axis_in:"axis_in",
        rd_rel_axis:"rd_rel_axis",
        axi4:"axi4"
    )

        large_name_len(
            lite,
            axis_in,
            rd_rel_axis,
            axi4
        )
        instance_name = "axis_to_axi4_or_lite_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/axis_to_axi4_or_lite.sv
axis_to_axi4_or_lite #{instance_name}(
/*  axi_lite_inf.master  */ .lite        (#{align_signal(lite,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .axis_in     (#{align_signal(axis_in,q_mark=false)}),
/*  axi_stream_inf.master*/ .rd_rel_axis (#{align_signal(rd_rel_axis,q_mark=false)}),
/*  axi_inf.master       */ .axi4        (#{align_signal(axi4,q_mark=false)})
);
"
    end
    
    public

    def self.axis_to_axi4_or_lite(
        lite:"lite",
        axis_in:"axis_in",
        rd_rel_axis:"rd_rel_axis",
        axi4:"axi4",
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [axis_in,rd_rel_axis].first.belong_to_module unless belong_to_module
        
        
        belong_to_module.AxiStream_NC._axis_to_axi4_or_lite(
            lite:lite,
            axis_in:axis_in,
            rd_rel_axis:rd_rel_axis,
            axi4:axi4)
        return return_stream
    end
        

end

