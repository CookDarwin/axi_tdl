
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def _data_to_axis_inf(
        mark_curr_data:"mark_curr_data",
        last_flag:"last_flag",
        data_slaver:"data_slaver",
        axis_master:"axis_master"
    )

        Tdl.add_to_all_file_paths('data_to_axis_inf','../../axi/AXI_stream/data_to_axis_inf.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['data_to_axis_inf','../../axi/AXI_stream/data_to_axis_inf.sv'])
        return_stream = self
        
        data_slaver = DataInf_C.same_name_socket(:from_up,mix=true,data_slaver,nil,belong_to_module) unless data_slaver.is_a? String
        axis_master = AxiStream.same_name_socket(:to_down,mix=true,axis_master,nil,belong_to_module) unless axis_master.is_a? String
        
        
        


        belong_to_module.AxiStream_draw << _data_to_axis_inf_draw(
            mark_curr_data:mark_curr_data,
            last_flag:last_flag,
            data_slaver:data_slaver,
            axis_master:axis_master)
        return return_stream
    end

    private

    def _data_to_axis_inf_draw(
        mark_curr_data:"mark_curr_data",
        last_flag:"last_flag",
        data_slaver:"data_slaver",
        axis_master:"axis_master"
    )

        large_name_len(
            mark_curr_data,
            last_flag,
            data_slaver,
            axis_master
        )
        instance_name = "data_to_axis_inf_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/data_to_axis_inf.sv
data_to_axis_inf #{instance_name}(
/*  input                */ .mark_curr_data (#{align_signal(mark_curr_data,q_mark=false)}),
/*  input                */ .last_flag      (#{align_signal(last_flag,q_mark=false)}),
/*  data_inf_c.slaver    */ .data_slaver    (#{align_signal(data_slaver,q_mark=false)}),
/*  axi_stream_inf.master*/ .axis_master    (#{align_signal(axis_master,q_mark=false)})
);
"
    end
    
    public

    def self.data_to_axis_inf(
        mark_curr_data:"mark_curr_data",
        last_flag:"last_flag",
        data_slaver:"data_slaver",
        axis_master:"axis_master",
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [axis_master].first.belong_to_module unless belong_to_module
        
        
        belong_to_module.AxiStream_NC._data_to_axis_inf(
            mark_curr_data:mark_curr_data,
            last_flag:last_flag,
            data_slaver:data_slaver,
            axis_master:axis_master)
        return return_stream
    end
        

end

