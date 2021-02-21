
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class DataInf_C


    def _part_data_pair_map(num:8,isize:8,osize:8,write_inf:"write_inf",ipart_inf:"ipart_inf",opart_inf:"opart_inf",idel_inf:"idel_inf",odel_inf:"odel_inf",oipart_inf:"oipart_inf",oopart_inf:"oopart_inf",ierr_inf:"ierr_inf",oerr_inf:"oerr_inf")

        Tdl.add_to_all_file_paths(['part_data_pair_map','../../axi/data_interface/part_data_pair_map.sv'])
        return_stream = self
        
        write_inf = DataInf_C.same_name_socket(:from_up,mix=true,write_inf) unless write_inf.is_a? String
        ipart_inf = DataInf_C.same_name_socket(:from_up,mix=true,ipart_inf) unless ipart_inf.is_a? String
        opart_inf = DataInf_C.same_name_socket(:from_up,mix=true,opart_inf) unless opart_inf.is_a? String
        idel_inf = DataInf_C.same_name_socket(:from_up,mix=true,idel_inf) unless idel_inf.is_a? String
        odel_inf = DataInf_C.same_name_socket(:from_up,mix=true,odel_inf) unless odel_inf.is_a? String
        oipart_inf = DataInf_C.same_name_socket(:to_down,mix=true,oipart_inf) unless oipart_inf.is_a? String
        oopart_inf = DataInf_C.same_name_socket(:to_down,mix=true,oopart_inf) unless oopart_inf.is_a? String
        ierr_inf = DataInf_C.same_name_socket(:to_down,mix=true,ierr_inf) unless ierr_inf.is_a? String
        oerr_inf = DataInf_C.same_name_socket(:to_down,mix=true,oerr_inf) unless oerr_inf.is_a? String
        
        
        

         @instance_draw_stack << lambda { _part_data_pair_map_draw(num:num,isize:isize,osize:osize,write_inf:write_inf,ipart_inf:ipart_inf,opart_inf:opart_inf,idel_inf:idel_inf,odel_inf:odel_inf,oipart_inf:oipart_inf,oopart_inf:oopart_inf,ierr_inf:ierr_inf,oerr_inf:oerr_inf) }
        return return_stream
    end

    def _part_data_pair_map_draw(num:8,isize:8,osize:8,write_inf:"write_inf",ipart_inf:"ipart_inf",opart_inf:"opart_inf",idel_inf:"idel_inf",odel_inf:"odel_inf",oipart_inf:"oipart_inf",oopart_inf:"oopart_inf",ierr_inf:"ierr_inf",oerr_inf:"oerr_inf")

        large_name_len(num,isize,osize,write_inf,ipart_inf,opart_inf,idel_inf,odel_inf,oipart_inf,oopart_inf,ierr_inf,oerr_inf)
"
// FilePath:::../../axi/data_interface/part_data_pair_map.sv
part_data_pair_map#(
    .NUM      (#{align_signal(num)}),
    .ISIZE    (#{align_signal(isize)}),
    .OSIZE    (#{align_signal(osize)})
) part_data_pair_map_#{signal}_inst(
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
    
    def self.part_data_pair_map(num:8,isize:8,osize:8,write_inf:"write_inf",ipart_inf:"ipart_inf",opart_inf:"opart_inf",idel_inf:"idel_inf",odel_inf:"odel_inf",oipart_inf:"oipart_inf",oopart_inf:"oopart_inf",ierr_inf:"ierr_inf",oerr_inf:"oerr_inf")
        return_stream = nil
        
        
        DataInf_C.NC._part_data_pair_map(num:num,isize:isize,osize:osize,write_inf:write_inf,ipart_inf:ipart_inf,opart_inf:opart_inf,idel_inf:idel_inf,odel_inf:odel_inf,oipart_inf:oipart_inf,oopart_inf:oopart_inf,ierr_inf:ierr_inf,oerr_inf:oerr_inf)
        return return_stream
    end
        

end


class TdlTest

    def self.test_part_data_pair_map
        c0 = Clock.new(name:"part_data_pair_map_clk",freqM:148.5)
        r0 = Reset.new(name:"part_data_pair_map_rst_n",active:"low")

        num = Parameter.new(name:"num",value:8)
        isize = Parameter.new(name:"isize",value:8)
        osize = Parameter.new(name:"osize",value:8)
        write_inf = DataInf_C.new(name:"write_inf",clock:c0,reset:r0)
        ipart_inf = DataInf_C.new(name:"ipart_inf",clock:c0,reset:r0)
        opart_inf = DataInf_C.new(name:"opart_inf",clock:c0,reset:r0)
        idel_inf = DataInf_C.new(name:"idel_inf",clock:c0,reset:r0)
        odel_inf = DataInf_C.new(name:"odel_inf",clock:c0,reset:r0)
        oipart_inf = DataInf_C.new(name:"Oipart_inf",clock:c0,reset:r0)
        oopart_inf = DataInf_C.new(name:"Oopart_inf",clock:c0,reset:r0)
        ierr_inf = DataInf_C.new(name:"ierr_inf",clock:c0,reset:r0)
        oerr_inf = DataInf_C.new(name:"oerr_inf",clock:c0,reset:r0)
        
        
        DataInf_C.part_data_pair_map(num:num,isize:isize,osize:osize,write_inf:write_inf,ipart_inf:ipart_inf,opart_inf:opart_inf,idel_inf:idel_inf,odel_inf:odel_inf,oipart_inf:oipart_inf,oopart_inf:oopart_inf,ierr_inf:ierr_inf,oerr_inf:oerr_inf)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_part_data_pair_map(
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
        oerr_inf:"oerr_inf")
        hash = TdlHash.new
        
        unless num.is_a? Hash
            hash.case_record(:num,num)
        else
            # hash.new_index(:num)= lambda { a = Parameter.new(num);a.name = "num";return a }
            # hash[:num] = lambda { a = Parameter.new(num);a.name = "num";return a }
            raise TdlError.new('part_data_pair_map Parameter num TdlHash cant include Proc') if num.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(num)
                unless num[:name]
                    a.name = "num"
                end
                return a }
            hash.[]=(:num,lam,false)
        end
                

        unless isize.is_a? Hash
            hash.case_record(:isize,isize)
        else
            # hash.new_index(:isize)= lambda { a = Parameter.new(isize);a.name = "isize";return a }
            # hash[:isize] = lambda { a = Parameter.new(isize);a.name = "isize";return a }
            raise TdlError.new('part_data_pair_map Parameter isize TdlHash cant include Proc') if isize.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(isize)
                unless isize[:name]
                    a.name = "isize"
                end
                return a }
            hash.[]=(:isize,lam,false)
        end
                

        unless osize.is_a? Hash
            hash.case_record(:osize,osize)
        else
            # hash.new_index(:osize)= lambda { a = Parameter.new(osize);a.name = "osize";return a }
            # hash[:osize] = lambda { a = Parameter.new(osize);a.name = "osize";return a }
            raise TdlError.new('part_data_pair_map Parameter osize TdlHash cant include Proc') if osize.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(osize)
                unless osize[:name]
                    a.name = "osize"
                end
                return a }
            hash.[]=(:osize,lam,false)
        end
                

        unless write_inf.is_a? Hash
            hash.case_record(:write_inf,write_inf)
        else
            # hash.new_index(:write_inf)= lambda { a = DataInf_C.new(write_inf);a.name = "write_inf";return a }
            # hash[:write_inf] = lambda { a = DataInf_C.new(write_inf);a.name = "write_inf";return a }
            raise TdlError.new('part_data_pair_map DataInf_C write_inf TdlHash cant include Proc') if write_inf.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = DataInf_C.new(write_inf)
                unless write_inf[:name]
                    a.name = "write_inf"
                end
                return a }
            hash.[]=(:write_inf,lam,false)
        end
                

        unless ipart_inf.is_a? Hash
            hash.case_record(:ipart_inf,ipart_inf)
        else
            # hash.new_index(:ipart_inf)= lambda { a = DataInf_C.new(ipart_inf);a.name = "ipart_inf";return a }
            # hash[:ipart_inf] = lambda { a = DataInf_C.new(ipart_inf);a.name = "ipart_inf";return a }
            raise TdlError.new('part_data_pair_map DataInf_C ipart_inf TdlHash cant include Proc') if ipart_inf.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = DataInf_C.new(ipart_inf)
                unless ipart_inf[:name]
                    a.name = "ipart_inf"
                end
                return a }
            hash.[]=(:ipart_inf,lam,false)
        end
                

        unless opart_inf.is_a? Hash
            hash.case_record(:opart_inf,opart_inf)
        else
            # hash.new_index(:opart_inf)= lambda { a = DataInf_C.new(opart_inf);a.name = "opart_inf";return a }
            # hash[:opart_inf] = lambda { a = DataInf_C.new(opart_inf);a.name = "opart_inf";return a }
            raise TdlError.new('part_data_pair_map DataInf_C opart_inf TdlHash cant include Proc') if opart_inf.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = DataInf_C.new(opart_inf)
                unless opart_inf[:name]
                    a.name = "opart_inf"
                end
                return a }
            hash.[]=(:opart_inf,lam,false)
        end
                

        unless idel_inf.is_a? Hash
            hash.case_record(:idel_inf,idel_inf)
        else
            # hash.new_index(:idel_inf)= lambda { a = DataInf_C.new(idel_inf);a.name = "idel_inf";return a }
            # hash[:idel_inf] = lambda { a = DataInf_C.new(idel_inf);a.name = "idel_inf";return a }
            raise TdlError.new('part_data_pair_map DataInf_C idel_inf TdlHash cant include Proc') if idel_inf.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = DataInf_C.new(idel_inf)
                unless idel_inf[:name]
                    a.name = "idel_inf"
                end
                return a }
            hash.[]=(:idel_inf,lam,false)
        end
                

        unless odel_inf.is_a? Hash
            hash.case_record(:odel_inf,odel_inf)
        else
            # hash.new_index(:odel_inf)= lambda { a = DataInf_C.new(odel_inf);a.name = "odel_inf";return a }
            # hash[:odel_inf] = lambda { a = DataInf_C.new(odel_inf);a.name = "odel_inf";return a }
            raise TdlError.new('part_data_pair_map DataInf_C odel_inf TdlHash cant include Proc') if odel_inf.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = DataInf_C.new(odel_inf)
                unless odel_inf[:name]
                    a.name = "odel_inf"
                end
                return a }
            hash.[]=(:odel_inf,lam,false)
        end
                

        unless oipart_inf.is_a? Hash
            hash.case_record(:oipart_inf,oipart_inf)
        else
            # hash.new_index(:oipart_inf)= lambda { a = DataInf_C.new(oipart_inf);a.name = "oipart_inf";return a }
            # hash[:oipart_inf] = lambda { a = DataInf_C.new(oipart_inf);a.name = "oipart_inf";return a }
            raise TdlError.new('part_data_pair_map DataInf_C oipart_inf TdlHash cant include Proc') if oipart_inf.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = DataInf_C.new(oipart_inf)
                unless oipart_inf[:name]
                    a.name = "oipart_inf"
                end
                return a }
            hash.[]=(:oipart_inf,lam,false)
        end
                

        unless oopart_inf.is_a? Hash
            hash.case_record(:oopart_inf,oopart_inf)
        else
            # hash.new_index(:oopart_inf)= lambda { a = DataInf_C.new(oopart_inf);a.name = "oopart_inf";return a }
            # hash[:oopart_inf] = lambda { a = DataInf_C.new(oopart_inf);a.name = "oopart_inf";return a }
            raise TdlError.new('part_data_pair_map DataInf_C oopart_inf TdlHash cant include Proc') if oopart_inf.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = DataInf_C.new(oopart_inf)
                unless oopart_inf[:name]
                    a.name = "oopart_inf"
                end
                return a }
            hash.[]=(:oopart_inf,lam,false)
        end
                

        unless ierr_inf.is_a? Hash
            hash.case_record(:ierr_inf,ierr_inf)
        else
            # hash.new_index(:ierr_inf)= lambda { a = DataInf_C.new(ierr_inf);a.name = "ierr_inf";return a }
            # hash[:ierr_inf] = lambda { a = DataInf_C.new(ierr_inf);a.name = "ierr_inf";return a }
            raise TdlError.new('part_data_pair_map DataInf_C ierr_inf TdlHash cant include Proc') if ierr_inf.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = DataInf_C.new(ierr_inf)
                unless ierr_inf[:name]
                    a.name = "ierr_inf"
                end
                return a }
            hash.[]=(:ierr_inf,lam,false)
        end
                

        unless oerr_inf.is_a? Hash
            hash.case_record(:oerr_inf,oerr_inf)
        else
            # hash.new_index(:oerr_inf)= lambda { a = DataInf_C.new(oerr_inf);a.name = "oerr_inf";return a }
            # hash[:oerr_inf] = lambda { a = DataInf_C.new(oerr_inf);a.name = "oerr_inf";return a }
            raise TdlError.new('part_data_pair_map DataInf_C oerr_inf TdlHash cant include Proc') if oerr_inf.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = DataInf_C.new(oerr_inf)
                unless oerr_inf[:name]
                    a.name = "oerr_inf"
                end
                return a }
            hash.[]=(:oerr_inf,lam,false)
        end
                

        hash.push_to_module_stack(DataInf_C,:part_data_pair_map)
        hash.open_error = true
        return hash
    end
end
