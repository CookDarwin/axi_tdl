
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class DataInf


    def _datainf_slaver_empty(slaver:"slaver",up_stream:nil)

        Tdl.add_to_all_file_paths(['datainf_slaver_empty','../../axi/data_interface/datainf_slaver_empty.sv'])
        return_stream = self
        
        slaver = DataInf.same_name_socket(:from_up,mix=true,slaver) unless slaver.is_a? String
        
        slaver = up_stream if up_stream
        

         @instance_draw_stack << lambda { _datainf_slaver_empty_draw(slaver:slaver,up_stream:up_stream) }
        return return_stream
    end

    def _datainf_slaver_empty_draw(slaver:"slaver",up_stream:nil)

        large_name_len(slaver)
"
// FilePath:::../../axi/data_interface/datainf_slaver_empty.sv
datainf_slaver_empty datainf_slaver_empty_#{signal}_inst(
/*  data_inf.slaver*/ .slaver (#{align_signal(slaver,q_mark=false)})
);
"
    end
    
    def self.datainf_slaver_empty(slaver:"slaver",up_stream:nil)
        return_stream = nil
        
        
        DataInf.NC._datainf_slaver_empty(slaver:slaver,up_stream:up_stream)
        return return_stream
    end
        

end


class TdlTest

    def self.test_datainf_slaver_empty
        c0 = Clock.new(name:"datainf_slaver_empty_clk",freqM:148.5)
        r0 = Reset.new(name:"datainf_slaver_empty_rst_n",active:"low")

        slaver = DataInf.new(name:"slaver",clock:c0,reset:r0)
        up_stream = slaver
        
        DataInf.datainf_slaver_empty(slaver:slaver)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_datainf_slaver_empty(
        slaver:"slaver")
        hash = TdlHash.new
        
        unless slaver.is_a? Hash
            hash.case_record(:slaver,slaver)
        else
            # hash.new_index(:slaver)= lambda { a = DataInf.new(slaver);a.name = "slaver";return a }
            # hash[:slaver] = lambda { a = DataInf.new(slaver);a.name = "slaver";return a }
            raise TdlError.new('datainf_slaver_empty DataInf slaver TdlHash cant include Proc') if slaver.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = DataInf.new(slaver)
                unless slaver[:name]
                    a.name = "slaver"
                end
                return a }
            hash.[]=(:slaver,lam,false)
        end
                

        hash.push_to_module_stack(DataInf,:datainf_slaver_empty)
        hash.open_error = true
        return hash
    end
end
