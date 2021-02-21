
#2018-05-04 14:40:11 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def _axi4_rd_auxiliary_gen(
        id_add_len_in:"id_add_len_in",
        axi_rd_aux:"axi_rd_aux"
    )

        Tdl.add_to_all_file_paths('axi4_rd_auxiliary_gen','../../axi/AXI4/axi4_rd_auxiliary_gen.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axi4_rd_auxiliary_gen','../../axi/AXI4/axi4_rd_auxiliary_gen.sv'])
        return_stream = self
        
        id_add_len_in = AxiStream.same_name_socket(:from_up,mix=true,id_add_len_in,nil,belong_to_module) unless id_add_len_in.is_a? String
        axi_rd_aux = Axi4.same_name_socket(:mirror,mix=true,axi_rd_aux,nil,belong_to_module) unless axi_rd_aux.is_a? String
        
        
        


        belong_to_module.AxiStream_draw << _axi4_rd_auxiliary_gen_draw(
            id_add_len_in:id_add_len_in,
            axi_rd_aux:axi_rd_aux)
        return return_stream
    end

    private

    def _axi4_rd_auxiliary_gen_draw(
        id_add_len_in:"id_add_len_in",
        axi_rd_aux:"axi_rd_aux"
    )

        large_name_len(
            id_add_len_in,
            axi_rd_aux
        )
        instance_name = "axi4_rd_auxiliary_gen_#{signal}_inst"
"
// FilePath:::../../axi/AXI4/axi4_rd_auxiliary_gen.sv
axi4_rd_auxiliary_gen #{instance_name}(
/*  axi_stream_inf.slaver*/ .id_add_len_in (#{align_signal(id_add_len_in,q_mark=false)}),
/*  axi_inf.master_rd_aux*/ .axi_rd_aux    (#{align_signal(axi_rd_aux,q_mark=false)})
);
"
    end
    
    public

    def self.axi4_rd_auxiliary_gen(
        id_add_len_in:"id_add_len_in",
        axi_rd_aux:"axi_rd_aux",
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [id_add_len_in].first.belong_to_module unless belong_to_module
        
        
        belong_to_module.AxiStream_NC._axi4_rd_auxiliary_gen(
            id_add_len_in:id_add_len_in,
            axi_rd_aux:axi_rd_aux)
        return return_stream
    end
        

end

