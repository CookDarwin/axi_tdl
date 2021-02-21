
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiLite


    def _axi_lite_slaver_empty(lite:"lite",up_stream:nil)

        Tdl.add_to_all_file_paths(['axi_lite_slaver_empty','../../axi/AXI_Lite/axi_lite_slaver_empty.sv'])
        return_stream = self
        
        lite = AxiLite.same_name_socket(:from_up,mix=true,lite) unless lite.is_a? String
        
        lite = up_stream if up_stream
        

         @instance_draw_stack << lambda { _axi_lite_slaver_empty_draw(lite:lite,up_stream:up_stream) }
        return return_stream
    end

    def _axi_lite_slaver_empty_draw(lite:"lite",up_stream:nil)

        large_name_len(lite)
"
// FilePath:::../../axi/AXI_Lite/axi_lite_slaver_empty.sv
axi_lite_slaver_empty axi_lite_slaver_empty_#{signal}_inst(
/*  axi_lite_inf.slaver*/ .lite (#{align_signal(lite,q_mark=false)})
);
"
    end
    
    def self.axi_lite_slaver_empty(lite:"lite",up_stream:nil)
        return_stream = nil
        
        
        AxiLite.NC._axi_lite_slaver_empty(lite:lite,up_stream:up_stream)
        return return_stream
    end
        

end


class TdlTest

    def self.test_axi_lite_slaver_empty
        c0 = Clock.new(name:"axi_lite_slaver_empty_clk",freqM:148.5)
        r0 = Reset.new(name:"axi_lite_slaver_empty_rst_n",active:"low")

        lite = AxiLite.new(name:"lite",clock:c0,reset:r0)
        up_stream = lite
        
        AxiLite.axi_lite_slaver_empty(lite:lite)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axi_lite_slaver_empty(
        lite:"lite")
        hash = TdlHash.new
        
        unless lite.is_a? Hash
            hash.case_record(:lite,lite)
        else
            # hash.new_index(:lite)= lambda { a = AxiLite.new(lite);a.name = "lite";return a }
            # hash[:lite] = lambda { a = AxiLite.new(lite);a.name = "lite";return a }
            raise TdlError.new('axi_lite_slaver_empty AxiLite lite TdlHash cant include Proc') if lite.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiLite.new(lite)
                unless lite[:name]
                    a.name = "lite"
                end
                return a }
            hash.[]=(:lite,lam,false)
        end
                

        hash.push_to_module_stack(AxiLite,:axi_lite_slaver_empty)
        hash.open_error = true
        return hash
    end
end
