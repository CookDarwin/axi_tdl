
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def axis_length_split_with_addr(addr_step:1024      ,origin_addr:"origin_addr",length:"length",band_addr:"band_addr",axis_in:"axis_in",axis_out:"axis_out",up_stream:nil,down_stream:nil)

        Tdl.add_to_all_file_paths(['axis_length_split_with_addr','../../axi/AXI_stream/axis_length_split_with_addr.sv'])
        return_stream = self
        
        axis_in = AxiStream.same_name_socket(:from_up,mix=true,axis_in) unless axis_in.is_a? String
        axis_out = AxiStream.same_name_socket(:to_down,mix=true,axis_out) unless axis_out.is_a? String
        
        if up_stream==nil && axis_in=="axis_in"
            up_stream = self.copy(name:"axis_in")
            return_stream = up_stream
        end

        axis_in = up_stream if up_stream
        axis_out = self unless self==AxiStream.NC

         @instance_draw_stack << lambda { axis_length_split_with_addr_draw(addr_step:addr_step,origin_addr:origin_addr,length:length,band_addr:band_addr,axis_in:axis_in,axis_out:axis_out,up_stream:up_stream,down_stream:down_stream) }
        return return_stream
    end

    def axis_length_split_with_addr_draw(addr_step:1024      ,origin_addr:"origin_addr",length:"length",band_addr:"band_addr",axis_in:"axis_in",axis_out:"axis_out",up_stream:nil,down_stream:nil)

        large_name_len(addr_step,origin_addr,length,band_addr,axis_in,axis_out)
"
// FilePath:::../../axi/AXI_stream/axis_length_split_with_addr.sv
axis_length_split_with_addr#(
    .ADDR_STEP    (#{align_signal(addr_step)})
) axis_length_split_with_addr_#{signal}_inst(
/*  input  [31:0]        */ .origin_addr (#{align_signal(origin_addr,q_mark=false)}),
/*  input  [31:0]        */ .length      (#{align_signal(length,q_mark=false)}),
/*  output [31:0]        */ .band_addr   (#{align_signal(band_addr,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .axis_in     (#{align_signal(axis_in,q_mark=false)}),
/*  axi_stream_inf.master*/ .axis_out    (#{align_signal(axis_out,q_mark=false)})
);
"
    end
    
    def self.axis_length_split_with_addr(addr_step:1024      ,origin_addr:"origin_addr",length:"length",band_addr:"band_addr",axis_in:"axis_in",axis_out:"axis_out",up_stream:nil,down_stream:nil)
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
            down_stream.axis_length_split_with_addr(addr_step:addr_step,origin_addr:origin_addr,length:length,band_addr:band_addr,axis_in:axis_in,axis_out:axis_out,up_stream:up_stream,down_stream:down_stream)
        elsif axis_out.is_a? AxiStream
            axis_out.axis_length_split_with_addr(addr_step:addr_step,origin_addr:origin_addr,length:length,band_addr:band_addr,axis_in:axis_in,axis_out:axis_out,up_stream:up_stream,down_stream:down_stream)
        else
            AxiStream.NC.axis_length_split_with_addr(addr_step:addr_step,origin_addr:origin_addr,length:length,band_addr:band_addr,axis_in:axis_in,axis_out:axis_out,up_stream:up_stream,down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_axis_length_split_with_addr
        c0 = Clock.new(name:"axis_length_split_with_addr_clk",freqM:148.5)
        r0 = Reset.new(name:"axis_length_split_with_addr_rst_n",active:"low")

        addr_step = Parameter.new(name:"addr_step",value:1024      )
        origin_addr = Logic.new(name:"origin_addr")
        length = Logic.new(name:"length")
        band_addr = Logic.new(name:"band_addr")
        axis_in = AxiStream.new(name:"axis_in",clock:c0,reset:r0)
        axis_out = AxiStream.new(name:"axis_out",clock:c0,reset:r0)
        up_stream = axis_in
        down_stream = axis_out
        AxiStream.axis_length_split_with_addr(addr_step:addr_step,origin_addr:origin_addr,length:length,band_addr:band_addr,axis_in:axis_in,axis_out:axis_out)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axis_length_split_with_addr(
        addr_step:1024      ,
        origin_addr:"origin_addr",
        length:"length",
        band_addr:"band_addr",
        axis_in:"axis_in",
        axis_out:"axis_out")
        hash = TdlHash.new
        
        unless addr_step.is_a? Hash
            hash.case_record(:addr_step,addr_step)
        else
            # hash.new_index(:addr_step)= lambda { a = Parameter.new(addr_step);a.name = "addr_step";return a }
            # hash[:addr_step] = lambda { a = Parameter.new(addr_step);a.name = "addr_step";return a }
            raise TdlError.new('axis_length_split_with_addr Parameter addr_step TdlHash cant include Proc') if addr_step.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(addr_step)
                unless addr_step[:name]
                    a.name = "addr_step"
                end
                return a }
            hash.[]=(:addr_step,lam,false)
        end
                

        unless origin_addr.is_a? Hash
            hash.case_record(:origin_addr,origin_addr)
        else
            # hash.new_index(:origin_addr)= lambda { a = Logic.new(origin_addr);a.name = "origin_addr";return a }
            # hash[:origin_addr] = lambda { a = Logic.new(origin_addr);a.name = "origin_addr";return a }
            raise TdlError.new('axis_length_split_with_addr Logic origin_addr TdlHash cant include Proc') if origin_addr.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(origin_addr)
                unless origin_addr[:name]
                    a.name = "origin_addr"
                end
                return a }
            hash.[]=(:origin_addr,lam,false)
        end
                

        unless length.is_a? Hash
            hash.case_record(:length,length)
        else
            # hash.new_index(:length)= lambda { a = Logic.new(length);a.name = "length";return a }
            # hash[:length] = lambda { a = Logic.new(length);a.name = "length";return a }
            raise TdlError.new('axis_length_split_with_addr Logic length TdlHash cant include Proc') if length.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(length)
                unless length[:name]
                    a.name = "length"
                end
                return a }
            hash.[]=(:length,lam,false)
        end
                

        unless band_addr.is_a? Hash
            hash.case_record(:band_addr,band_addr)
        else
            # hash.new_index(:band_addr)= lambda { a = Logic.new(band_addr);a.name = "band_addr";return a }
            # hash[:band_addr] = lambda { a = Logic.new(band_addr);a.name = "band_addr";return a }
            raise TdlError.new('axis_length_split_with_addr Logic band_addr TdlHash cant include Proc') if band_addr.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(band_addr)
                unless band_addr[:name]
                    a.name = "band_addr"
                end
                return a }
            hash.[]=(:band_addr,lam,false)
        end
                

        unless axis_in.is_a? Hash
            hash.case_record(:axis_in,axis_in)
        else
            # hash.new_index(:axis_in)= lambda { a = AxiStream.new(axis_in);a.name = "axis_in";return a }
            # hash[:axis_in] = lambda { a = AxiStream.new(axis_in);a.name = "axis_in";return a }
            raise TdlError.new('axis_length_split_with_addr AxiStream axis_in TdlHash cant include Proc') if axis_in.select{ |k,v| v.is_a? Proc }.any?
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
            raise TdlError.new('axis_length_split_with_addr AxiStream axis_out TdlHash cant include Proc') if axis_out.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(axis_out)
                unless axis_out[:name]
                    a.name = "axis_out"
                end
                return a }
            hash.[]=(:axis_out,lam,false)
        end
                

        hash.push_to_module_stack(AxiStream,:axis_length_split_with_addr)
        hash.open_error = true
        return hash
    end
end
