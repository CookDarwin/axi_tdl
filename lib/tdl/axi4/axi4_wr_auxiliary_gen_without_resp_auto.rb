
#2018-05-04 14:40:11 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def _axi4_wr_auxiliary_gen_without_resp(
        stream_en:"stream_en",
        id_add_len_in:"id_add_len_in",
        axi_wr_aux:"axi_wr_aux"
    )

        Tdl.add_to_all_file_paths('axi4_wr_auxiliary_gen_without_resp','../../axi/AXI4/axi4_wr_auxiliary_gen_without_resp.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axi4_wr_auxiliary_gen_without_resp','../../axi/AXI4/axi4_wr_auxiliary_gen_without_resp.sv'])
        return_stream = self
        
        id_add_len_in = AxiStream.same_name_socket(:from_up,mix=true,id_add_len_in,nil,belong_to_module) unless id_add_len_in.is_a? String
        axi_wr_aux = Axi4.same_name_socket(:mirror,mix=true,axi_wr_aux,nil,belong_to_module) unless axi_wr_aux.is_a? String
        
        
        


        belong_to_module.AxiStream_draw << _axi4_wr_auxiliary_gen_without_resp_draw(
            stream_en:stream_en,
            id_add_len_in:id_add_len_in,
            axi_wr_aux:axi_wr_aux)
        return return_stream
    end

    private

    def _axi4_wr_auxiliary_gen_without_resp_draw(
        stream_en:"stream_en",
        id_add_len_in:"id_add_len_in",
        axi_wr_aux:"axi_wr_aux"
    )

        large_name_len(
            stream_en,
            id_add_len_in,
            axi_wr_aux
        )
        instance_name = "axi4_wr_auxiliary_gen_without_resp_#{signal}_inst"
"
// FilePath:::../../axi/AXI4/axi4_wr_auxiliary_gen_without_resp.sv
axi4_wr_auxiliary_gen_without_resp #{instance_name}(
/*  output                       */ .stream_en     (#{align_signal(stream_en,q_mark=false)}),
/*  axi_stream_inf.slaver        */ .id_add_len_in (#{align_signal(id_add_len_in,q_mark=false)}),
/*  axi_inf.master_wr_aux_no_resp*/ .axi_wr_aux    (#{align_signal(axi_wr_aux,q_mark=false)})
);
"
    end
    
    public

    def self.axi4_wr_auxiliary_gen_without_resp(
        stream_en:"stream_en",
        id_add_len_in:"id_add_len_in",
        axi_wr_aux:"axi_wr_aux",
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [id_add_len_in].first.belong_to_module unless belong_to_module
        
        
        belong_to_module.AxiStream_NC._axi4_wr_auxiliary_gen_without_resp(
            stream_en:stream_en,
            id_add_len_in:id_add_len_in,
            axi_wr_aux:axi_wr_aux)
        return return_stream
    end
        

end

