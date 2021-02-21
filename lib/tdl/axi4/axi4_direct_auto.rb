
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class Axi4


    def _axi4_direct(
        mode:"BOTH_to_BOTH",
        slaver:"slaver",
        master:"master"
    )

        Tdl.add_to_all_file_paths('axi4_direct','../../axi/AXI4/axi4_direct.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axi4_direct','../../axi/AXI4/axi4_direct.sv'])
        return_stream = self
        
        slaver = Axi4.same_name_socket(:from_up,mix=true,slaver,nil,belong_to_module) unless slaver.is_a? String
        master = Axi4.same_name_socket(:to_down,mix=true,master,nil,belong_to_module) unless master.is_a? String
        
        
        


        belong_to_module.Axi4_draw << _axi4_direct_draw(
            mode:mode,
            slaver:slaver,
            master:master)
        return return_stream
    end

    private

    def _axi4_direct_draw(
        mode:"BOTH_to_BOTH",
        slaver:"slaver",
        master:"master"
    )

        large_name_len(
            mode,
            slaver,
            master
        )
        instance_name = "axi4_direct_#{signal}_inst"
"
// FilePath:::../../axi/AXI4/axi4_direct.sv
axi4_direct#(
    .MODE    (#{align_signal(mode)})
) #{instance_name}(
/*  axi_inf.slaver*/ .slaver (#{align_signal(slaver,q_mark=false)}),
/*  axi_inf.master*/ .master (#{align_signal(master,q_mark=false)})
);
"
    end
    
    public

    def self.axi4_direct(
        mode:"BOTH_to_BOTH",
        slaver:"slaver",
        master:"master",
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [slaver,master].first.belong_to_module unless belong_to_module
        
        
        belong_to_module.Axi4_NC._axi4_direct(
            mode:mode,
            slaver:slaver,
            master:master)
        return return_stream
    end
        

end

