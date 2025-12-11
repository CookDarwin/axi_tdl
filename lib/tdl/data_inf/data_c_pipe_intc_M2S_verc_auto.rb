
#2018-05-04 14:40:11 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class DataInf_C


    def data_c_pipe_intc_m2s_verc(
        prio:"BEST_ROBIN",
        num:8,
        last:"last",
        s00:"s00",
        m00:"m00",
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('data_c_pipe_intc_m2s_verc','../../axi/data_interface/data_inf_c/data_c_pipe_intc_M2S_verc.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['data_c_pipe_intc_m2s_verc','../../axi/data_interface/data_inf_c/data_c_pipe_intc_M2S_verc.sv'])
        return_stream = self
        
        s00 = DataInf_C.same_name_socket(:from_up,mix=false,s00,nil,belong_to_module) unless s00.is_a? String
        m00 = DataInf_C.same_name_socket(:to_down,mix=true,m00,nil,belong_to_module) unless m00.is_a? String
        
        
        unless self.eql? belong_to_module.DataInf_C_NC
            m00 = self
        else
            if down_stream
                m00 = down_stream
            end
        end


        belong_to_module.DataInf_C_draw << data_c_pipe_intc_m2s_verc_draw(
            prio:prio,
            num:num,
            last:last,
            s00:s00,
            m00:m00,
            down_stream:down_stream)
        return return_stream
    end

    private

    def data_c_pipe_intc_m2s_verc_draw(
        prio:"BEST_ROBIN",
        num:8,
        last:"last",
        s00:"s00",
        m00:"m00",
        down_stream:nil
    )

        large_name_len(
            prio,
            num,
            last,
            s00,
            m00
        )
        instance_name = "data_c_pipe_intc_M2S_verc_#{signal}_inst"
"
// FilePath:::../../axi/data_interface/data_inf_c/data_c_pipe_intc_M2S_verc.sv
data_c_pipe_intc_M2S_verc#(
    .PRIO    (#{align_signal(prio)}),
    .NUM     (#{align_signal(num)})
) #{instance_name}(
/*  input  [NUM-1:0] */ .last (#{align_signal(last,q_mark=false)}),
/*  data_inf_c.slaver*/ .s00  (#{align_signal(s00,q_mark=false)}),
/*  data_inf_c.master*/ .m00  (#{align_signal(m00,q_mark=false)})
);
"
    end
    
    public

    def self.data_c_pipe_intc_m2s_verc(
        prio:"BEST_ROBIN",
        num:8,
        last:"last",
        s00:"s00",
        m00:"m00",
        down_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [s00,m00].first.belong_to_module unless belong_to_module
        
        
        
        if down_stream.is_a? DataInf_C
            down_stream.data_c_pipe_intc_m2s_verc(
                prio:prio,
                num:num,
                last:last,
                s00:s00,
                m00:m00,
                down_stream:down_stream)
        elsif m00.is_a? DataInf_C
            m00.data_c_pipe_intc_m2s_verc(
                prio:prio,
                num:num,
                last:last,
                s00:s00,
                m00:m00,
                down_stream:down_stream)
        else
            belong_to_module.DataInf_C_NC.data_c_pipe_intc_m2s_verc(
                prio:prio,
                num:num,
                last:last,
                s00:s00,
                m00:m00,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

