
#2018-05-04 14:40:11 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class DataInf_C


    def _part_data_pair_map(
        num:8,
        isize:8,
        osize:8,
        write_inf:"write_inf",
        ipart_inf:"ipart_inf",
        opart_inf:"opart_inf",
        idel_inf:"idel_inf",
        odel_inf:"odel_inf",
        oipart_inf:"oipart_inf",
        oopart_inf:"oopart_inf",
        ierr_inf:"ierr_inf",
        oerr_inf:"oerr_inf"
    )

        Tdl.add_to_all_file_paths('part_data_pair_map','../../axi/data_interface/part_data_pair_map.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['part_data_pair_map','../../axi/data_interface/part_data_pair_map.sv'])
        return_stream = self
        
        write_inf = DataInf_C.same_name_socket(:from_up,mix=true,write_inf,nil,belong_to_module) unless write_inf.is_a? String
        ipart_inf = DataInf_C.same_name_socket(:from_up,mix=true,ipart_inf,nil,belong_to_module) unless ipart_inf.is_a? String
        opart_inf = DataInf_C.same_name_socket(:from_up,mix=true,opart_inf,nil,belong_to_module) unless opart_inf.is_a? String
        idel_inf = DataInf_C.same_name_socket(:from_up,mix=true,idel_inf,nil,belong_to_module) unless idel_inf.is_a? String
        odel_inf = DataInf_C.same_name_socket(:from_up,mix=true,odel_inf,nil,belong_to_module) unless odel_inf.is_a? String
        oipart_inf = DataInf_C.same_name_socket(:to_down,mix=true,oipart_inf,nil,belong_to_module) unless oipart_inf.is_a? String
        oopart_inf = DataInf_C.same_name_socket(:to_down,mix=true,oopart_inf,nil,belong_to_module) unless oopart_inf.is_a? String
        ierr_inf = DataInf_C.same_name_socket(:to_down,mix=true,ierr_inf,nil,belong_to_module) unless ierr_inf.is_a? String
        oerr_inf = DataInf_C.same_name_socket(:to_down,mix=true,oerr_inf,nil,belong_to_module) unless oerr_inf.is_a? String
        
        
        


        belong_to_module.DataInf_C_draw << _part_data_pair_map_draw(
            num:num,
            isize:isize,
            osize:osize,
            write_inf:write_inf,
            ipart_inf:ipart_inf,
            opart_inf:opart_inf,
            idel_inf:idel_inf,
            odel_inf:odel_inf,
            oipart_inf:oipart_inf,
            oopart_inf:oopart_inf,
            ierr_inf:ierr_inf,
            oerr_inf:oerr_inf)
        return return_stream
    end

    private

    def _part_data_pair_map_draw(
        num:8,
        isize:8,
        osize:8,
        write_inf:"write_inf",
        ipart_inf:"ipart_inf",
        opart_inf:"opart_inf",
        idel_inf:"idel_inf",
        odel_inf:"odel_inf",
        oipart_inf:"oipart_inf",
        oopart_inf:"oopart_inf",
        ierr_inf:"ierr_inf",
        oerr_inf:"oerr_inf"
    )

        large_name_len(
            num,
            isize,
            osize,
            write_inf,
            ipart_inf,
            opart_inf,
            idel_inf,
            odel_inf,
            oipart_inf,
            oopart_inf,
            ierr_inf,
            oerr_inf
        )
        instance_name = "part_data_pair_map_#{signal}_inst"
"
// FilePath:::../../axi/data_interface/part_data_pair_map.sv
part_data_pair_map#(
    .NUM      (#{align_signal(num)}),
    .ISIZE    (#{align_signal(isize)}),
    .OSIZE    (#{align_signal(osize)})
) #{instance_name}(
/*  data_inf_c.slaver*/ .write_inf  (#{align_signal(write_inf,q_mark=false)}),
/*  data_inf_c.slaver*/ .ipart_inf  (#{align_signal(ipart_inf,q_mark=false)}),
/*  data_inf_c.slaver*/ .opart_inf  (#{align_signal(opart_inf,q_mark=false)}),
/*  data_inf_c.slaver*/ .idel_inf   (#{align_signal(idel_inf,q_mark=false)}),
/*  data_inf_c.slaver*/ .odel_inf   (#{align_signal(odel_inf,q_mark=false)}),
/*  data_inf_c.master*/ .Oipart_inf (#{align_signal(oipart_inf,q_mark=false)}),
/*  data_inf_c.master*/ .Oopart_inf (#{align_signal(oopart_inf,q_mark=false)}),
/*  data_inf_c.master*/ .ierr_inf   (#{align_signal(ierr_inf,q_mark=false)}),
/*  data_inf_c.master*/ .oerr_inf   (#{align_signal(oerr_inf,q_mark=false)})
);
"
    end
    
    public

    def self.part_data_pair_map(
        num:8,
        isize:8,
        osize:8,
        write_inf:"write_inf",
        ipart_inf:"ipart_inf",
        opart_inf:"opart_inf",
        idel_inf:"idel_inf",
        odel_inf:"odel_inf",
        oipart_inf:"oipart_inf",
        oopart_inf:"oopart_inf",
        ierr_inf:"ierr_inf",
        oerr_inf:"oerr_inf",
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [write_inf,ipart_inf,opart_inf,idel_inf,odel_inf,oipart_inf,oopart_inf,ierr_inf,oerr_inf].first.belong_to_module unless belong_to_module
        
        
        belong_to_module.DataInf_C_NC._part_data_pair_map(
            num:num,
            isize:isize,
            osize:osize,
            write_inf:write_inf,
            ipart_inf:ipart_inf,
            opart_inf:opart_inf,
            idel_inf:idel_inf,
            odel_inf:odel_inf,
            oipart_inf:oipart_inf,
            oopart_inf:oopart_inf,
            ierr_inf:ierr_inf,
            oerr_inf:oerr_inf)
        return return_stream
    end
        

end

