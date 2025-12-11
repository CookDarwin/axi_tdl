
#2018-05-04 14:40:11 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class DataInf_C


    def data_valve(
        button:"button",
        data_in:"data_in",
        data_out:"data_out",
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('data_valve','../../axi/data_interface/data_inf_c/data_valve.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['data_valve','../../axi/data_interface/data_inf_c/data_valve.sv'])
        return_stream = self
        
        data_in = DataInf_C.same_name_socket(:from_up,mix=true,data_in,nil,belong_to_module) unless data_in.is_a? String
        data_out = DataInf_C.same_name_socket(:to_down,mix=true,data_out,nil,belong_to_module) unless data_out.is_a? String
        
        
        unless self.eql? belong_to_module.DataInf_C_NC
            data_out = self
        else
            if down_stream
                data_out = down_stream
            end
        end


        belong_to_module.DataInf_C_draw << data_valve_draw(
            button:button,
            data_in:data_in,
            data_out:data_out,
            down_stream:down_stream)
        return return_stream
    end

    private

    def data_valve_draw(
        button:"button",
        data_in:"data_in",
        data_out:"data_out",
        down_stream:nil
    )

        large_name_len(
            button,
            data_in,
            data_out
        )
        instance_name = "data_valve_#{signal}_inst"
"
// FilePath:::../../axi/data_interface/data_inf_c/data_valve.sv
data_valve #{instance_name}(
/*  input            */ .button   (#{align_signal(button,q_mark=false)}),
/*  data_inf_c.slaver*/ .data_in  (#{align_signal(data_in,q_mark=false)}),
/*  data_inf_c.master*/ .data_out (#{align_signal(data_out,q_mark=false)})
);
"
    end
    
    public

    def self.data_valve(
        button:"button",
        data_in:"data_in",
        data_out:"data_out",
        down_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [data_in,data_out].first.belong_to_module unless belong_to_module
        
        
        
        if down_stream.is_a? DataInf_C
            down_stream.data_valve(
                button:button,
                data_in:data_in,
                data_out:data_out,
                down_stream:down_stream)
        elsif data_out.is_a? DataInf_C
            data_out.data_valve(
                button:button,
                data_in:data_in,
                data_out:data_out,
                down_stream:down_stream)
        else
            belong_to_module.DataInf_C_NC.data_valve(
                button:button,
                data_in:data_in,
                data_out:data_out,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

