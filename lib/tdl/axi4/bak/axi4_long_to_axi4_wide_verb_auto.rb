
#2017-12-27 10:16:00 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class Axi4


    def _axi4_long_to_axi4_wide_verb(
        pipe:"OFF",
        partition:"ON",
        slaver:"slaver",
        master:"master"
    )

        Tdl.add_to_all_file_paths(['axi4_long_to_axi4_wide_verb','../../axi/AXI4/axi4_long_to_axi4_wide_verb.sv'])
        return_stream = self
        
        slaver = Axi4.same_name_socket(:from_up,mix=true,slaver) unless slaver.is_a? String
        master = Axi4.same_name_socket(:to_down,mix=true,master) unless master.is_a? String
        
        
        

         @instance_draw_stack << lambda { _axi4_long_to_axi4_wide_verb_draw(
            pipe:pipe,
            partition:partition,
            slaver:slaver,
            master:master) }
        return return_stream
    end

    def _axi4_long_to_axi4_wide_verb_draw(
        pipe:"OFF",
        partition:"ON",
        slaver:"slaver",
        master:"master"
    )

        large_name_len(
            pipe,
            partition,
            slaver,
            master
        )
"
// FilePath:::../../axi/AXI4/axi4_long_to_axi4_wide_verb.sv
axi4_long_to_axi4_wide_verb#(
    .PIPE         (#{align_signal(pipe)}),
    .PARTITION    (#{align_signal(partition)})
) axi4_long_to_axi4_wide_verb_#{signal}_inst(
/*  axi_inf.slaver*/ .slaver (#{align_signal(slaver,q_mark=false)}),
/*  axi_inf.master*/ .master (#{align_signal(master,q_mark=false)})
);
"
    end
    
    def self.axi4_long_to_axi4_wide_verb(
        pipe:"OFF",
        partition:"ON",
        slaver:"slaver",
        master:"master"
    )
        return_stream = nil
        
        
        Axi4.NC._axi4_long_to_axi4_wide_verb(
            pipe:pipe,
                partition:partition,
                slaver:slaver,
                master:master)
        return return_stream
    end
        

end


class TdlTest

    def self.test_axi4_long_to_axi4_wide_verb
        c0 = Clock.new(name:"axi4_long_to_axi4_wide_verb_clk",freqM:148.5)
        r0 = Reset.new(name:"axi4_long_to_axi4_wide_verb_rst_n",active:"low")

        pipe = Parameter.new(name:"pipe",value:"OFF")
        partition = Parameter.new(name:"partition",value:"ON")
        slaver = Axi4.new(name:"slaver",clock:c0,reset:r0)
        master = Axi4.new(name:"master",clock:c0,reset:r0)
        
        
        Axi4.axi4_long_to_axi4_wide_verb(
            pipe:pipe,
            partition:partition,
            slaver:slaver,
            master:master)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axi4_long_to_axi4_wide_verb(
        pipe:"OFF",
        partition:"ON",
        slaver:"slaver",
        master:"master")
        hash = TdlHash.new
        
        unless pipe.is_a? Hash
            hash.case_record(:pipe,pipe)
        else
            # hash.new_index(:pipe)= lambda { a = Parameter.new(pipe);a.name = "pipe";return a }
            # hash[:pipe] = lambda { a = Parameter.new(pipe);a.name = "pipe";return a }
            raise TdlError.new('axi4_long_to_axi4_wide_verb Parameter pipe TdlHash cant include Proc') if pipe.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(pipe)
                unless pipe[:name]
                    a.name = "pipe"
                end
                return a }
            hash.[]=(:pipe,lam,false)
        end
                

        unless partition.is_a? Hash
            hash.case_record(:partition,partition)
        else
            # hash.new_index(:partition)= lambda { a = Parameter.new(partition);a.name = "partition";return a }
            # hash[:partition] = lambda { a = Parameter.new(partition);a.name = "partition";return a }
            raise TdlError.new('axi4_long_to_axi4_wide_verb Parameter partition TdlHash cant include Proc') if partition.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(partition)
                unless partition[:name]
                    a.name = "partition"
                end
                return a }
            hash.[]=(:partition,lam,false)
        end
                

        unless slaver.is_a? Hash
            hash.case_record(:slaver,slaver)
        else
            # hash.new_index(:slaver)= lambda { a = Axi4.new(slaver);a.name = "slaver";return a }
            # hash[:slaver] = lambda { a = Axi4.new(slaver);a.name = "slaver";return a }
            raise TdlError.new('axi4_long_to_axi4_wide_verb Axi4 slaver TdlHash cant include Proc') if slaver.select{ |k,v| v.is_a? Proc }.any?
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
            raise TdlError.new('axi4_long_to_axi4_wide_verb Axi4 master TdlHash cant include Proc') if master.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Axi4.new(master)
                unless master[:name]
                    a.name = "master"
                end
                return a }
            hash.[]=(:master,lam,false)
        end
                

        hash.push_to_module_stack(Axi4,:axi4_long_to_axi4_wide_verb)
        hash.open_error = true
        return hash
    end
end
