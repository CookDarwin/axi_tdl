
#2018-05-04 14:40:11 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class DataInf_C


    def data_connect_pipe_inf(
        indata:"indata",
        outdata:"outdata",
        up_stream:nil,
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('data_connect_pipe_inf','../../axi/data_interface/data_inf_c/data_connect_pipe_inf.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['data_connect_pipe_inf','../../axi/data_interface/data_inf_c/data_connect_pipe_inf.sv'])
        return_stream = self
        
        indata = DataInf_C.same_name_socket(:from_up,mix=true,indata,nil,belong_to_module) unless indata.is_a? String
        outdata = DataInf_C.same_name_socket(:to_down,mix=true,outdata,nil,belong_to_module) unless outdata.is_a? String
        
        if up_stream.nil? && indata.eql?("indata") && (!(outdata.eql?("outdata")) || !down_stream.nil?)
            # up_stream = self.copy(name:"indata")
            # return_stream = up_stream
            outdata = down_stream if down_stream
            return down_stream.data_connect_pipe_inf(indata:self)
        end

        indata = up_stream if up_stream
        unless self.eql? belong_to_module.DataInf_C_NC
            outdata = self
        else
            if down_stream
                outdata = down_stream
            end
        end


        belong_to_module.DataInf_C_draw << data_connect_pipe_inf_draw(
            indata:indata,
            outdata:outdata,
            up_stream:up_stream,
            down_stream:down_stream)
        return return_stream
    end

    private

    def data_connect_pipe_inf_draw(
        indata:"indata",
        outdata:"outdata",
        up_stream:nil,
        down_stream:nil
    )

        large_name_len(
            indata,
            outdata
        )
        instance_name = "data_connect_pipe_inf_#{signal}_inst"
"
// FilePath:::../../axi/data_interface/data_inf_c/data_connect_pipe_inf.sv
data_connect_pipe_inf #{instance_name}(
/*  data_inf_c.slaver*/ .indata  (#{align_signal(indata,q_mark=false)}),
/*  data_inf_c.master*/ .outdata (#{align_signal(outdata,q_mark=false)})
);
"
    end
    
    public

    def self.data_connect_pipe_inf(
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
            down_stream.data_connect_pipe_inf(
                indata:indata,
                outdata:outdata,
                up_stream:up_stream,
                down_stream:down_stream)
        elsif outdata.is_a? DataInf_C
            outdata.data_connect_pipe_inf(
                indata:indata,
                outdata:outdata,
                up_stream:up_stream,
                down_stream:down_stream)
        else
            belong_to_module.DataInf_C_NC.data_connect_pipe_inf(
                indata:indata,
                outdata:outdata,
                up_stream:up_stream,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

