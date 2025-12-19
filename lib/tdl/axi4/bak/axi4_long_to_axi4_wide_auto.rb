
#2017-12-27 10:16:00 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class Axi4


    def _axi4_long_to_axi4_wide(
        slaver:"slaver",
        master:"master"
    )

        Tdl.add_to_all_file_paths(['axi4_long_to_axi4_wide','../../axi/AXI4/axi4_long_to_axi4_wide.sv'])
        return_stream = self
        
        slaver = Axi4.same_name_socket(:from_up,mix=true,slaver) unless slaver.is_a? String
        master = Axi4.same_name_socket(:to_down,mix=true,master) unless master.is_a? String
        
        
        

         @instance_draw_stack << lambda { _axi4_long_to_axi4_wide_draw(
            slaver:slaver,
            master:master) }
        return return_stream
    end

    def _axi4_long_to_axi4_wide_draw(
        slaver:"slaver",
        master:"master"
    )

        large_name_len(
            slaver,
            master
        )
"
// FilePath:::../../axi/AXI4/axi4_long_to_axi4_wide.sv
axi4_long_to_axi4_wide axi4_long_to_axi4_wide_#{signal}_inst(
/*  axi_inf.slaver*/ .slaver (#{align_signal(slaver,q_mark=false)}),
/*  axi_inf.master*/ .master (#{align_signal(master,q_mark=false)})
);
"
    end
    
    def self.axi4_long_to_axi4_wide(
        slaver:"slaver",
        master:"master"
    )
        return_stream = nil
        
        
        Axi4.NC._axi4_long_to_axi4_wide(
            slaver:slaver,
                master:master)
        return return_stream
    end
        

end


class TdlTest

    def self.test_axi4_long_to_axi4_wide
        c0 = Clock.new(name:"axi4_long_to_axi4_wide_clk",freqM:148.5)
        r0 = Reset.new(name:"axi4_long_to_axi4_wide_rst_n",active:"low")

        slaver = Axi4.new(name:"slaver",clock:c0,reset:r0)
        master = Axi4.new(name:"master",clock:c0,reset:r0)
        
        
        Axi4.axi4_long_to_axi4_wide(
            slaver:slaver,
            master:master)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axi4_long_to_axi4_wide(
        slaver:"slaver",
        master:"master")
        hash = TdlHash.new
        
        unless slaver.is_a? Hash
            hash.case_record(:slaver,slaver)
        else
            # hash.new_index(:slaver)= lambda { a = Axi4.new(slaver);a.name = "slaver";return a }
            # hash[:slaver] = lambda { a = Axi4.new(slaver);a.name = "slaver";return a }
            raise TdlError.new('axi4_long_to_axi4_wide Axi4 slaver TdlHash cant include Proc') if slaver.select{ |k,v| v.is_a? Proc }.any?
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
            raise TdlError.new('axi4_long_to_axi4_wide Axi4 master TdlHash cant include Proc') if master.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Axi4.new(master)
                unless master[:name]
                    a.name = "master"
                end
                return a }
            hash.[]=(:master,lam,false)
        end
                

        hash.push_to_module_stack(Axi4,:axi4_long_to_axi4_wide)
        hash.open_error = true
        return hash
    end
end
