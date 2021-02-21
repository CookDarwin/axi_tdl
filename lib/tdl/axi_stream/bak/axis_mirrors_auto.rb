
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def axis_mirrors(h:0,l:0,num:8,mode:"CDS_MODE",condition_data:"condition_data",axis_in:"axis_in",axis_mirror:"axis_mirror",up_stream:nil,down_stream:nil)

        Tdl.add_to_all_file_paths(['axis_mirrors','../../axi/AXI_stream/axis_mirrors.sv'])
        return_stream = self
        
        axis_in = AxiStream.same_name_socket(:from_up,mix=true,axis_in) unless axis_in.is_a? String
        axis_mirror = AxiStream.same_name_socket(:to_down,mix=false,axis_mirror) unless axis_mirror.is_a? String
        
        if up_stream==nil && axis_in=="axis_in"
            up_stream = self.copy(name:"axis_in")
            return_stream = up_stream
        end

        axis_in = up_stream if up_stream
        axis_mirror = self unless self==AxiStream.NC

         @instance_draw_stack << lambda { axis_mirrors_draw(h:h,l:l,num:num,mode:mode,condition_data:condition_data,axis_in:axis_in,axis_mirror:axis_mirror,up_stream:up_stream,down_stream:down_stream) }
        return return_stream
    end

    def axis_mirrors_draw(h:0,l:0,num:8,mode:"CDS_MODE",condition_data:"condition_data",axis_in:"axis_in",axis_mirror:"axis_mirror",up_stream:nil,down_stream:nil)

        large_name_len(h,l,num,mode,condition_data,axis_in,axis_mirror)
"
// FilePath:::../../axi/AXI_stream/axis_mirrors.sv
axis_mirrors#(
    .H       (#{align_signal(h)}),
    .L       (#{align_signal(l)}),
    .NUM     (#{align_signal(num)}),
    .MODE    (#{align_signal(mode)})
) axis_mirrors_#{signal}_inst(
/*  input  [H:L]         */ .condition_data (#{align_signal(condition_data,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .axis_in        (#{align_signal(axis_in,q_mark=false)}),
/*  axi_stream_inf.master*/ .axis_mirror    (#{align_signal(axis_mirror,q_mark=false)})
);
"
    end
    
    def self.axis_mirrors(h:0,l:0,num:8,mode:"CDS_MODE",condition_data:"condition_data",axis_in:"axis_in",axis_mirror:"axis_mirror",up_stream:nil,down_stream:nil)
        return_stream = nil
        
        if down_stream==nil && axis_mirror=="axis_mirror"
            if up_stream.is_a? AxiStream
                down_stream = up_stream.copy(name:"axis_mirror")
            else
                down_stream = axis_in.copy(name:"axis_mirror")
            end
            return_stream = down_stream
        end

        
        if up_stream==nil && axis_in=="axis_in"
            if down_stream.is_a? AxiStream
                up_stream = down_stream.copy(name:"axis_in")
            else
                up_stream = axis_mirror.copy(name:"axis_in")
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? AxiStream
            down_stream.axis_mirrors(h:h,l:l,num:num,mode:mode,condition_data:condition_data,axis_in:axis_in,axis_mirror:axis_mirror,up_stream:up_stream,down_stream:down_stream)
        elsif axis_mirror.is_a? AxiStream
            axis_mirror.axis_mirrors(h:h,l:l,num:num,mode:mode,condition_data:condition_data,axis_in:axis_in,axis_mirror:axis_mirror,up_stream:up_stream,down_stream:down_stream)
        else
            AxiStream.NC.axis_mirrors(h:h,l:l,num:num,mode:mode,condition_data:condition_data,axis_in:axis_in,axis_mirror:axis_mirror,up_stream:up_stream,down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_axis_mirrors
        c0 = Clock.new(name:"axis_mirrors_clk",freqM:148.5)
        r0 = Reset.new(name:"axis_mirrors_rst_n",active:"low")

        h = Parameter.new(name:"h",value:0)
        l = Parameter.new(name:"l",value:0)
        num = Parameter.new(name:"num",value:8)
        mode = Parameter.new(name:"mode",value:"CDS_MODE")
        condition_data = Logic.new(name:"condition_data")
        axis_in = AxiStream.new(name:"axis_in",clock:c0,reset:r0)
        axis_mirror = AxiStream.new(name:"axis_mirror",clock:c0,reset:r0)
        up_stream = axis_in
        down_stream = axis_mirror
        AxiStream.axis_mirrors(h:h,l:l,num:num,mode:mode,condition_data:condition_data,axis_in:axis_in,axis_mirror:axis_mirror)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axis_mirrors(
        h:0,
        l:0,
        num:8,
        mode:"CDS_MODE",
        condition_data:"condition_data",
        axis_in:"axis_in",
        axis_mirror:"axis_mirror")
        hash = TdlHash.new
        
        unless h.is_a? Hash
            hash.case_record(:h,h)
        else
            # hash.new_index(:h)= lambda { a = Parameter.new(h);a.name = "h";return a }
            # hash[:h] = lambda { a = Parameter.new(h);a.name = "h";return a }
            raise TdlError.new('axis_mirrors Parameter h TdlHash cant include Proc') if h.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(h)
                unless h[:name]
                    a.name = "h"
                end
                return a }
            hash.[]=(:h,lam,false)
        end
                

        unless l.is_a? Hash
            hash.case_record(:l,l)
        else
            # hash.new_index(:l)= lambda { a = Parameter.new(l);a.name = "l";return a }
            # hash[:l] = lambda { a = Parameter.new(l);a.name = "l";return a }
            raise TdlError.new('axis_mirrors Parameter l TdlHash cant include Proc') if l.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(l)
                unless l[:name]
                    a.name = "l"
                end
                return a }
            hash.[]=(:l,lam,false)
        end
                

        unless num.is_a? Hash
            hash.case_record(:num,num)
        else
            # hash.new_index(:num)= lambda { a = Parameter.new(num);a.name = "num";return a }
            # hash[:num] = lambda { a = Parameter.new(num);a.name = "num";return a }
            raise TdlError.new('axis_mirrors Parameter num TdlHash cant include Proc') if num.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(num)
                unless num[:name]
                    a.name = "num"
                end
                return a }
            hash.[]=(:num,lam,false)
        end
                

        unless mode.is_a? Hash
            hash.case_record(:mode,mode)
        else
            # hash.new_index(:mode)= lambda { a = Parameter.new(mode);a.name = "mode";return a }
            # hash[:mode] = lambda { a = Parameter.new(mode);a.name = "mode";return a }
            raise TdlError.new('axis_mirrors Parameter mode TdlHash cant include Proc') if mode.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(mode)
                unless mode[:name]
                    a.name = "mode"
                end
                return a }
            hash.[]=(:mode,lam,false)
        end
                

        unless condition_data.is_a? Hash
            hash.case_record(:condition_data,condition_data)
        else
            # hash.new_index(:condition_data)= lambda { a = Logic.new(condition_data);a.name = "condition_data";return a }
            # hash[:condition_data] = lambda { a = Logic.new(condition_data);a.name = "condition_data";return a }
            raise TdlError.new('axis_mirrors Logic condition_data TdlHash cant include Proc') if condition_data.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(condition_data)
                unless condition_data[:name]
                    a.name = "condition_data"
                end
                return a }
            hash.[]=(:condition_data,lam,false)
        end
                

        unless axis_in.is_a? Hash
            hash.case_record(:axis_in,axis_in)
        else
            # hash.new_index(:axis_in)= lambda { a = AxiStream.new(axis_in);a.name = "axis_in";return a }
            # hash[:axis_in] = lambda { a = AxiStream.new(axis_in);a.name = "axis_in";return a }
            raise TdlError.new('axis_mirrors AxiStream axis_in TdlHash cant include Proc') if axis_in.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(axis_in)
                unless axis_in[:name]
                    a.name = "axis_in"
                end
                return a }
            hash.[]=(:axis_in,lam,false)
        end
                

        unless axis_mirror.is_a? Hash
            hash.case_record(:axis_mirror,axis_mirror)
        else
            # hash.new_index(:axis_mirror)= lambda { a = AxiStream.new(axis_mirror);a.name = "axis_mirror";return a }
            # hash[:axis_mirror] = lambda { a = AxiStream.new(axis_mirror);a.name = "axis_mirror";return a }
            raise TdlError.new('axis_mirrors AxiStream axis_mirror TdlHash cant include Proc') if axis_mirror.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(axis_mirror)
                unless axis_mirror[:name]
                    a.name = "axis_mirror"
                end
                return a }
            hash.[]=(:axis_mirror,lam,false)
        end
                

        hash.push_to_module_stack(AxiStream,:axis_mirrors)
        hash.open_error = true
        return hash
    end
end
