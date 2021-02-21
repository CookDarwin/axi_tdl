
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def _data_c_to_axis_full(
        data_in_inf:"data_in_inf",
        axis_out:"axis_out"
    )

        Tdl.add_to_all_file_paths('data_c_to_axis_full','../../axi/AXI_stream/data_c_to_axis_full.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['data_c_to_axis_full','../../axi/AXI_stream/data_c_to_axis_full.sv'])
        return_stream = self
        
        data_in_inf = DataInf_C.same_name_socket(:from_up,mix=true,data_in_inf,nil,belong_to_module) unless data_in_inf.is_a? String
        axis_out = AxiStream.same_name_socket(:to_down,mix=true,axis_out,nil,belong_to_module) unless axis_out.is_a? String
        
        
        


        belong_to_module.AxiStream_draw << _data_c_to_axis_full_draw(
            data_in_inf:data_in_inf,
            axis_out:axis_out)
        return return_stream
    end

    private

    def _data_c_to_axis_full_draw(
        data_in_inf:"data_in_inf",
        axis_out:"axis_out"
    )

        large_name_len(
            data_in_inf,
            axis_out
        )
        instance_name = "data_c_to_axis_full_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/data_c_to_axis_full.sv
data_c_to_axis_full #{instance_name}(
/*  data_inf_c.slaver    */ .data_in_inf (#{align_signal(data_in_inf,q_mark=false)}),
/*  axi_stream_inf.master*/ .axis_out    (#{align_signal(axis_out,q_mark=false)})
);
"
    end
    
    public

    def self.data_c_to_axis_full(
        data_in_inf:"data_in_inf",
        axis_out:"axis_out",
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [axis_out].first.belong_to_module unless belong_to_module
        
        
        belong_to_module.AxiStream_NC._data_c_to_axis_full(
            data_in_inf:data_in_inf,
            axis_out:axis_out)
        return return_stream
    end
        

end

