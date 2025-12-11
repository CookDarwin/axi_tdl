
#2017-12-27 10:16:00 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class Axi4


    def _axi4_direct(
        mode:"BOTH_to_BOTH",
        slaver:"slaver",
        master:"master"
    )

        Tdl.add_to_all_file_paths(['axi4_direct','../../axi/AXI4/axi4_direct.sv'])
        return_stream = self
        
        slaver = Axi4.same_name_socket(:from_up,mix=true,slaver) unless slaver.is_a? String
        master = Axi4.same_name_socket(:to_down,mix=true,master) unless master.is_a? String
        
        
        

         @instance_draw_stack << lambda { _axi4_direct_draw(
            mode:mode,
            slaver:slaver,
            master:master) }
        return return_stream
    end

    def _axi4_direct_draw(
        mode:"BOTH_to_BOTH",
        slaver:"slaver",
        master:"master"
    )

        large_name_len(
            mode,
            slaver,
            master
        )
"
// FilePath:::../../axi/AXI4/axi4_direct.sv
axi4_direct#(
    .MODE    (#{align_signal(mode)})
) axi4_direct_#{signal}_inst(
/*  axi_inf.slaver*/ .slaver (#{align_signal(slaver,q_mark=false)}),
/*  axi_inf.master*/ .master (#{align_signal(master,q_mark=false)})
);
"
    end
    
    def self.axi4_direct(
        mode:"BOTH_to_BOTH",
        slaver:"slaver",
        master:"master"
    )
        return_stream = nil
        
        
        Axi4.NC._axi4_direct(
            mode:mode,
                slaver:slaver,
                master:master)
        return return_stream
    end
        

end


class TdlTest

    def self.test_axi4_direct
        c0 = Clock.new(name:"axi4_direct_clk",freqM:148.5)
        r0 = Reset.new(name:"axi4_direct_rst_n",active:"low")

        mode = Parameter.new(name:"mode",value:"BOTH_to_BOTH")
        slaver = Axi4.new(name:"slaver",clock:c0,reset:r0)
        master = Axi4.new(name:"master",clock:c0,reset:r0)
        
        
        Axi4.axi4_direct(
            mode:mode,
            slaver:slaver,
            master:master)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axi4_direct(
        mode:"BOTH_to_BOTH",
        slaver:"slaver",
        master:"master")
        hash = TdlHash.new
        
        unless mode.is_a? Hash
            hash.case_record(:mode,mode)
        else
            # hash.new_index(:mode)= lambda { a = Parameter.new(mode);a.name = "mode";return a }
            # hash[:mode] = lambda { a = Parameter.new(mode);a.name = "mode";return a }
            raise TdlError.new('axi4_direct Parameter mode TdlHash cant include Proc') if mode.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(mode)
                unless mode[:name]
                    a.name = "mode"
                end
                return a }
            hash.[]=(:mode,lam,false)
        end
                

        unless slaver.is_a? Hash
            hash.case_record(:slaver,slaver)
        else
            # hash.new_index(:slaver)= lambda { a = Axi4.new(slaver);a.name = "slaver";return a }
            # hash[:slaver] = lambda { a = Axi4.new(slaver);a.name = "slaver";return a }
            raise TdlError.new('axi4_direct Axi4 slaver TdlHash cant include Proc') if slaver.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Axi4.new(slaver)
                unless slaver[:name]
                    a.name = "slaver"
                end
                return a }
            hash.[]=(:slaver,lam,false)
        end
                

        unless master.is_a? Hash
            hash.case_record(:master,master)
        else
            # hash.new_index(:master)= lambda { a = Axi4.new(master);a.name = "master";return a }
            # hash[:master] = lambda { a = Axi4.new(master);a.name = "master";return a }
            raise TdlError.new('axi4_direct Axi4 master TdlHash cant include Proc') if master.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Axi4.new(master)
                unless master[:name]
                    a.name = "master"
                end
                return a }
            hash.[]=(:master,lam,false)
        end
                

        hash.push_to_module_stack(Axi4,:axi4_direct)
        hash.open_error = true
        return hash
    end
end
