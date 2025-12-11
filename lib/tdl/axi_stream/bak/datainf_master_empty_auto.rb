
#2017-07-27 16:22:37 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class DataInf


    def datainf_master_empty(master:"master",down_stream:nil)
        return_stream = self
        
        
        master = self

        $_draw = lambda { datainf_master_empty_draw(master:master,down_stream:down_stream) }
        @correlation_proc += $_draw.call
        return return_stream
    end

    def datainf_master_empty_draw(master:"master",down_stream:nil)
        large_name_len(master)
"
datainf_master_empty datainf_master_empty_#{signal}_inst(
/*  data_inf.master*/ .master (#{align_signal(master,q_mark=false)})
);
"
    end
    
    def self.datainf_master_empty(master:"master",down_stream:nil)
        return_stream = nil
        
        
        
        if down_stream.is_a? DataInf
            down_stream.datainf_master_empty(master:master,down_stream:down_stream)
        elsif master.is_a? DataInf
            master.datainf_master_empty(master:master,down_stream:down_stream)
        else
            NC.datainf_master_empty(master:master,down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_datainf_master_empty
        c0 = Clock.new(name:"datainf_master_empty_clk",freqM:148.5)
        r0 = Reset.new(name:"datainf_master_empty_rst_n",active:"low")

        DataInf.new(name:"master",clock:c0,reset:r0)
        
        down_stream = master
        DataInf.datainf_master_empty(master:master)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_datainf_master_empty(master:"master")
        hash = TdlHash.new
        
        unless master.is_a? Hash
            # hash.new_index(:master) = master
            if master.is_a? BaseElm
                hash.[]=(:master,master,true)
            else
                hash.[]=(:master,master,false)
            end
        else
            # hash.new_index(:master)= lambda { a = DataInf.new(master);a.name = "master";return a }
            # hash[:master] = lambda { a = DataInf.new(master);a.name = "master";return a }
            lam = lambda {
                a = DataInf.new(master)
                unless master[:name]
                    a.name = "master"
                end
                return a }
            hash.[]=(:master,lam,false)
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
            hash.check_use("datainf_master_empty")
            DataInf.datainf_master_empty(hash)
        }
        return hash
    end
end
