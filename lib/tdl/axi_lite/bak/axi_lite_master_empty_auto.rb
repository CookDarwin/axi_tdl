
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiLite


    def axi_lite_master_empty(lite:"lite",down_stream:nil)

        Tdl.add_to_all_file_paths(['axi_lite_master_empty','../../axi/AXI_Lite/axi_lite_master_empty.sv'])
        return_stream = self
        
        lite = AxiLite.same_name_socket(:to_down,mix=true,lite) unless lite.is_a? String
        
        
        lite = self unless self==AxiLite.NC

         @instance_draw_stack << lambda { axi_lite_master_empty_draw(lite:lite,down_stream:down_stream) }
        return return_stream
    end

    def axi_lite_master_empty_draw(lite:"lite",down_stream:nil)

        large_name_len(lite)
"
// FilePath:::../../axi/AXI_Lite/axi_lite_master_empty.sv
axi_lite_master_empty axi_lite_master_empty_#{signal}_inst(
/*  axi_lite_inf.master*/ .lite (#{align_signal(lite,q_mark=false)})
);
"
    end
    
    def self.axi_lite_master_empty(lite:"lite",down_stream:nil)
        return_stream = nil
        
        
        
        if down_stream.is_a? AxiLite
            down_stream.axi_lite_master_empty(lite:lite,down_stream:down_stream)
        elsif lite.is_a? AxiLite
            lite.axi_lite_master_empty(lite:lite,down_stream:down_stream)
        else
            AxiLite.NC.axi_lite_master_empty(lite:lite,down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_axi_lite_master_empty
        c0 = Clock.new(name:"axi_lite_master_empty_clk",freqM:148.5)
        r0 = Reset.new(name:"axi_lite_master_empty_rst_n",active:"low")

        lite = AxiLite.new(name:"lite",clock:c0,reset:r0)
        
        down_stream = lite
        AxiLite.axi_lite_master_empty(lite:lite)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axi_lite_master_empty(
        lite:"lite")
        hash = TdlHash.new
        
        unless lite.is_a? Hash
            hash.case_record(:lite,lite)
        else
            # hash.new_index(:lite)= lambda { a = AxiLite.new(lite);a.name = "lite";return a }
            # hash[:lite] = lambda { a = AxiLite.new(lite);a.name = "lite";return a }
            raise TdlError.new('axi_lite_master_empty AxiLite lite TdlHash cant include Proc') if lite.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiLite.new(lite)
                unless lite[:name]
                    a.name = "lite"
                end
                return a }
            hash.[]=(:lite,lam,false)
        end
                

        hash.push_to_module_stack(AxiLite,:axi_lite_master_empty)
        hash.open_error = true
        return hash
    end
end
