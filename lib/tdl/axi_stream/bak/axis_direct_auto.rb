
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def axis_direct(slaver:"slaver",master:"master",up_stream:nil,down_stream:nil)

        Tdl.add_to_all_file_paths(['axis_direct','../../axi/AXI_stream/axis_direct.sv'])
        return_stream = self
        
        slaver = AxiStream.same_name_socket(:from_up,mix=true,slaver) unless slaver.is_a? String
        master = AxiStream.same_name_socket(:to_down,mix=true,master) unless master.is_a? String
        
        if up_stream==nil && slaver=="slaver"
            up_stream = self.copy(name:"slaver")
            return_stream = up_stream
        end

        slaver = up_stream if up_stream
        master = self unless self==AxiStream.NC

         @instance_draw_stack << lambda { axis_direct_draw(slaver:slaver,master:master,up_stream:up_stream,down_stream:down_stream) }
        return return_stream
    end

    def axis_direct_draw(slaver:"slaver",master:"master",up_stream:nil,down_stream:nil)

        large_name_len(slaver,master)
"
// FilePath:::../../axi/AXI_stream/axis_direct.sv
axis_direct axis_direct_#{signal}_inst(
/*  axi_stream_inf.slaver*/ .slaver (#{align_signal(slaver,q_mark=false)}),
/*  axi_stream_inf.master*/ .master (#{align_signal(master,q_mark=false)})
);
"
    end
    
    def self.axis_direct(slaver:"slaver",master:"master",up_stream:nil,down_stream:nil)
        return_stream = nil
        
        if down_stream==nil && master=="master"
            if up_stream.is_a? AxiStream
                down_stream = up_stream.copy(name:"master")
            else
                down_stream = slaver.copy(name:"master")
            end
            return_stream = down_stream
        end

        
        if up_stream==nil && slaver=="slaver"
            if down_stream.is_a? AxiStream
                up_stream = down_stream.copy(name:"slaver")
            else
                up_stream = master.copy(name:"slaver")
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? AxiStream
            down_stream.axis_direct(slaver:slaver,master:master,up_stream:up_stream,down_stream:down_stream)
        elsif master.is_a? AxiStream
            master.axis_direct(slaver:slaver,master:master,up_stream:up_stream,down_stream:down_stream)
        else
            AxiStream.NC.axis_direct(slaver:slaver,master:master,up_stream:up_stream,down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_axis_direct
        c0 = Clock.new(name:"axis_direct_clk",freqM:148.5)
        r0 = Reset.new(name:"axis_direct_rst_n",active:"low")

        slaver = AxiStream.new(name:"slaver",clock:c0,reset:r0)
        master = AxiStream.new(name:"master",clock:c0,reset:r0)
        up_stream = slaver
        down_stream = master
        AxiStream.axis_direct(slaver:slaver,master:master)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axis_direct(
        slaver:"slaver",
        master:"master")
        hash = TdlHash.new
        
        unless slaver.is_a? Hash
            hash.case_record(:slaver,slaver)
        else
            # hash.new_index(:slaver)= lambda { a = AxiStream.new(slaver);a.name = "slaver";return a }
            # hash[:slaver] = lambda { a = AxiStream.new(slaver);a.name = "slaver";return a }
            raise TdlError.new('axis_direct AxiStream slaver TdlHash cant include Proc') if slaver.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(slaver)
                unless slaver[:name]
                    a.name = "slaver"
                end
                return a }
            hash.[]=(:slaver,lam,false)
        end
                

        unless master.is_a? Hash
            hash.case_record(:master,master)
        else
            # hash.new_index(:master)= lambda { a = AxiStream.new(master);a.name = "master";return a }
            # hash[:master] = lambda { a = AxiStream.new(master);a.name = "master";return a }
            raise TdlError.new('axis_direct AxiStream master TdlHash cant include Proc') if master.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(master)
                unless master[:name]
                    a.name = "master"
                end
                return a }
            hash.[]=(:master,lam,false)
        end
                

        hash.push_to_module_stack(AxiStream,:axis_direct)
        hash.open_error = true
        return hash
    end
end
