
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def axi_stream_packet_fifo_with_info(depth:2,esize:8,info_in:"info_in",info_out:"info_out",axis_in:"axis_in",axis_out:"axis_out",up_stream:nil,down_stream:nil)

        Tdl.add_to_all_file_paths(['axi_stream_packet_fifo_with_info','../../axi/AXI_stream/packet_fifo/axi_stream_packet_fifo_with_info.sv'])
        return_stream = self
        
        axis_in = AxiStream.same_name_socket(:from_up,mix=true,axis_in) unless axis_in.is_a? String
        axis_out = AxiStream.same_name_socket(:to_down,mix=true,axis_out) unless axis_out.is_a? String
        
        if up_stream==nil && axis_in=="axis_in"
            up_stream = self.copy(name:"axis_in")
            return_stream = up_stream
        end

        axis_in = up_stream if up_stream
        axis_out = self unless self==AxiStream.NC

         @instance_draw_stack << lambda { axi_stream_packet_fifo_with_info_draw(depth:depth,esize:esize,info_in:info_in,info_out:info_out,axis_in:axis_in,axis_out:axis_out,up_stream:up_stream,down_stream:down_stream) }
        return return_stream
    end

    def axi_stream_packet_fifo_with_info_draw(depth:2,esize:8,info_in:"info_in",info_out:"info_out",axis_in:"axis_in",axis_out:"axis_out",up_stream:nil,down_stream:nil)

        large_name_len(depth,esize,info_in,info_out,axis_in,axis_out)
"
// FilePath:::../../axi/AXI_stream/packet_fifo/axi_stream_packet_fifo_with_info.sv
axi_stream_packet_fifo_with_info#(
    .DEPTH    (#{align_signal(depth)}),
    .ESIZE    (#{align_signal(esize)})
) axi_stream_packet_fifo_with_info_#{signal}_inst(
/*  input  [ESIZE-1:0]   */ .info_in  (#{align_signal(info_in,q_mark=false)}),
/*  output [ESIZE-1:0]   */ .info_out (#{align_signal(info_out,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .axis_in  (#{align_signal(axis_in,q_mark=false)}),
/*  axi_stream_inf.master*/ .axis_out (#{align_signal(axis_out,q_mark=false)})
);
"
    end
    
    def self.axi_stream_packet_fifo_with_info(depth:2,esize:8,info_in:"info_in",info_out:"info_out",axis_in:"axis_in",axis_out:"axis_out",up_stream:nil,down_stream:nil)
        return_stream = nil
        
        if down_stream==nil && axis_out=="axis_out"
            if up_stream.is_a? AxiStream
                down_stream = up_stream.copy(name:"axis_out")
            else
                down_stream = axis_in.copy(name:"axis_out")
            end
            return_stream = down_stream
        end

        
        if up_stream==nil && axis_in=="axis_in"
            if down_stream.is_a? AxiStream
                up_stream = down_stream.copy(name:"axis_in")
            else
                up_stream = axis_out.copy(name:"axis_in")
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? AxiStream
            down_stream.axi_stream_packet_fifo_with_info(depth:depth,esize:esize,info_in:info_in,info_out:info_out,axis_in:axis_in,axis_out:axis_out,up_stream:up_stream,down_stream:down_stream)
        elsif axis_out.is_a? AxiStream
            axis_out.axi_stream_packet_fifo_with_info(depth:depth,esize:esize,info_in:info_in,info_out:info_out,axis_in:axis_in,axis_out:axis_out,up_stream:up_stream,down_stream:down_stream)
        else
            AxiStream.NC.axi_stream_packet_fifo_with_info(depth:depth,esize:esize,info_in:info_in,info_out:info_out,axis_in:axis_in,axis_out:axis_out,up_stream:up_stream,down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_axi_stream_packet_fifo_with_info
        c0 = Clock.new(name:"axi_stream_packet_fifo_with_info_clk",freqM:148.5)
        r0 = Reset.new(name:"axi_stream_packet_fifo_with_info_rst_n",active:"low")

        depth = Parameter.new(name:"depth",value:2)
        esize = Parameter.new(name:"esize",value:8)
        info_in = Logic.new(name:"info_in")
        info_out = Logic.new(name:"info_out")
        axis_in = AxiStream.new(name:"axis_in",clock:c0,reset:r0)
        axis_out = AxiStream.new(name:"axis_out",clock:c0,reset:r0)
        up_stream = axis_in
        down_stream = axis_out
        AxiStream.axi_stream_packet_fifo_with_info(depth:depth,esize:esize,info_in:info_in,info_out:info_out,axis_in:axis_in,axis_out:axis_out)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axi_stream_packet_fifo_with_info(
        depth:2,
        esize:8,
        info_in:"info_in",
        info_out:"info_out",
        axis_in:"axis_in",
        axis_out:"axis_out")
        hash = TdlHash.new
        
        unless depth.is_a? Hash
            hash.case_record(:depth,depth)
        else
            # hash.new_index(:depth)= lambda { a = Parameter.new(depth);a.name = "depth";return a }
            # hash[:depth] = lambda { a = Parameter.new(depth);a.name = "depth";return a }
            raise TdlError.new('axi_stream_packet_fifo_with_info Parameter depth TdlHash cant include Proc') if depth.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(depth)
                unless depth[:name]
                    a.name = "depth"
                end
                return a }
            hash.[]=(:depth,lam,false)
        end
                

        unless esize.is_a? Hash
            hash.case_record(:esize,esize)
        else
            # hash.new_index(:esize)= lambda { a = Parameter.new(esize);a.name = "esize";return a }
            # hash[:esize] = lambda { a = Parameter.new(esize);a.name = "esize";return a }
            raise TdlError.new('axi_stream_packet_fifo_with_info Parameter esize TdlHash cant include Proc') if esize.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(esize)
                unless esize[:name]
                    a.name = "esize"
                end
                return a }
            hash.[]=(:esize,lam,false)
        end
                

        unless info_in.is_a? Hash
            hash.case_record(:info_in,info_in)
        else
            # hash.new_index(:info_in)= lambda { a = Logic.new(info_in);a.name = "info_in";return a }
            # hash[:info_in] = lambda { a = Logic.new(info_in);a.name = "info_in";return a }
            raise TdlError.new('axi_stream_packet_fifo_with_info Logic info_in TdlHash cant include Proc') if info_in.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(info_in)
                unless info_in[:name]
                    a.name = "info_in"
                end
                return a }
            hash.[]=(:info_in,lam,false)
        end
                

        unless info_out.is_a? Hash
            hash.case_record(:info_out,info_out)
        else
            # hash.new_index(:info_out)= lambda { a = Logic.new(info_out);a.name = "info_out";return a }
            # hash[:info_out] = lambda { a = Logic.new(info_out);a.name = "info_out";return a }
            raise TdlError.new('axi_stream_packet_fifo_with_info Logic info_out TdlHash cant include Proc') if info_out.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(info_out)
                unless info_out[:name]
                    a.name = "info_out"
                end
                return a }
            hash.[]=(:info_out,lam,false)
        end
                

        unless axis_in.is_a? Hash
            hash.case_record(:axis_in,axis_in)
        else
            # hash.new_index(:axis_in)= lambda { a = AxiStream.new(axis_in);a.name = "axis_in";return a }
            # hash[:axis_in] = lambda { a = AxiStream.new(axis_in);a.name = "axis_in";return a }
            raise TdlError.new('axi_stream_packet_fifo_with_info AxiStream axis_in TdlHash cant include Proc') if axis_in.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(axis_in)
                unless axis_in[:name]
                    a.name = "axis_in"
                end
                return a }
            hash.[]=(:axis_in,lam,false)
        end
                

        unless axis_out.is_a? Hash
            hash.case_record(:axis_out,axis_out)
        else
            # hash.new_index(:axis_out)= lambda { a = AxiStream.new(axis_out);a.name = "axis_out";return a }
            # hash[:axis_out] = lambda { a = AxiStream.new(axis_out);a.name = "axis_out";return a }
            raise TdlError.new('axi_stream_packet_fifo_with_info AxiStream axis_out TdlHash cant include Proc') if axis_out.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(axis_out)
                unless axis_out[:name]
                    a.name = "axis_out"
                end
                return a }
            hash.[]=(:axis_out,lam,false)
        end
                

        hash.push_to_module_stack(AxiStream,:axi_stream_packet_fifo_with_info)
        hash.open_error = true
        return hash
    end
end
