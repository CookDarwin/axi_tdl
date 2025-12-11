
#2017-12-27 10:16:00 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class Axi4


    def axi4_packet_fifo(
        pipe:"OFF",
        depth:4,
        mode:"BOTH",
        axi_in:"axi_in",
        axi_out:"axi_out",
        up_stream:nil,
        down_stream:nil
    )

        Tdl.add_to_all_file_paths(['axi4_packet_fifo','../../axi/AXI4/packet_fifo/axi4_packet_fifo.sv'])
        return_stream = self
        
        axi_in = Axi4.same_name_socket(:from_up,mix=true,axi_in) unless axi_in.is_a? String
        axi_out = Axi4.same_name_socket(:to_down,mix=true,axi_out) unless axi_out.is_a? String
        
        if up_stream==nil && axi_in=="axi_in"
            up_stream = self.copy(name:"axi_in")
            return_stream = up_stream
        end

        axi_in = up_stream if up_stream
        axi_out = self unless self==Axi4.NC

         @instance_draw_stack << lambda { axi4_packet_fifo_draw(
            pipe:pipe,
            depth:depth,
            mode:mode,
            axi_in:axi_in,
            axi_out:axi_out,
            up_stream:up_stream,
            down_stream:down_stream) }
        return return_stream
    end

    def axi4_packet_fifo_draw(
        pipe:"OFF",
        depth:4,
        mode:"BOTH",
        axi_in:"axi_in",
        axi_out:"axi_out",
        up_stream:nil,
        down_stream:nil
    )

        large_name_len(
            pipe,
            depth,
            mode,
            axi_in,
            axi_out
        )
"
// FilePath:::../../axi/AXI4/packet_fifo/axi4_packet_fifo.sv
axi4_packet_fifo#(
    .PIPE     (#{align_signal(pipe)}),
    .DEPTH    (#{align_signal(depth)}),
    .MODE     (#{align_signal(mode)})
) axi4_packet_fifo_#{signal}_inst(
/*  axi_inf.slaver*/ .axi_in  (#{align_signal(axi_in,q_mark=false)}),
/*  axi_inf.master*/ .axi_out (#{align_signal(axi_out,q_mark=false)})
);
"
    end
    
    def self.axi4_packet_fifo(
        pipe:"OFF",
        depth:4,
        mode:"BOTH",
        axi_in:"axi_in",
        axi_out:"axi_out",
        up_stream:nil,
        down_stream:nil
    )
        return_stream = nil
        
        if down_stream==nil && axi_out=="axi_out"
            if up_stream.is_a? Axi4
                down_stream = up_stream.copy(name:"axi_out")
            else
                down_stream = axi_in.copy(name:"axi_out")
            end
            return_stream = down_stream
        end

        
        if up_stream==nil && axi_in=="axi_in"
            if down_stream.is_a? Axi4
                up_stream = down_stream.copy(name:"axi_in")
            else
                up_stream = axi_out.copy(name:"axi_in")
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? Axi4
            down_stream.axi4_packet_fifo(
                pipe:pipe,
                depth:depth,
                mode:mode,
                axi_in:axi_in,
                axi_out:axi_out,
                up_stream:up_stream,
                down_stream:down_stream)
        elsif axi_out.is_a? Axi4
            axi_out.axi4_packet_fifo(
                pipe:pipe,
                depth:depth,
                mode:mode,
                axi_in:axi_in,
                axi_out:axi_out,
                up_stream:up_stream,
                down_stream:down_stream)
        else
            Axi4.NC.axi4_packet_fifo(
                pipe:pipe,
                depth:depth,
                mode:mode,
                axi_in:axi_in,
                axi_out:axi_out,
                up_stream:up_stream,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_axi4_packet_fifo
        c0 = Clock.new(name:"axi4_packet_fifo_clk",freqM:148.5)
        r0 = Reset.new(name:"axi4_packet_fifo_rst_n",active:"low")

        pipe = Parameter.new(name:"pipe",value:"OFF")
        depth = Parameter.new(name:"depth",value:4)
        mode = Parameter.new(name:"mode",value:"BOTH")
        axi_in = Axi4.new(name:"axi_in",clock:c0,reset:r0)
        axi_out = Axi4.new(name:"axi_out",clock:c0,reset:r0)
        up_stream = axi_in
        down_stream = axi_out
        Axi4.axi4_packet_fifo(
            pipe:pipe,
            depth:depth,
            mode:mode,
            axi_in:axi_in,
            axi_out:axi_out)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axi4_packet_fifo(
        pipe:"OFF",
        depth:4,
        mode:"BOTH",
        axi_in:"axi_in",
        axi_out:"axi_out")
        hash = TdlHash.new
        
        unless pipe.is_a? Hash
            hash.case_record(:pipe,pipe)
        else
            # hash.new_index(:pipe)= lambda { a = Parameter.new(pipe);a.name = "pipe";return a }
            # hash[:pipe] = lambda { a = Parameter.new(pipe);a.name = "pipe";return a }
            raise TdlError.new('axi4_packet_fifo Parameter pipe TdlHash cant include Proc') if pipe.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(pipe)
                unless pipe[:name]
                    a.name = "pipe"
                end
                return a }
            hash.[]=(:pipe,lam,false)
        end
                

        unless depth.is_a? Hash
            hash.case_record(:depth,depth)
        else
            # hash.new_index(:depth)= lambda { a = Parameter.new(depth);a.name = "depth";return a }
            # hash[:depth] = lambda { a = Parameter.new(depth);a.name = "depth";return a }
            raise TdlError.new('axi4_packet_fifo Parameter depth TdlHash cant include Proc') if depth.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(depth)
                unless depth[:name]
                    a.name = "depth"
                end
                return a }
            hash.[]=(:depth,lam,false)
        end
                

        unless mode.is_a? Hash
            hash.case_record(:mode,mode)
        else
            # hash.new_index(:mode)= lambda { a = Parameter.new(mode);a.name = "mode";return a }
            # hash[:mode] = lambda { a = Parameter.new(mode);a.name = "mode";return a }
            raise TdlError.new('axi4_packet_fifo Parameter mode TdlHash cant include Proc') if mode.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(mode)
                unless mode[:name]
                    a.name = "mode"
                end
                return a }
            hash.[]=(:mode,lam,false)
        end
                

        unless axi_in.is_a? Hash
            hash.case_record(:axi_in,axi_in)
        else
            # hash.new_index(:axi_in)= lambda { a = Axi4.new(axi_in);a.name = "axi_in";return a }
            # hash[:axi_in] = lambda { a = Axi4.new(axi_in);a.name = "axi_in";return a }
            raise TdlError.new('axi4_packet_fifo Axi4 axi_in TdlHash cant include Proc') if axi_in.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Axi4.new(axi_in)
                unless axi_in[:name]
                    a.name = "axi_in"
                end
                return a }
            hash.[]=(:axi_in,lam,false)
        end
                

        unless axi_out.is_a? Hash
            hash.case_record(:axi_out,axi_out)
        else
            # hash.new_index(:axi_out)= lambda { a = Axi4.new(axi_out);a.name = "axi_out";return a }
            # hash[:axi_out] = lambda { a = Axi4.new(axi_out);a.name = "axi_out";return a }
            raise TdlError.new('axi4_packet_fifo Axi4 axi_out TdlHash cant include Proc') if axi_out.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Axi4.new(axi_out)
                unless axi_out[:name]
                    a.name = "axi_out"
                end
                return a }
            hash.[]=(:axi_out,lam,false)
        end
                

        hash.push_to_module_stack(Axi4,:axi4_packet_fifo)
        hash.open_error = true
        return hash
    end
end
