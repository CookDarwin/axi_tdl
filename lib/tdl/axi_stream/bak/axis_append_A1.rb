
#2017-06-21 14:20:16 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def axis_append_a1(mode:"BOTH",dsize:8,head_field_len:16*8,head_field_name:"HEAD Filed",end_field_len:16*8,end_field_name:"END Filed",enable:"enable",head_value:"head_value",end_value:"end_value",origin_in:"origin_in",append_out:"append_out",up_stream:nil,down_stream:nil)
        origin_in = up_stream if up_stream
        append_out = self

        $_draw = lambda { axis_append_a1_draw(mode:mode,dsize:dsize,head_field_len:head_field_len,head_field_name:head_field_name,end_field_len:end_field_len,end_field_name:end_field_name,enable:enable,head_value:head_value,end_value:end_value,origin_in:origin_in,append_out:append_out,up_stream:up_stream,down_stream:down_stream) }
        @correlation_proc += $_draw.call
        return self
    end

    def axis_append_a1_draw(mode:"BOTH",dsize:8,head_field_len:16*8,head_field_name:"HEAD Filed",end_field_len:16*8,end_field_name:"END Filed",enable:"enable",head_value:"head_value",end_value:"end_value",origin_in:"origin_in",append_out:"append_out",up_stream:nil,down_stream:nil)
        large_name_len(mode,dsize,head_field_len,head_field_name,end_field_len,end_field_name,enable,head_value,end_value,origin_in,append_out)
"
axis_append_A1#(
    .MODE               (#{align_signal(mode)}),
    .DSIZE              (#{align_signal(dsize)}),
    .HEAD_FIELD_LEN     (#{align_signal(head_field_len)}),
    .HEAD_FIELD_NAME    (#{align_signal(head_field_name)}),
    .END_FIELD_LEN      (#{align_signal(end_field_len)}),
    .END_FIELD_NAME     (#{align_signal(end_field_name)})
) axis_append_a1_#{signal}_inst(
/*  input                            */ .enable     (#{align_signal(enable,q_mark=false)}),
/*  input  [HEAD_FIELD_LEN*DSIZE-1:0]*/ .head_value (#{align_signal(head_value,q_mark=false)}),
/*  input  [END_FIELD_LEN*DSIZE-1:0] */ .end_value  (#{align_signal(end_value,q_mark=false)}),
/*  axi_stream_inf.slaver            */ .origin_in  (#{align_signal(origin_in,q_mark=false)}),
/*  axi_stream_inf.master            */ .append_out (#{align_signal(append_out,q_mark=false)})
);
"
    end

    def self.axis_append_a1(mode:"BOTH",dsize:8,head_field_len:16*8,head_field_name:"HEAD Filed",end_field_len:16*8,end_field_name:"END Filed",enable:"enable",head_value:"head_value",end_value:"end_value",origin_in:"origin_in",append_out:"append_out",up_stream:nil,down_stream:nil)

        if down_stream.is_a? AxiStream
            down_stream.axis_append_a1(mode:mode,dsize:dsize,head_field_len:head_field_len,head_field_name:head_field_name,end_field_len:end_field_len,end_field_name:end_field_name,enable:enable,head_value:head_value,end_value:end_value,origin_in:origin_in,append_out:append_out,up_stream:up_stream,down_stream:down_stream)
        elsif append_out.is_a? AxiStream
            append_out.axis_append_a1(mode:mode,dsize:dsize,head_field_len:head_field_len,head_field_name:head_field_name,end_field_len:end_field_len,end_field_name:end_field_name,enable:enable,head_value:head_value,end_value:end_value,origin_in:origin_in,append_out:append_out,up_stream:up_stream,down_stream:down_stream)
        else
            NC.axis_append_a1(mode:mode,dsize:dsize,head_field_len:head_field_len,head_field_name:head_field_name,end_field_len:end_field_len,end_field_name:end_field_name,enable:enable,head_value:head_value,end_value:end_value,origin_in:origin_in,append_out:append_out,up_stream:up_stream,down_stream:down_stream)
        end

    end


end


class TdlTest

    def self.test_axis_append_a1
        c0 = Clock.new(name:"axis_append_a1_clk",freqM:148.5)
        r0 = Reset.new(name:"axis_append_a1_rst_n",active:"low")

        Parameter.new(name:"mode",value:"BOTH")
        Parameter.new(name:"dsize",value:8)
        Parameter.new(name:"head_field_len",value:16*8)
        Parameter.new(name:"head_field_name",value:"HEAD Filed")
        Parameter.new(name:"end_field_len",value:16*8)
        Parameter.new(name:"end_field_name",value:"END Filed")
        Logic.new(name:"enable")
        Logic.new(name:"head_value")
        Logic.new(name:"end_value")
        AxiStream.new(name:"origin_in",clock:c0,reset:r0)
        AxiStream.new(name:"append_out",clock:c0,reset:r0)
        up_stream = origin_in
        down_stream = append_out
        AxiStream.axis_append_a1(mode:mode,dsize:dsize,head_field_len:head_field_len,head_field_name:head_field_name,end_field_len:end_field_len,end_field_name:end_field_name,enable:enable,head_value:head_value,end_value:end_value,origin_in:origin_in,append_out:append_out)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def self.inst_axis_append_a1(mode:"BOTH",dsize:8,head_field_len:16*8,head_field_name:"HEAD Filed",end_field_len:16*8,end_field_name:"END Filed",enable:"enable",head_value:"head_value",end_value:"end_value",origin_in:"origin_in",append_out:"append_out")
        hash = TdlHash.new

        unless mode.is_a? Hash
            # hash.new_index(:mode) = mode
            if mode.is_a? InfElm
                hash.[]=(:mode,mode,true)
            else
                hash.[]=(:mode,mode,false)
            end
        else
            # hash.new_index(:mode)= lambda { a = Parameter.new(mode);a.name = "mode";return a }
            # hash[:mode] = lambda { a = Parameter.new(mode);a.name = "mode";return a }
            hash.[]=(:mode,lambda { a = Parameter.new(mode);a.name = "mode";return a },false)
        end


        unless dsize.is_a? Hash
            # hash.new_index(:dsize) = dsize
            if dsize.is_a? InfElm
                hash.[]=(:dsize,dsize,true)
            else
                hash.[]=(:dsize,dsize,false)
            end
        else
            # hash.new_index(:dsize)= lambda { a = Parameter.new(dsize);a.name = "dsize";return a }
            # hash[:dsize] = lambda { a = Parameter.new(dsize);a.name = "dsize";return a }
            hash.[]=(:dsize,lambda { a = Parameter.new(dsize);a.name = "dsize";return a },false)
        end


        unless head_field_len.is_a? Hash
            # hash.new_index(:head_field_len) = head_field_len
            if head_field_len.is_a? InfElm
                hash.[]=(:head_field_len,head_field_len,true)
            else
                hash.[]=(:head_field_len,head_field_len,false)
            end
        else
            # hash.new_index(:head_field_len)= lambda { a = Parameter.new(head_field_len);a.name = "head_field_len";return a }
            # hash[:head_field_len] = lambda { a = Parameter.new(head_field_len);a.name = "head_field_len";return a }
            hash.[]=(:head_field_len,lambda { a = Parameter.new(head_field_len);a.name = "head_field_len";return a },false)
        end


        unless head_field_name.is_a? Hash
            # hash.new_index(:head_field_name) = head_field_name
            if head_field_name.is_a? InfElm
                hash.[]=(:head_field_name,head_field_name,true)
            else
                hash.[]=(:head_field_name,head_field_name,false)
            end
        else
            # hash.new_index(:head_field_name)= lambda { a = Parameter.new(head_field_name);a.name = "head_field_name";return a }
            # hash[:head_field_name] = lambda { a = Parameter.new(head_field_name);a.name = "head_field_name";return a }
            hash.[]=(:head_field_name,lambda { a = Parameter.new(head_field_name);a.name = "head_field_name";return a },false)
        end


        unless end_field_len.is_a? Hash
            # hash.new_index(:end_field_len) = end_field_len
            if end_field_len.is_a? InfElm
                hash.[]=(:end_field_len,end_field_len,true)
            else
                hash.[]=(:end_field_len,end_field_len,false)
            end
        else
            # hash.new_index(:end_field_len)= lambda { a = Parameter.new(end_field_len);a.name = "end_field_len";return a }
            # hash[:end_field_len] = lambda { a = Parameter.new(end_field_len);a.name = "end_field_len";return a }
            hash.[]=(:end_field_len,lambda { a = Parameter.new(end_field_len);a.name = "end_field_len";return a },false)
        end


        unless end_field_name.is_a? Hash
            # hash.new_index(:end_field_name) = end_field_name
            if end_field_name.is_a? InfElm
                hash.[]=(:end_field_name,end_field_name,true)
            else
                hash.[]=(:end_field_name,end_field_name,false)
            end
        else
            # hash.new_index(:end_field_name)= lambda { a = Parameter.new(end_field_name);a.name = "end_field_name";return a }
            # hash[:end_field_name] = lambda { a = Parameter.new(end_field_name);a.name = "end_field_name";return a }
            hash.[]=(:end_field_name,lambda { a = Parameter.new(end_field_name);a.name = "end_field_name";return a },false)
        end


        unless enable.is_a? Hash
            # hash.new_index(:enable) = enable
            if enable.is_a? InfElm
                hash.[]=(:enable,enable,true)
            else
                hash.[]=(:enable,enable,false)
            end
        else
            # hash.new_index(:enable)= lambda { a = Logic.new(enable);a.name = "enable";return a }
            # hash[:enable] = lambda { a = Logic.new(enable);a.name = "enable";return a }
            hash.[]=(:enable,lambda { a = Logic.new(enable);a.name = "enable";return a },false)
        end


        unless head_value.is_a? Hash
            # hash.new_index(:head_value) = head_value
            if head_value.is_a? InfElm
                hash.[]=(:head_value,head_value,true)
            else
                hash.[]=(:head_value,head_value,false)
            end
        else
            # hash.new_index(:head_value)= lambda { a = Logic.new(head_value);a.name = "head_value";return a }
            # hash[:head_value] = lambda { a = Logic.new(head_value);a.name = "head_value";return a }
            hash.[]=(:head_value,lambda { a = Logic.new(head_value);a.name = "head_value";return a },false)
        end


        unless end_value.is_a? Hash
            # hash.new_index(:end_value) = end_value
            if end_value.is_a? InfElm
                hash.[]=(:end_value,end_value,true)
            else
                hash.[]=(:end_value,end_value,false)
            end
        else
            # hash.new_index(:end_value)= lambda { a = Logic.new(end_value);a.name = "end_value";return a }
            # hash[:end_value] = lambda { a = Logic.new(end_value);a.name = "end_value";return a }
            hash.[]=(:end_value,lambda { a = Logic.new(end_value);a.name = "end_value";return a },false)
        end


        unless origin_in.is_a? Hash
            # hash.new_index(:origin_in) = origin_in
            if origin_in.is_a? InfElm
                hash.[]=(:origin_in,origin_in,true)
            else
                hash.[]=(:origin_in,origin_in,false)
            end
        else
            # hash.new_index(:origin_in)= lambda { a = AxiStream.new(origin_in);a.name = "origin_in";return a }
            # hash[:origin_in] = lambda { a = AxiStream.new(origin_in);a.name = "origin_in";return a }
            hash.[]=(:origin_in,lambda { a = AxiStream.new(origin_in);a.name = "origin_in";return a },false)
        end


        unless append_out.is_a? Hash
            # hash.new_index(:append_out) = append_out
            if append_out.is_a? InfElm
                hash.[]=(:append_out,append_out,true)
            else
                hash.[]=(:append_out,append_out,false)
            end
        else
            # hash.new_index(:append_out)= lambda { a = AxiStream.new(append_out);a.name = "append_out";return a }
            # hash[:append_out] = lambda { a = AxiStream.new(append_out);a.name = "append_out";return a }
            hash.[]=(:append_out,lambda { a = AxiStream.new(append_out);a.name = "append_out";return a },false)
        end


        Tdl.module_stack  << lambda {
            hash.each do |k,v|
                if v.is_a? Proc
                    hash.[]=(k,v.call,false)
                elsif v.is_a? Array
                    unless v.empty?
                        if v[0].is_a? Axi4
                            cm = v[0].copy(name:k,idsize:Math.log2(v.length).ceil+v[0].idsize)
                        else
                            cm = v[0].copy(name:k)
                        end
                        cm.<<(*v)
                        # hash[k] = cm
                        hash.[]=(k,cm)
                    else
                        hash.[]=(k,nil,false)
                    end
                else
                    # hash[k] = v
                end
            end
            hash.check_use("axis_append_a1")
            AxiStream.axis_append_a1(hash)
        }
        return hash
    end
end
