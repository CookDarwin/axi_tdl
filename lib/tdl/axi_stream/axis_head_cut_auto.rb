
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def axis_head_cut(
        len:1,
        slaver:"slaver",
        master:"master",
        up_stream:nil,
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('axis_head_cut','../../axi/AXI_stream/axis_head_cut.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axis_head_cut','../../axi/AXI_stream/axis_head_cut.sv'])
        return_stream = self
        
        slaver = AxiStream.same_name_socket(:from_up,mix=true,slaver,nil,belong_to_module) unless slaver.is_a? String
        master = AxiStream.same_name_socket(:to_down,mix=true,master,nil,belong_to_module) unless master.is_a? String
        
        if up_stream.nil? && slaver.eql?("slaver") && (!(master.eql?("master")) || !down_stream.nil?)
            # up_stream = self.copy(name:"slaver")
            # return_stream = up_stream
            master = down_stream if down_stream
            return down_stream.axis_head_cut(slaver:self)
        end

        slaver = up_stream if up_stream
        unless self.eql? belong_to_module.AxiStream_NC
            master = self
        else
            if down_stream
                master = down_stream
            end
        end


        belong_to_module.AxiStream_draw << axis_head_cut_draw(
            len:len,
            slaver:slaver,
            master:master,
            up_stream:up_stream,
            down_stream:down_stream)
        return return_stream
    end

    private

    def axis_head_cut_draw(
        len:1,
        slaver:"slaver",
        master:"master",
        up_stream:nil,
        down_stream:nil
    )

        large_name_len(
            len,
            slaver,
            master
        )
        instance_name = "axis_head_cut_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/axis_head_cut.sv
axis_head_cut#(
    .LEN    (#{align_signal(len)})
) #{instance_name}(
/*  axi_stream_inf.slaver*/ .slaver (#{align_signal(slaver,q_mark=false)}),
/*  axi_stream_inf.master*/ .master (#{align_signal(master,q_mark=false)})
);
"
    end
    
    public

    def self.axis_head_cut(
        len:1,
        slaver:"slaver",
        master:"master",
        up_stream:nil,
        down_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [slaver,master].first.belong_to_module unless belong_to_module
        
        if down_stream.nil? && master.eql?("master")
            if up_stream.is_a? AxiStream
                down_stream = up_stream.copy
            else
                down_stream = slaver.copy
            end
            return_stream = down_stream
        end

        
        if up_stream.nil? && slaver.eql?("slaver")
            if down_stream.is_a? AxiStream
                up_stream = down_stream.copy
            else
                up_stream = master.copy
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? AxiStream
            down_stream.axis_head_cut(
                len:len,
                slaver:slaver,
                master:master,
                up_stream:up_stream,
                down_stream:down_stream)
        elsif master.is_a? AxiStream
            master.axis_head_cut(
                len:len,
                slaver:slaver,
                master:master,
                up_stream:up_stream,
                down_stream:down_stream)
        else
            belong_to_module.AxiStream_NC.axis_head_cut(
                len:len,
                slaver:slaver,
                master:master,
                up_stream:up_stream,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

