
#2018-05-04 14:40:11 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class Axi4


    def axi4_direct_a1(
        mode:"BOTH_to_BOTH",
        slaver:"slaver",
        master:"master",
        up_stream:nil,
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('axi4_direct_a1','../../axi/AXI4/axi4_direct_A1.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axi4_direct_a1','../../axi/AXI4/axi4_direct_A1.sv'])
        return_stream = self
        
        slaver = Axi4.same_name_socket(:from_up,mix=true,slaver,nil,belong_to_module) unless slaver.is_a? String
        master = Axi4.same_name_socket(:to_down,mix=true,master,nil,belong_to_module) unless master.is_a? String
        
        if up_stream.nil? && slaver.eql?("slaver") && (!(master.eql?("master")) || !down_stream.nil?)
            # up_stream = self.copy(name:"slaver")
            # return_stream = up_stream
            master = down_stream if down_stream
            return down_stream.axi4_direct_a1(slaver:self)
        end

        slaver = up_stream if up_stream
        unless self.eql? belong_to_module.Axi4_NC
            master = self
        else
            if down_stream
                master = down_stream
            end
        end


        belong_to_module.Axi4_draw << axi4_direct_a1_draw(
            mode:mode,
            slaver:slaver,
            master:master,
            up_stream:up_stream,
            down_stream:down_stream)
        return return_stream
    end

    private

    def axi4_direct_a1_draw(
        mode:"BOTH_to_BOTH",
        slaver:"slaver",
        master:"master",
        up_stream:nil,
        down_stream:nil
    )

        large_name_len(
            mode,
            slaver,
            master
        )
        instance_name = "axi4_direct_A1_#{signal}_inst"
"
// FilePath:::../../axi/AXI4/axi4_direct_A1.sv
axi4_direct_A1#(
    .MODE    (#{align_signal(mode)})
) #{instance_name}(
/*  axi_inf.slaver*/ .slaver (#{align_signal(slaver,q_mark=false)}),
/*  axi_inf.master*/ .master (#{align_signal(master,q_mark=false)})
);
"
    end
    
    public

    def self.axi4_direct_a1(
        mode:"BOTH_to_BOTH",
        slaver:"slaver",
        master:"master",
        up_stream:nil,
        down_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [slaver,master].first.belong_to_module unless belong_to_module
        
        if down_stream.nil? && master.eql?("master")
            if up_stream.is_a? Axi4
                down_stream = up_stream.copy
            else
                down_stream = slaver.copy
            end
            return_stream = down_stream
        end

        
        if up_stream.nil? && slaver.eql?("slaver")
            if down_stream.is_a? Axi4
                up_stream = down_stream.copy
            else
                up_stream = master.copy
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? Axi4
            down_stream.axi4_direct_a1(
                mode:mode,
                slaver:slaver,
                master:master,
                up_stream:up_stream,
                down_stream:down_stream)
        elsif master.is_a? Axi4
            master.axi4_direct_a1(
                mode:mode,
                slaver:slaver,
                master:master,
                up_stream:up_stream,
                down_stream:down_stream)
        else
            belong_to_module.Axi4_NC.axi4_direct_a1(
                mode:mode,
                slaver:slaver,
                master:master,
                up_stream:up_stream,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

