
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class Axi4


    def _axi4_combin_wr_rd_batch(
        wr_slaver:"wr_slaver",
        rd_slaver:"rd_slaver",
        master:"master"
    )

        Tdl.add_to_all_file_paths('axi4_combin_wr_rd_batch','../../axi/AXI4/axi4_combin_wr_rd_batch.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axi4_combin_wr_rd_batch','../../axi/AXI4/axi4_combin_wr_rd_batch.sv'])
        return_stream = self
        
        wr_slaver = Axi4.same_name_socket(:mirror,mix=true,wr_slaver,nil,belong_to_module) unless wr_slaver.is_a? String
        rd_slaver = Axi4.same_name_socket(:mirror,mix=true,rd_slaver,nil,belong_to_module) unless rd_slaver.is_a? String
        master = Axi4.same_name_socket(:to_down,mix=true,master,nil,belong_to_module) unless master.is_a? String
        
        
        


        belong_to_module.Axi4_draw << _axi4_combin_wr_rd_batch_draw(
            wr_slaver:wr_slaver,
            rd_slaver:rd_slaver,
            master:master)
        return return_stream
    end

    private

    def _axi4_combin_wr_rd_batch_draw(
        wr_slaver:"wr_slaver",
        rd_slaver:"rd_slaver",
        master:"master"
    )

        large_name_len(
            wr_slaver,
            rd_slaver,
            master
        )
        instance_name = "axi4_combin_wr_rd_batch_#{signal}_inst"
"
// FilePath:::../../axi/AXI4/axi4_combin_wr_rd_batch.sv
axi4_combin_wr_rd_batch #{instance_name}(
/*  axi_inf.slaver_wr*/ .wr_slaver (#{align_signal(wr_slaver,q_mark=false)}),
/*  axi_inf.slaver_rd*/ .rd_slaver (#{align_signal(rd_slaver,q_mark=false)}),
/*  axi_inf.master   */ .master    (#{align_signal(master,q_mark=false)})
);
"
    end
    
    public

    def self.axi4_combin_wr_rd_batch(
        wr_slaver:"wr_slaver",
        rd_slaver:"rd_slaver",
        master:"master",
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [wr_slaver,rd_slaver,master].first.belong_to_module unless belong_to_module
        
        
        belong_to_module.Axi4_NC._axi4_combin_wr_rd_batch(
            wr_slaver:wr_slaver,
            rd_slaver:rd_slaver,
            master:master)
        return return_stream
    end
        

end

