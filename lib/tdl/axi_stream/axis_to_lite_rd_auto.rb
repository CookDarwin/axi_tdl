
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def _axis_to_lite_rd(
        dummy:8,
        lite:"lite",
        axis_in:"axis_in",
        rd_rel_axis:"rd_rel_axis"
    )

        Tdl.add_to_all_file_paths('axis_to_lite_rd','../../axi/AXI_stream/axis_to_lite_rd.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axis_to_lite_rd','../../axi/AXI_stream/axis_to_lite_rd.sv'])
        return_stream = self
        
        lite = AxiLite.same_name_socket(:mirror,mix=true,lite,nil,belong_to_module) unless lite.is_a? String
        axis_in = AxiStream.same_name_socket(:from_up,mix=true,axis_in,nil,belong_to_module) unless axis_in.is_a? String
        rd_rel_axis = AxiStream.same_name_socket(:to_down,mix=true,rd_rel_axis,nil,belong_to_module) unless rd_rel_axis.is_a? String
        
        
        


        belong_to_module.AxiStream_draw << _axis_to_lite_rd_draw(
            dummy:dummy,
            lite:lite,
            axis_in:axis_in,
            rd_rel_axis:rd_rel_axis)
        return return_stream
    end

    private

    def _axis_to_lite_rd_draw(
        dummy:8,
        lite:"lite",
        axis_in:"axis_in",
        rd_rel_axis:"rd_rel_axis"
    )

        large_name_len(
            dummy,
            lite,
            axis_in,
            rd_rel_axis
        )
        instance_name = "axis_to_lite_rd_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/axis_to_lite_rd.sv
axis_to_lite_rd#(
    .DUMMY    (#{align_signal(dummy)})
) #{instance_name}(
/*  axi_lite_inf.master_rd*/ .lite        (#{align_signal(lite,q_mark=false)}),
/*  axi_stream_inf.slaver */ .axis_in     (#{align_signal(axis_in,q_mark=false)}),
/*  axi_stream_inf.master */ .rd_rel_axis (#{align_signal(rd_rel_axis,q_mark=false)})
);
"
    end
    
    public

    def self.axis_to_lite_rd(
        dummy:8,
        lite:"lite",
        axis_in:"axis_in",
        rd_rel_axis:"rd_rel_axis",
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [axis_in,rd_rel_axis].first.belong_to_module unless belong_to_module
        
        
        belong_to_module.AxiStream_NC._axis_to_lite_rd(
            dummy:dummy,
            lite:lite,
            axis_in:axis_in,
            rd_rel_axis:rd_rel_axis)
        return return_stream
    end
        

end

