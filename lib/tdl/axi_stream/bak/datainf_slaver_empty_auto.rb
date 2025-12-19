
#2017-07-27 16:22:37 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class DataInf


    def _datainf_slaver_empty(slaver:"slaver",up_stream:nil)
        return_stream = self
        
        slaver = up_stream if up_stream
        

        $_draw = lambda { _datainf_slaver_empty_draw(slaver:slaver,up_stream:up_stream) }
        @correlation_proc += $_draw.call
        return return_stream
    end

    def _datainf_slaver_empty_draw(slaver:"slaver",up_stream:nil)
        large_name_len(slaver)
"
datainf_slaver_empty datainf_slaver_empty_#{signal}_inst(
/*  data_inf.slaver*/ .slaver (#{align_signal(slaver,q_mark=false)})
);
"
    end
    
    def self.datainf_slaver_empty(slaver:"slaver",up_stream:nil)
        return_stream = nil
        
        
        NC._datainf_slaver_empty(slaver:slaver,up_stream:up_stream)
        return return_stream
    end
        

end


class TdlTest

    def self.test_datainf_slaver_empty
        c0 = Clock.new(name:"datainf_slaver_empty_clk",freqM:148.5)
        r0 = Reset.new(name:"datainf_slaver_empty_rst_n",active:"low")

        DataInf.new(name:"slaver",clock:c0,reset:r0)
        up_stream = slaver
        
        DataInf.datainf_slaver_empty(slaver:slaver)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_datainf_slaver_empty(slaver:"slaver")
        hash = TdlHash.new
        
        unless slaver.is_a? Hash
            # hash.new_index(:slaver) = slaver
            if slaver.is_a? BaseElm
                hash.[]=(:slaver,slaver,true)
            else
                hash.[]=(:slaver,slaver,false)
            end
        else
            # hash.new_index(:slaver)= lambda { a = DataInf.new(slaver);a.name = "slaver";return a }
            # hash[:slaver] = lambda { a = DataInf.new(slaver);a.name = "slaver";return a }
            lam = lambda {
                a = DataInf.new(slaver)
                unless slaver[:name]
                    a.name = "slaver"
                end
                return a }
            hash.[]=(:slaver,lam,false)
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
            hash.check_use("datainf_slaver_empty")
            DataInf.datainf_slaver_empty(hash)
        }
        return hash
    end
end
