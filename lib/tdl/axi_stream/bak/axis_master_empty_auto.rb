
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def axis_master_empty(master:"master",down_stream:nil)

        Tdl.add_to_all_file_paths(['axis_master_empty','../../axi/AXI_stream/axis_master_empty.sv'])
        return_stream = self
        
        master = AxiStream.same_name_socket(:to_down,mix=true,master) unless master.is_a? String
        
        
        master = self unless self==AxiStream.NC

         @instance_draw_stack << lambda { axis_master_empty_draw(master:master,down_stream:down_stream) }
        return return_stream
    end

    def axis_master_empty_draw(master:"master",down_stream:nil)

        large_name_len(master)
"
// FilePath:::../../axi/AXI_stream/axis_master_empty.sv
axis_master_empty axis_master_empty_#{signal}_inst(
/*  axi_stream_inf.master*/ .master (#{align_signal(master,q_mark=false)})
);
"
    end
    
    def self.axis_master_empty(master:"master",down_stream:nil)
        return_stream = nil
        
        
        
        if down_stream.is_a? AxiStream
            down_stream.axis_master_empty(master:master,down_stream:down_stream)
        elsif master.is_a? AxiStream
            master.axis_master_empty(master:master,down_stream:down_stream)
        else
            AxiStream.NC.axis_master_empty(master:master,down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_axis_master_empty
        c0 = Clock.new(name:"axis_master_empty_clk",freqM:148.5)
        r0 = Reset.new(name:"axis_master_empty_rst_n",active:"low")

        master = AxiStream.new(name:"master",clock:c0,reset:r0)
        
        down_stream = master
        AxiStream.axis_master_empty(master:master)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axis_master_empty(
        master:"master")
        hash = TdlHash.new
        
        unless master.is_a? Hash
            hash.case_record(:master,master)
        else
            # hash.new_index(:master)= lambda { a = AxiStream.new(master);a.name = "master";return a }
            # hash[:master] = lambda { a = AxiStream.new(master);a.name = "master";return a }
            raise TdlError.new('axis_master_empty AxiStream master TdlHash cant include Proc') if master.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(master)
                unless master[:name]
                    a.name = "master"
                end
                return a }
            hash.[]=(:master,lam,false)
        end
                

        hash.push_to_module_stack(AxiStream,:axis_master_empty)
        hash.open_error = true
        return hash
    end
end
