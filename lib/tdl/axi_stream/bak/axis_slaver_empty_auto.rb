
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def _axis_slaver_empty(slaver:"slaver",up_stream:nil)

        Tdl.add_to_all_file_paths(['axis_slaver_empty','../../axi/AXI_stream/axis_slaver_empty.sv'])
        return_stream = self
        
        slaver = AxiStream.same_name_socket(:from_up,mix=true,slaver) unless slaver.is_a? String
        
        slaver = up_stream if up_stream
        

         @instance_draw_stack << lambda { _axis_slaver_empty_draw(slaver:slaver,up_stream:up_stream) }
        return return_stream
    end

    def _axis_slaver_empty_draw(slaver:"slaver",up_stream:nil)

        large_name_len(slaver)
"
// FilePath:::../../axi/AXI_stream/axis_slaver_empty.sv
axis_slaver_empty axis_slaver_empty_#{signal}_inst(
/*  axi_stream_inf.slaver*/ .slaver (#{align_signal(slaver,q_mark=false)})
);
"
    end
    
    def self.axis_slaver_empty(slaver:"slaver",up_stream:nil)
        return_stream = nil
        
        
        AxiStream.NC._axis_slaver_empty(slaver:slaver,up_stream:up_stream)
        return return_stream
    end
        

end


class TdlTest

    def self.test_axis_slaver_empty
        c0 = Clock.new(name:"axis_slaver_empty_clk",freqM:148.5)
        r0 = Reset.new(name:"axis_slaver_empty_rst_n",active:"low")

        slaver = AxiStream.new(name:"slaver",clock:c0,reset:r0)
        up_stream = slaver
        
        AxiStream.axis_slaver_empty(slaver:slaver)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axis_slaver_empty(
        slaver:"slaver")
        hash = TdlHash.new
        
        unless slaver.is_a? Hash
            hash.case_record(:slaver,slaver)
        else
            # hash.new_index(:slaver)= lambda { a = AxiStream.new(slaver);a.name = "slaver";return a }
            # hash[:slaver] = lambda { a = AxiStream.new(slaver);a.name = "slaver";return a }
            raise TdlError.new('axis_slaver_empty AxiStream slaver TdlHash cant include Proc') if slaver.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(slaver)
                unless slaver[:name]
                    a.name = "slaver"
                end
                return a }
            hash.[]=(:slaver,lam,false)
        end
                

        hash.push_to_module_stack(AxiStream,:axis_slaver_empty)
        hash.open_error = true
        return hash
    end
end
