
#2017-07-27 16:22:37 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class DataInf_C


    def _part_data_pair_map(num:8,isize:8,osize:8,write_inf:"write_inf",ipart_inf:"ipart_inf",opart_inf:"opart_inf",idel_inf:"idel_inf",odel_inf:"odel_inf",oipart_inf:"oipart_inf",oopart_inf:"oopart_inf",ierr_inf:"ierr_inf",oerr_inf:"oerr_inf")
        return_stream = self
        
        
        

        $_draw = lambda { _part_data_pair_map_draw(num:num,isize:isize,osize:osize,write_inf:write_inf,ipart_inf:ipart_inf,opart_inf:opart_inf,idel_inf:idel_inf,odel_inf:odel_inf,oipart_inf:oipart_inf,oopart_inf:oopart_inf,ierr_inf:ierr_inf,oerr_inf:oerr_inf) }
        @correlation_proc += $_draw.call
        return return_stream
    end

    def _part_data_pair_map_draw(num:8,isize:8,osize:8,write_inf:"write_inf",ipart_inf:"ipart_inf",opart_inf:"opart_inf",idel_inf:"idel_inf",odel_inf:"odel_inf",oipart_inf:"oipart_inf",oopart_inf:"oopart_inf",ierr_inf:"ierr_inf",oerr_inf:"oerr_inf")
        large_name_len(num,isize,osize,write_inf,ipart_inf,opart_inf,idel_inf,odel_inf,oipart_inf,oopart_inf,ierr_inf,oerr_inf)
"
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
        
        
        NC._part_data_pair_map(num:num,isize:isize,osize:osize,write_inf:write_inf,ipart_inf:ipart_inf,opart_inf:opart_inf,idel_inf:idel_inf,odel_inf:odel_inf,oipart_inf:oipart_inf,oopart_inf:oopart_inf,ierr_inf:ierr_inf,oerr_inf:oerr_inf)
        return return_stream
    end
        

end


class TdlTest

    def self.test_part_data_pair_map
        c0 = Clock.new(name:"part_data_pair_map_clk",freqM:148.5)
        r0 = Reset.new(name:"part_data_pair_map_rst_n",active:"low")

        Parameter.new(name:"num",value:8)
        Parameter.new(name:"isize",value:8)
        Parameter.new(name:"osize",value:8)
        DataInf_C.new(name:"write_inf",clock:c0,reset:r0)
        DataInf_C.new(name:"ipart_inf",clock:c0,reset:r0)
        DataInf_C.new(name:"opart_inf",clock:c0,reset:r0)
        DataInf_C.new(name:"idel_inf",clock:c0,reset:r0)
        DataInf_C.new(name:"odel_inf",clock:c0,reset:r0)
        DataInf_C.new(name:"Oipart_inf",clock:c0,reset:r0)
        DataInf_C.new(name:"Oopart_inf",clock:c0,reset:r0)
        DataInf_C.new(name:"ierr_inf",clock:c0,reset:r0)
        DataInf_C.new(name:"oerr_inf",clock:c0,reset:r0)
        
        
        DataInf_C.part_data_pair_map(num:num,isize:isize,osize:osize,write_inf:write_inf,ipart_inf:ipart_inf,opart_inf:opart_inf,idel_inf:idel_inf,odel_inf:odel_inf,oipart_inf:oipart_inf,oopart_inf:oopart_inf,ierr_inf:ierr_inf,oerr_inf:oerr_inf)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_part_data_pair_map(num:8,
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
            # hash.new_index(:num) = num
            if num.is_a? BaseElm
                hash.[]=(:num,num,true)
            else
                hash.[]=(:num,num,false)
            end
        else
            # hash.new_index(:num)= lambda { a = Parameter.new(num);a.name = "num";return a }
            # hash[:num] = lambda { a = Parameter.new(num);a.name = "num";return a }
            lam = lambda {
                a = Parameter.new(num)
                unless num[:name]
                    a.name = "num"
                end
                return a }
            hash.[]=(:num,lam,false)
        end
                

        unless isize.is_a? Hash
            # hash.new_index(:isize) = isize
            if isize.is_a? BaseElm
                hash.[]=(:isize,isize,true)
            else
                hash.[]=(:isize,isize,false)
            end
        else
            # hash.new_index(:isize)= lambda { a = Parameter.new(isize);a.name = "isize";return a }
            # hash[:isize] = lambda { a = Parameter.new(isize);a.name = "isize";return a }
            lam = lambda {
                a = Parameter.new(isize)
                unless isize[:name]
                    a.name = "isize"
                end
                return a }
            hash.[]=(:isize,lam,false)
        end
                

        unless osize.is_a? Hash
            # hash.new_index(:osize) = osize
            if osize.is_a? BaseElm
                hash.[]=(:osize,osize,true)
            else
                hash.[]=(:osize,osize,false)
            end
        else
            # hash.new_index(:osize)= lambda { a = Parameter.new(osize);a.name = "osize";return a }
            # hash[:osize] = lambda { a = Parameter.new(osize);a.name = "osize";return a }
            lam = lambda {
                a = Parameter.new(osize)
                unless osize[:name]
                    a.name = "osize"
                end
                return a }
            hash.[]=(:osize,lam,false)
        end
                

        unless write_inf.is_a? Hash
            # hash.new_index(:write_inf) = write_inf
            if write_inf.is_a? BaseElm
                hash.[]=(:write_inf,write_inf,true)
            else
                hash.[]=(:write_inf,write_inf,false)
            end
        else
            # hash.new_index(:write_inf)= lambda { a = DataInf_C.new(write_inf);a.name = "write_inf";return a }
            # hash[:write_inf] = lambda { a = DataInf_C.new(write_inf);a.name = "write_inf";return a }
            lam = lambda {
                a = DataInf_C.new(write_inf)
                unless write_inf[:name]
                    a.name = "write_inf"
                end
                return a }
            hash.[]=(:write_inf,lam,false)
        end
                

        unless ipart_inf.is_a? Hash
            # hash.new_index(:ipart_inf) = ipart_inf
            if ipart_inf.is_a? BaseElm
                hash.[]=(:ipart_inf,ipart_inf,true)
            else
                hash.[]=(:ipart_inf,ipart_inf,false)
            end
        else
            # hash.new_index(:ipart_inf)= lambda { a = DataInf_C.new(ipart_inf);a.name = "ipart_inf";return a }
            # hash[:ipart_inf] = lambda { a = DataInf_C.new(ipart_inf);a.name = "ipart_inf";return a }
            lam = lambda {
                a = DataInf_C.new(ipart_inf)
                unless ipart_inf[:name]
                    a.name = "ipart_inf"
                end
                return a }
            hash.[]=(:ipart_inf,lam,false)
        end
                

        unless opart_inf.is_a? Hash
            # hash.new_index(:opart_inf) = opart_inf
            if opart_inf.is_a? BaseElm
                hash.[]=(:opart_inf,opart_inf,true)
            else
                hash.[]=(:opart_inf,opart_inf,false)
            end
        else
            # hash.new_index(:opart_inf)= lambda { a = DataInf_C.new(opart_inf);a.name = "opart_inf";return a }
            # hash[:opart_inf] = lambda { a = DataInf_C.new(opart_inf);a.name = "opart_inf";return a }
            lam = lambda {
                a = DataInf_C.new(opart_inf)
                unless opart_inf[:name]
                    a.name = "opart_inf"
                end
                return a }
            hash.[]=(:opart_inf,lam,false)
        end
                

        unless idel_inf.is_a? Hash
            # hash.new_index(:idel_inf) = idel_inf
            if idel_inf.is_a? BaseElm
                hash.[]=(:idel_inf,idel_inf,true)
            else
                hash.[]=(:idel_inf,idel_inf,false)
            end
        else
            # hash.new_index(:idel_inf)= lambda { a = DataInf_C.new(idel_inf);a.name = "idel_inf";return a }
            # hash[:idel_inf] = lambda { a = DataInf_C.new(idel_inf);a.name = "idel_inf";return a }
            lam = lambda {
                a = DataInf_C.new(idel_inf)
                unless idel_inf[:name]
                    a.name = "idel_inf"
                end
                return a }
            hash.[]=(:idel_inf,lam,false)
        end
                

        unless odel_inf.is_a? Hash
            # hash.new_index(:odel_inf) = odel_inf
            if odel_inf.is_a? BaseElm
                hash.[]=(:odel_inf,odel_inf,true)
            else
                hash.[]=(:odel_inf,odel_inf,false)
            end
        else
            # hash.new_index(:odel_inf)= lambda { a = DataInf_C.new(odel_inf);a.name = "odel_inf";return a }
            # hash[:odel_inf] = lambda { a = DataInf_C.new(odel_inf);a.name = "odel_inf";return a }
            lam = lambda {
                a = DataInf_C.new(odel_inf)
                unless odel_inf[:name]
                    a.name = "odel_inf"
                end
                return a }
            hash.[]=(:odel_inf,lam,false)
        end
                

        unless oipart_inf.is_a? Hash
            # hash.new_index(:oipart_inf) = oipart_inf
            if oipart_inf.is_a? BaseElm
                hash.[]=(:oipart_inf,oipart_inf,true)
            else
                hash.[]=(:oipart_inf,oipart_inf,false)
            end
        else
            # hash.new_index(:oipart_inf)= lambda { a = DataInf_C.new(oipart_inf);a.name = "oipart_inf";return a }
            # hash[:oipart_inf] = lambda { a = DataInf_C.new(oipart_inf);a.name = "oipart_inf";return a }
            lam = lambda {
                a = DataInf_C.new(oipart_inf)
                unless oipart_inf[:name]
                    a.name = "oipart_inf"
                end
                return a }
            hash.[]=(:oipart_inf,lam,false)
        end
                

        unless oopart_inf.is_a? Hash
            # hash.new_index(:oopart_inf) = oopart_inf
            if oopart_inf.is_a? BaseElm
                hash.[]=(:oopart_inf,oopart_inf,true)
            else
                hash.[]=(:oopart_inf,oopart_inf,false)
            end
        else
            # hash.new_index(:oopart_inf)= lambda { a = DataInf_C.new(oopart_inf);a.name = "oopart_inf";return a }
            # hash[:oopart_inf] = lambda { a = DataInf_C.new(oopart_inf);a.name = "oopart_inf";return a }
            lam = lambda {
                a = DataInf_C.new(oopart_inf)
                unless oopart_inf[:name]
                    a.name = "oopart_inf"
                end
                return a }
            hash.[]=(:oopart_inf,lam,false)
        end
                

        unless ierr_inf.is_a? Hash
            # hash.new_index(:ierr_inf) = ierr_inf
            if ierr_inf.is_a? BaseElm
                hash.[]=(:ierr_inf,ierr_inf,true)
            else
                hash.[]=(:ierr_inf,ierr_inf,false)
            end
        else
            # hash.new_index(:ierr_inf)= lambda { a = DataInf_C.new(ierr_inf);a.name = "ierr_inf";return a }
            # hash[:ierr_inf] = lambda { a = DataInf_C.new(ierr_inf);a.name = "ierr_inf";return a }
            lam = lambda {
                a = DataInf_C.new(ierr_inf)
                unless ierr_inf[:name]
                    a.name = "ierr_inf"
                end
                return a }
            hash.[]=(:ierr_inf,lam,false)
        end
                

        unless oerr_inf.is_a? Hash
            # hash.new_index(:oerr_inf) = oerr_inf
            if oerr_inf.is_a? BaseElm
                hash.[]=(:oerr_inf,oerr_inf,true)
            else
                hash.[]=(:oerr_inf,oerr_inf,false)
            end
        else
            # hash.new_index(:oerr_inf)= lambda { a = DataInf_C.new(oerr_inf);a.name = "oerr_inf";return a }
            # hash[:oerr_inf] = lambda { a = DataInf_C.new(oerr_inf);a.name = "oerr_inf";return a }
            lam = lambda {
                a = DataInf_C.new(oerr_inf)
                unless oerr_inf[:name]
                    a.name = "oerr_inf"
                end
                return a }
            hash.[]=(:oerr_inf,lam,false)
        end
                

        Tdl.module_stack  << lambda {
            hash.each do |k,v|
                if v.is_a? Proc
                    hash.[]=(k,v.call,false)
                elsif v.is_a? Array
                    unless v.empty?
                        if v[0].is_a? Axi4
                            cm = v[0].copy(name:k,idsize:Math.log2(v.length).ceil+v[0].idsize)
                        else
                            cm = v[0].copy(name:k)
                        end
                        cm.<<(*v)
                        # hash[k] = cm
                        hash.[]=(k,cm)
                    else
                        hash.[]=(k,nil,false)
                    end
                else
                    # hash[k] = v
                end
            end
            hash.check_use("part_data_pair_map")
            DataInf_C.part_data_pair_map(hash)
        }
        return hash
    end
end
