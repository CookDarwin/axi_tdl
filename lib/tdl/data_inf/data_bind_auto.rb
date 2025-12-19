
#2018-05-04 14:40:11 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class DataInf_C


    def _data_bind(
        num:2,
        data_in:"data_in",
        data_out:"data_out"
    )

        Tdl.add_to_all_file_paths('data_bind','../../axi/data_interface/data_inf_c/data_bind.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['data_bind','../../axi/data_interface/data_inf_c/data_bind.sv'])
        return_stream = self
        
        data_in = DataInf_C.same_name_socket(:from_up,mix=false,data_in,nil,belong_to_module) unless data_in.is_a? String
        data_out = DataInf_C.same_name_socket(:to_down,mix=true,data_out,nil,belong_to_module) unless data_out.is_a? String
        
        
        


        belong_to_module.DataInf_C_draw << _data_bind_draw(
            num:num,
            data_in:data_in,
            data_out:data_out)
        return return_stream
    end

    private

    def _data_bind_draw(
        num:2,
        data_in:"data_in",
        data_out:"data_out"
    )

        large_name_len(
            num,
            data_in,
            data_out
        )
        instance_name = "data_bind_#{signal}_inst"
"
// FilePath:::../../axi/data_interface/data_inf_c/data_bind.sv
data_bind#(
    .NUM    (#{align_signal(num)})
) #{instance_name}(
/*  data_inf_c.slaver*/ .data_in  (#{align_signal(data_in,q_mark=false)}),
/*  data_inf_c.master*/ .data_out (#{align_signal(data_out,q_mark=false)})
);
"
    end
    
    public

    def self.data_bind(
        num:2,
        data_in:"data_in",
        data_out:"data_out",
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [data_in,data_out].first.belong_to_module unless belong_to_module
        
        
        belong_to_module.DataInf_C_NC._data_bind(
            num:num,
            data_in:data_in,
            data_out:data_out)
        return return_stream
    end
        

end

