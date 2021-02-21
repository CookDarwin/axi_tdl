
#2018-05-04 14:40:11 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class DataInf_C


    def data_c_pipe_inf(
        slaver:"slaver",
        master:"master",
        up_stream:nil,
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('data_c_pipe_inf','../../axi/data_interface/data_inf_c/data_c_pipe_inf.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['data_c_pipe_inf','../../axi/data_interface/data_inf_c/data_c_pipe_inf.sv'])
        return_stream = self
        
        slaver = DataInf_C.same_name_socket(:from_up,mix=true,slaver,nil,belong_to_module) unless slaver.is_a? String
        master = DataInf_C.same_name_socket(:to_down,mix=true,master,nil,belong_to_module) unless master.is_a? String
        
        if up_stream.nil? && slaver.eql?("slaver") && (!(master.eql?("master")) || !down_stream.nil?)
            # up_stream = self.copy(name:"slaver")
            # return_stream = up_stream
            master = down_stream if down_stream
            return down_stream.data_c_pipe_inf(slaver:self)
        end

        slaver = up_stream if up_stream
        unless self.eql? belong_to_module.DataInf_C_NC
            master = self
        else
            if down_stream
                master = down_stream
            end
        end


        belong_to_module.DataInf_C_draw << data_c_pipe_inf_draw(
            slaver:slaver,
            master:master,
            up_stream:up_stream,
            down_stream:down_stream)
        return return_stream
    end

    private

    def data_c_pipe_inf_draw(
        slaver:"slaver",
        master:"master",
        up_stream:nil,
        down_stream:nil
    )

        large_name_len(
            slaver,
            master
        )
        instance_name = "data_c_pipe_inf_#{signal}_inst"
"
// FilePath:::../../axi/data_interface/data_inf_c/data_c_pipe_inf.sv
data_c_pipe_inf #{instance_name}(
/*  data_inf_c.slaver*/ .slaver (#{align_signal(slaver,q_mark=false)}),
/*  data_inf_c.master*/ .master (#{align_signal(master,q_mark=false)})
);
"
    end
    
    public

    def self.data_c_pipe_inf(
        slaver:"slaver",
        master:"master",
        up_stream:nil,
        down_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [slaver,master].first.belong_to_module unless belong_to_module
        
        if down_stream.nil? && master.eql?("master")
            if up_stream.is_a? DataInf_C
                down_stream = up_stream.copy
            else
                down_stream = slaver.copy
            end
            return_stream = down_stream
        end

        
        if up_stream.nil? && slaver.eql?("slaver")
            if down_stream.is_a? DataInf_C
                up_stream = down_stream.copy
            else
                up_stream = master.copy
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? DataInf_C
            down_stream.data_c_pipe_inf(
                slaver:slaver,
                master:master,
                up_stream:up_stream,
                down_stream:down_stream)
        elsif master.is_a? DataInf_C
            master.data_c_pipe_inf(
                slaver:slaver,
                master:master,
                up_stream:up_stream,
                down_stream:down_stream)
        else
            belong_to_module.DataInf_C_NC.data_c_pipe_inf(
                slaver:slaver,
                master:master,
                up_stream:up_stream,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

