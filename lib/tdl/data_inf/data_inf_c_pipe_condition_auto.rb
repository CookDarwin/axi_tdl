
#2018-05-04 14:40:11 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class DataInf_C


    def data_inf_c_pipe_condition(
        and_condition:"and_condition",
        indata:"indata",
        outdata:"outdata",
        up_stream:nil,
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('data_inf_c_pipe_condition','../../axi/data_interface/data_inf_c/data_inf_c_pipe_condition.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['data_inf_c_pipe_condition','../../axi/data_interface/data_inf_c/data_inf_c_pipe_condition.sv'])
        return_stream = self
        
        indata = DataInf_C.same_name_socket(:from_up,mix=true,indata,nil,belong_to_module) unless indata.is_a? String
        outdata = DataInf_C.same_name_socket(:to_down,mix=true,outdata,nil,belong_to_module) unless outdata.is_a? String
        
        if up_stream.nil? && indata.eql?("indata") && (!(outdata.eql?("outdata")) || !down_stream.nil?)
            # up_stream = self.copy(name:"indata")
            # return_stream = up_stream
            outdata = down_stream if down_stream
            return down_stream.data_inf_c_pipe_condition(indata:self)
        end

        indata = up_stream if up_stream
        unless self.eql? belong_to_module.DataInf_C_NC
            outdata = self
        else
            if down_stream
                outdata = down_stream
            end
        end


        belong_to_module.DataInf_C_draw << data_inf_c_pipe_condition_draw(
            and_condition:and_condition,
            indata:indata,
            outdata:outdata,
            up_stream:up_stream,
            down_stream:down_stream)
        return return_stream
    end

    private

    def data_inf_c_pipe_condition_draw(
        and_condition:"and_condition",
        indata:"indata",
        outdata:"outdata",
        up_stream:nil,
        down_stream:nil
    )

        large_name_len(
            and_condition,
            indata,
            outdata
        )
        instance_name = "data_inf_c_pipe_condition_#{signal}_inst"
"
// FilePath:::../../axi/data_interface/data_inf_c/data_inf_c_pipe_condition.sv
data_inf_c_pipe_condition #{instance_name}(
/*  input            */ .and_condition (#{align_signal(and_condition,q_mark=false)}),
/*  data_inf_c.slaver*/ .indata        (#{align_signal(indata,q_mark=false)}),
/*  data_inf_c.master*/ .outdata       (#{align_signal(outdata,q_mark=false)})
);
"
    end
    
    public

    def self.data_inf_c_pipe_condition(
        and_condition:"and_condition",
        indata:"indata",
        outdata:"outdata",
        up_stream:nil,
        down_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [indata,outdata].first.belong_to_module unless belong_to_module
        
        if down_stream.nil? && outdata.eql?("outdata")
            if up_stream.is_a? DataInf_C
                down_stream = up_stream.copy
            else
                down_stream = indata.copy
            end
            return_stream = down_stream
        end

        
        if up_stream.nil? && indata.eql?("indata")
            if down_stream.is_a? DataInf_C
                up_stream = down_stream.copy
            else
                up_stream = outdata.copy
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? DataInf_C
            down_stream.data_inf_c_pipe_condition(
                and_condition:and_condition,
                indata:indata,
                outdata:outdata,
                up_stream:up_stream,
                down_stream:down_stream)
        elsif outdata.is_a? DataInf_C
            outdata.data_inf_c_pipe_condition(
                and_condition:and_condition,
                indata:indata,
                outdata:outdata,
                up_stream:up_stream,
                down_stream:down_stream)
        else
            belong_to_module.DataInf_C_NC.data_inf_c_pipe_condition(
                and_condition:and_condition,
                indata:indata,
                outdata:outdata,
                up_stream:up_stream,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

