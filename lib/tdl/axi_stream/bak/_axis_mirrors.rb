
#2017-08-02 18:21:53 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def axis_mirrors(h:0,l:0,mode:"CDS_MODE",condition_data:"condition_data",axis_in:"axis_in",axis_mirror:"axis_mirror",up_stream:nil,down_stream:nil)
        return_stream = self

        if axis_mirror.is_a? AxiStream
            axis_mirror = [axis_mirror]
        end

        unless axis_mirror.is_a? Array
            raise TdlError.new("AXIS_MIRROR must a Array")
        end

        num = axis_mirror.length

        axis_in = AxiStream.same_name_socket(:from_up,mix=true,axis_in)
        axis_mirror = AxiStream.same_name_socket(:to_down,mix=false,axis_mirror)

        if up_stream==nil && axis_in=="axis_in"
            up_stream = self.copy(name:"axis_in")
            return_stream = up_stream
        end

        axis_in = up_stream if up_stream
        axis_mirror = self unless self==AxiStream.NC

        $_draw = lambda { axis_mirrors_draw(h:h,l:l,num:num,mode:mode,condition_data:condition_data,axis_in:axis_in,axis_mirror:axis_mirror,up_stream:up_stream,down_stream:down_stream) }
        @correlation_proc += $_draw.call
        return return_stream
    end

    def axis_mirrors_draw(h:0,l:0,num:8,mode:"CDS_MODE",condition_data:"condition_data",axis_in:"axis_in",axis_mirror:"axis_mirror",up_stream:nil,down_stream:nil)
        large_name_len(h,l,num,mode,condition_data,axis_in,axis_mirror)
"
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

    def self.axis_mirrors(h:0,l:0,mode:"CDS_MODE",condition_data:"condition_data",axis_in:"axis_in",axis_mirror:"axis_mirror",up_stream:nil,down_stream:nil)
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
            down_stream.axis_mirrors(h:h,l:l,mode:mode,condition_data:condition_data,axis_in:axis_in,axis_mirror:axis_mirror,up_stream:up_stream,down_stream:down_stream)
        elsif axis_mirror.is_a? AxiStream
            axis_mirror.axis_mirrors(h:h,l:l,mode:mode,condition_data:condition_data,axis_in:axis_in,axis_mirror:axis_mirror,up_stream:up_stream,down_stream:down_stream)
        else
            NC.axis_mirrors(h:h,l:l,mode:mode,condition_data:condition_data,axis_in:axis_in,axis_mirror:axis_mirror,up_stream:up_stream,down_stream:down_stream)
        end
        return return_stream
    end


end


class TdlTest

    def self.test_axis_mirrors
        c0 = Clock.new(name:"axis_mirrors_clk",freqM:148.5)
        r0 = Reset.new(name:"axis_mirrors_rst_n",active:"low")

        Parameter.new(name:"h",value:0)
        Parameter.new(name:"l",value:0)
        Parameter.new(name:"num",value:8)
        Parameter.new(name:"mode",value:"CDS_MODE")
        Logic.new(name:"condition_data")
        AxiStream.new(name:"axis_in",clock:c0,reset:r0)
        AxiStream.new(name:"axis_mirror",clock:c0,reset:r0)
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
        mode:"CDS_MODE",
        condition_data:"condition_data",
        axis_in:"axis_in",
        axis_mirror:"axis_mirror")
        hash = TdlHash.new

        unless h.is_a? Hash
            # hash.new_index(:h) = h
            if h.is_a? BaseElm
                hash.[]=(:h,h,true)
            else
                hash.[]=(:h,h,false)
            end
        else
            # hash.new_index(:h)= lambda { a = Parameter.new(h);a.name = "h";return a }
            # hash[:h] = lambda { a = Parameter.new(h);a.name = "h";return a }
            lam = lambda {
                a = Parameter.new(h)
                unless h[:name]
                    a.name = "h"
                end
                return a }
            hash.[]=(:h,lam,false)
        end


        unless l.is_a? Hash
            # hash.new_index(:l) = l
            if l.is_a? BaseElm
                hash.[]=(:l,l,true)
            else
                hash.[]=(:l,l,false)
            end
        else
            # hash.new_index(:l)= lambda { a = Parameter.new(l);a.name = "l";return a }
            # hash[:l] = lambda { a = Parameter.new(l);a.name = "l";return a }
            lam = lambda {
                a = Parameter.new(l)
                unless l[:name]
                    a.name = "l"
                end
                return a }
            hash.[]=(:l,lam,false)
        end


        unless mode.is_a? Hash
            # hash.new_index(:mode) = mode
            if mode.is_a? BaseElm
                hash.[]=(:mode,mode,true)
            else
                hash.[]=(:mode,mode,false)
            end
        else
            # hash.new_index(:mode)= lambda { a = Parameter.new(mode);a.name = "mode";return a }
            # hash[:mode] = lambda { a = Parameter.new(mode);a.name = "mode";return a }
            lam = lambda {
                a = Parameter.new(mode)
                unless mode[:name]
                    a.name = "mode"
                end
                return a }
            hash.[]=(:mode,lam,false)
        end


        unless condition_data.is_a? Hash
            # hash.new_index(:condition_data) = condition_data
            if condition_data.is_a? BaseElm
                hash.[]=(:condition_data,condition_data,true)
            else
                hash.[]=(:condition_data,condition_data,false)
            end
        else
            # hash.new_index(:condition_data)= lambda { a = Logic.new(condition_data);a.name = "condition_data";return a }
            # hash[:condition_data] = lambda { a = Logic.new(condition_data);a.name = "condition_data";return a }
            lam = lambda {
                a = Logic.new(condition_data)
                unless condition_data[:name]
                    a.name = "condition_data"
                end
                return a }
            hash.[]=(:condition_data,lam,false)
        end


        unless axis_in.is_a? Hash
            # hash.new_index(:axis_in) = axis_in
            if axis_in.is_a? BaseElm
                hash.[]=(:axis_in,axis_in,true)
            else
                hash.[]=(:axis_in,axis_in,false)
            end
        else
            # hash.new_index(:axis_in)= lambda { a = AxiStream.new(axis_in);a.name = "axis_in";return a }
            # hash[:axis_in] = lambda { a = AxiStream.new(axis_in);a.name = "axis_in";return a }
            lam = lambda {
                a = AxiStream.new(axis_in)
                unless axis_in[:name]
                    a.name = "axis_in"
                end
                return a }
            hash.[]=(:axis_in,lam,false)
        end


        unless axis_mirror.is_a? Hash
            # hash.new_index(:axis_mirror) = axis_mirror
            if axis_mirror.is_a? BaseElm
                hash.[]=(:axis_mirror,axis_mirror,true)
            else
                hash.[]=(:axis_mirror,axis_mirror,false)
            end
        else
            # hash.new_index(:axis_mirror)= lambda { a = AxiStream.new(axis_mirror);a.name = "axis_mirror";return a }
            # hash[:axis_mirror] = lambda { a = AxiStream.new(axis_mirror);a.name = "axis_mirror";return a }
            lam = lambda {
                a = AxiStream.new(axis_mirror)
                unless axis_mirror[:name]
                    a.name = "axis_mirror"
                end
                return a }
            hash.[]=(:axis_mirror,lam,false)
        end


        Tdl.module_stack  << lambda {
            hash.each do |k,v|
                if v.is_a? Proc
                    hash.[]=(k,v.call,false)
                elsif v.is_a? Array
                #    unless v.empty?
                #        if v[0].is_a? Axi4
                #            cm = v[0].copy(name:k,idsize:Math.log2(v.length).ceil+v[0].idsize)
                #        else
                #            cm = v[0].copy(name:k)
                #        end
                #        cm.<<(*v)
                #        # hash[k] = cm
                #        hash.[]=(k,cm)
                #    else
                #        hash.[]=(k,nil,false)
                #    end
                else
                    # hash[k] = v
                end
            end
            hash.check_use("axis_mirrors")
            AxiStream.axis_mirrors(hash)
        }
        return hash
    end
end
