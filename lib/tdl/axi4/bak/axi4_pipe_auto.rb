
#2017-12-27 10:16:00 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class Axi4


    def axi4_pipe(
        slaver:"slaver",
        master:"master",
        up_stream:nil,
        down_stream:nil
    )

        Tdl.add_to_all_file_paths(['axi4_pipe','../../axi/AXI4/axi4_pipe/axi4_pipe.sv'])
        return_stream = self
        
        slaver = Axi4.same_name_socket(:from_up,mix=true,slaver) unless slaver.is_a? String
        master = Axi4.same_name_socket(:to_down,mix=true,master) unless master.is_a? String
        
        if up_stream==nil && slaver=="slaver"
            up_stream = self.copy(name:"slaver")
            return_stream = up_stream
        end

        slaver = up_stream if up_stream
        master = self unless self==Axi4.NC

         @instance_draw_stack << lambda { axi4_pipe_draw(
            slaver:slaver,
            master:master,
            up_stream:up_stream,
            down_stream:down_stream) }
        return return_stream
    end

    def axi4_pipe_draw(
        slaver:"slaver",
        master:"master",
        up_stream:nil,
        down_stream:nil
    )

        large_name_len(
            slaver,
            master
        )
"
// FilePath:::../../axi/AXI4/axi4_pipe/axi4_pipe.sv
axi4_pipe axi4_pipe_#{signal}_inst(
/*  axi_inf.slaver*/ .slaver (#{align_signal(slaver,q_mark=false)}),
/*  axi_inf.master*/ .master (#{align_signal(master,q_mark=false)})
);
"
    end
    
    def self.axi4_pipe(
        slaver:"slaver",
        master:"master",
        up_stream:nil,
        down_stream:nil
    )
        return_stream = nil
        
        if down_stream==nil && master=="master"
            if up_stream.is_a? Axi4
                down_stream = up_stream.copy(name:"master")
            else
                down_stream = slaver.copy(name:"master")
            end
            return_stream = down_stream
        end

        
        if up_stream==nil && slaver=="slaver"
            if down_stream.is_a? Axi4
                up_stream = down_stream.copy(name:"slaver")
            else
                up_stream = master.copy(name:"slaver")
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? Axi4
            down_stream.axi4_pipe(
                slaver:slaver,
                master:master,
                up_stream:up_stream,
                down_stream:down_stream)
        elsif master.is_a? Axi4
            master.axi4_pipe(
                slaver:slaver,
                master:master,
                up_stream:up_stream,
                down_stream:down_stream)
        else
            Axi4.NC.axi4_pipe(
                slaver:slaver,
                master:master,
                up_stream:up_stream,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_axi4_pipe
        c0 = Clock.new(name:"axi4_pipe_clk",freqM:148.5)
        r0 = Reset.new(name:"axi4_pipe_rst_n",active:"low")

        slaver = Axi4.new(name:"slaver",clock:c0,reset:r0)
        master = Axi4.new(name:"master",clock:c0,reset:r0)
        up_stream = slaver
        down_stream = master
        Axi4.axi4_pipe(
            slaver:slaver,
            master:master)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axi4_pipe(
        slaver:"slaver",
        master:"master")
        hash = TdlHash.new
        
        unless slaver.is_a? Hash
            hash.case_record(:slaver,slaver)
        else
            # hash.new_index(:slaver)= lambda { a = Axi4.new(slaver);a.name = "slaver";return a }
            # hash[:slaver] = lambda { a = Axi4.new(slaver);a.name = "slaver";return a }
            raise TdlError.new('axi4_pipe Axi4 slaver TdlHash cant include Proc') if slaver.select{ |k,v| v.is_a? Proc }.any?
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
            raise TdlError.new('axi4_pipe Axi4 master TdlHash cant include Proc') if master.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Axi4.new(master)
                unless master[:name]
                    a.name = "master"
                end
                return a }
            hash.[]=(:master,lam,false)
        end
                

        hash.push_to_module_stack(Axi4,:axi4_pipe)
        hash.open_error = true
        return hash
    end
end
