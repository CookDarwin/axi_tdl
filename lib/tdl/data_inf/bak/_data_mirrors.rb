
#2017-07-31 13:06:50 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class DataInf_C


    def data_mirrors(h:0,l:0,mode:"CDS_MODE",condition_data:"condition_data",data_in:"data_in",data_mirror:"data_mirror",up_stream:nil,down_stream:nil)
        return_stream = self

        if data_mirror.is_a? DataInf_C
            data_mirror = [data_mirror]
        elsif data_mirror.is_a? DataInf
            data_mirror = [data_mirror.to_data_inf_c()]
        end

        unless data_mirror.is_a? Array
            raise TdlError.new("DATA_MIRROR must a Array")
        end

        num = data_mirror.length

        data_in = DataInf_C.same_name_socket(:from_up,mix=true,data_in)

        data_mirror = DataInf_C.same_name_socket(:to_down,mix=false,data_mirror)

        # puts data_mirror.signal
        if up_stream==nil && data_in=="data_in"
            up_stream = self.copy(name:"data_in")
            return_stream = up_stream
        end

        data_in = up_stream if up_stream
        data_mirror = self unless self==DataInf_C.NC

        $_draw = lambda { data_mirrors_draw(h:h,l:l,num:num,mode:mode,condition_data:condition_data,data_in:data_in,data_mirror:data_mirror,up_stream:up_stream,down_stream:down_stream) }
        @correlation_proc += $_draw.call
        return return_stream
    end

    def data_mirrors_draw(h:0,l:0,num:8,mode:"CDS_MODE",condition_data:"condition_data",data_in:"data_in",data_mirror:"data_mirror",up_stream:nil,down_stream:nil)
        large_name_len(h,l,num,mode,condition_data,data_in,data_mirror)
"
data_mirrors#(
    .H       (#{align_signal(h)}),
    .L       (#{align_signal(l)}),
    .NUM     (#{align_signal(num)}),
    .MODE    (#{align_signal(mode)})
) data_mirrors_#{signal}_inst(
/*  input  [H:L]     */ .condition_data (#{align_signal(condition_data,q_mark=false)}),
/*  data_inf_c.slaver*/ .data_in        (#{align_signal(data_in,q_mark=false)}),
/*  data_inf_c.master*/ .data_mirror    (#{align_signal(data_mirror,q_mark=false)})
);
"
    end

    def self.data_mirrors(h:0,l:0,mode:"CDS_MODE",condition_data:"condition_data",data_in:"data_in",data_mirror:"data_mirror",up_stream:nil,down_stream:nil)
        return_stream = nil
        # p data_mirror
        if down_stream==nil && data_mirror=="data_mirror"
            if up_stream.is_a? DataInf_C
                down_stream = up_stream.copy(name:"data_mirror")
            else
                down_stream = data_in.copy(name:"data_mirror")
            end
            return_stream = down_stream
        end


        if up_stream==nil && data_in=="data_in"
            if down_stream.is_a? DataInf_C
                up_stream = down_stream.copy(name:"data_in")
            else
                up_stream = data_mirror.copy(name:"data_in")
            end
            return_stream = up_stream
        end

        if down_stream.is_a? DataInf_C
            down_stream.data_mirrors(h:h,l:l,mode:mode,condition_data:condition_data,data_in:data_in,data_mirror:data_mirror,up_stream:up_stream,down_stream:down_stream)
        elsif data_mirror.is_a? DataInf_C
            data_mirror.data_mirrors(h:h,l:l,mode:mode,condition_data:condition_data,data_in:data_in,data_mirror:data_mirror,up_stream:up_stream,down_stream:down_stream)
        else
            NC.data_mirrors(h:h,l:l,mode:mode,condition_data:condition_data,data_in:data_in,data_mirror:data_mirror,up_stream:up_stream,down_stream:down_stream)
        end
        return return_stream
    end


end


class TdlTest

    def self.test_data_mirrors
        c0 = Clock.new(name:"data_mirrors_clk",freqM:148.5)
        r0 = Reset.new(name:"data_mirrors_rst_n",active:"low")

        Parameter.new(name:"h",value:0)
        Parameter.new(name:"l",value:0)
        Parameter.new(name:"num",value:8)
        Parameter.new(name:"mode",value:"CDS_MODE")
        Logic.new(name:"condition_data")
        DataInf_C.new(name:"data_in",clock:c0,reset:r0)
        DataInf_C.new(name:"data_mirror",clock:c0,reset:r0)
        up_stream = data_in
        down_stream = data_mirror
        DataInf_C.data_mirrors(h:h,l:l,num:num,mode:mode,condition_data:condition_data,data_in:data_in,data_mirror:data_mirror)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_data_mirrors(
        h:0,
        l:0,
        mode:"CDS_MODE",
        condition_data:"condition_data",
        data_in:"data_in",
        data_mirror:"data_mirror")
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


        unless data_in.is_a? Hash
            # hash.new_index(:data_in) = data_in
            if data_in.is_a? BaseElm
                hash.[]=(:data_in,data_in,true)
            else
                hash.[]=(:data_in,data_in,false)
            end
        else
            # hash.new_index(:data_in)= lambda { a = DataInf_C.new(data_in);a.name = "data_in";return a }
            # hash[:data_in] = lambda { a = DataInf_C.new(data_in);a.name = "data_in";return a }
            lam = lambda {
                a = DataInf_C.new(data_in)
                unless data_in[:name]
                    a.name = "data_in"
                end
                return a }
            hash.[]=(:data_in,lam,false)
        end

        unless data_mirror.is_a? Hash
            # hash.new_index(:data_mirror) = data_mirror
            if data_mirror.is_a? BaseElm
                hash.[]=(:data_mirror,data_mirror,true)
            else
                hash.[]=(:data_mirror,data_mirror,false)
            end
        else
            # hash.new_index(:data_mirror)= lambda { a = DataInf_C.new(data_mirror);a.name = "data_mirror";return a }
            # hash[:data_mirror] = lambda { a = DataInf_C.new(data_mirror);a.name = "data_mirror";return a }
            lam = lambda {
                a = DataInf_C.new(data_mirror)
                unless data_mirror[:name]
                    a.name = "data_mirror"
                end
                return a }
            hash.[]=(:data_mirror,lam,false)
        end

        # p data_mirror

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
            hash.check_use("data_mirrors")
            DataInf_C.data_mirrors(hash)
        }
        return hash
    end
end
