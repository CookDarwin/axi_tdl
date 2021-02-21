
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def _axis_full_to_data_c(
        data_out_inf:"data_out_inf",
        axis_in:"axis_in"
    )

        Tdl.add_to_all_file_paths('axis_full_to_data_c','../../axi/AXI_stream/axis_full_to_data_c.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axis_full_to_data_c','../../axi/AXI_stream/axis_full_to_data_c.sv'])
        return_stream = self
        
        data_out_inf = DataInf_C.same_name_socket(:to_down,mix=true,data_out_inf,nil,belong_to_module) unless data_out_inf.is_a? String
        axis_in = AxiStream.same_name_socket(:from_up,mix=true,axis_in,nil,belong_to_module) unless axis_in.is_a? String
        
        
        


        belong_to_module.AxiStream_draw << _axis_full_to_data_c_draw(
            data_out_inf:data_out_inf,
            axis_in:axis_in)
        return return_stream
    end

    private

    def _axis_full_to_data_c_draw(
        data_out_inf:"data_out_inf",
        axis_in:"axis_in"
    )

        large_name_len(
            data_out_inf,
            axis_in
        )
        instance_name = "axis_full_to_data_c_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/axis_full_to_data_c.sv
axis_full_to_data_c #{instance_name}(
/*  data_inf_c.master    */ .data_out_inf (#{align_signal(data_out_inf,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .axis_in      (#{align_signal(axis_in,q_mark=false)})
);
"
    end
    
    public

    def self.axis_full_to_data_c(
        data_out_inf:"data_out_inf",
        axis_in:"axis_in",
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [axis_in].first.belong_to_module unless belong_to_module
        
        
        belong_to_module.AxiStream_NC._axis_full_to_data_c(
            data_out_inf:data_out_inf,
            axis_in:axis_in)
        return return_stream
    end
        

end

