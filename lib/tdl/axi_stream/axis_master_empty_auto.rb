
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def axis_master_empty(
        master:"master",
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('axis_master_empty','../../axi/AXI_stream/axis_master_empty.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axis_master_empty','../../axi/AXI_stream/axis_master_empty.sv'])
        return_stream = self
        
        master = AxiStream.same_name_socket(:to_down,mix=true,master,nil,belong_to_module) unless master.is_a? String
        
        
        unless self.eql? belong_to_module.AxiStream_NC
            master = self
        else
            if down_stream
                master = down_stream
            end
        end


        belong_to_module.AxiStream_draw << axis_master_empty_draw(
            master:master,
            down_stream:down_stream)
        return return_stream
    end

    private

    def axis_master_empty_draw(
        master:"master",
        down_stream:nil
    )

        large_name_len(
            master
        )
        instance_name = "axis_master_empty_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/axis_master_empty.sv
axis_master_empty #{instance_name}(
/*  axi_stream_inf.master*/ .master (#{align_signal(master,q_mark=false)})
);
"
    end
    
    public

    def self.axis_master_empty(
        master:"master",
        down_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [master].first.belong_to_module unless belong_to_module
        
        
        
        if down_stream.is_a? AxiStream
            down_stream.axis_master_empty(
                master:master,
                down_stream:down_stream)
        elsif master.is_a? AxiStream
            master.axis_master_empty(
                master:master,
                down_stream:down_stream)
        else
            belong_to_module.AxiStream_NC.axis_master_empty(
                master:master,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

