
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def axis_append(mode:"BOTH",dsize:8,head_field_len:16*8,head_field_name:"HEAD Filed",end_field_len:16*8,end_field_name:"END Filed",head_value:"head_value",end_value:"end_value",origin_in:"origin_in",append_out:"append_out",up_stream:nil,down_stream:nil)

        Tdl.add_to_all_file_paths(['axis_append','../../axi/AXI_stream/axis_append.sv'])
        return_stream = self
        
        origin_in = AxiStream.same_name_socket(:from_up,mix=true,origin_in) unless origin_in.is_a? String
        append_out = AxiStream.same_name_socket(:to_down,mix=true,append_out) unless append_out.is_a? String
        
        if up_stream==nil && origin_in=="origin_in"
            up_stream = self.copy(name:"origin_in")
            return_stream = up_stream
        end

        origin_in = up_stream if up_stream
        append_out = self unless self==AxiStream.NC

         @instance_draw_stack << lambda { axis_append_draw(mode:mode,dsize:dsize,head_field_len:head_field_len,head_field_name:head_field_name,end_field_len:end_field_len,end_field_name:end_field_name,head_value:head_value,end_value:end_value,origin_in:origin_in,append_out:append_out,up_stream:up_stream,down_stream:down_stream) }
        return return_stream
    end

    def axis_append_draw(mode:"BOTH",dsize:8,head_field_len:16*8,head_field_name:"HEAD Filed",end_field_len:16*8,end_field_name:"END Filed",head_value:"head_value",end_value:"end_value",origin_in:"origin_in",append_out:"append_out",up_stream:nil,down_stream:nil)

        large_name_len(mode,dsize,head_field_len,head_field_name,end_field_len,end_field_name,head_value,end_value,origin_in,append_out)
"
// FilePath:::../../axi/AXI_stream/axis_append.sv
axis_append#(
    .MODE               (#{align_signal(mode)}),
    .DSIZE              (#{align_signal(dsize)}),
    .HEAD_FIELD_LEN     (#{align_signal(head_field_len)}),
    .HEAD_FIELD_NAME    (#{align_signal(head_field_name)}),
    .END_FIELD_LEN      (#{align_signal(end_field_len)}),
    .END_FIELD_NAME     (#{align_signal(end_field_name)})
) axis_append_#{signal}_inst(
/*  input  [HEAD_FIELD_LEN*DSIZE-1:0]*/ .head_value (#{align_signal(head_value,q_mark=false)}),
/*  input  [END_FIELD_LEN*DSIZE-1:0] */ .end_value  (#{align_signal(end_value,q_mark=false)}),
/*  axi_stream_inf.slaver            */ .origin_in  (#{align_signal(origin_in,q_mark=false)}),
/*  axi_stream_inf.master            */ .append_out (#{align_signal(append_out,q_mark=false)})
);
"
    end
    
    def self.axis_append(mode:"BOTH",dsize:8,head_field_len:16*8,head_field_name:"HEAD Filed",end_field_len:16*8,end_field_name:"END Filed",head_value:"head_value",end_value:"end_value",origin_in:"origin_in",append_out:"append_out",up_stream:nil,down_stream:nil)
        return_stream = nil
        
        if down_stream==nil && append_out=="append_out"
            if up_stream.is_a? AxiStream
                down_stream = up_stream.copy(name:"append_out")
            else
                down_stream = origin_in.copy(name:"append_out")
            end
            return_stream = down_stream
        end

        
        if up_stream==nil && origin_in=="origin_in"
            if down_stream.is_a? AxiStream
                up_stream = down_stream.copy(name:"origin_in")
            else
                up_stream = append_out.copy(name:"origin_in")
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? AxiStream
            down_stream.axis_append(mode:mode,dsize:dsize,head_field_len:head_field_len,head_field_name:head_field_name,end_field_len:end_field_len,end_field_name:end_field_name,head_value:head_value,end_value:end_value,origin_in:origin_in,append_out:append_out,up_stream:up_stream,down_stream:down_stream)
        elsif append_out.is_a? AxiStream
            append_out.axis_append(mode:mode,dsize:dsize,head_field_len:head_field_len,head_field_name:head_field_name,end_field_len:end_field_len,end_field_name:end_field_name,head_value:head_value,end_value:end_value,origin_in:origin_in,append_out:append_out,up_stream:up_stream,down_stream:down_stream)
        else
            AxiStream.NC.axis_append(mode:mode,dsize:dsize,head_field_len:head_field_len,head_field_name:head_field_name,end_field_len:end_field_len,end_field_name:end_field_name,head_value:head_value,end_value:end_value,origin_in:origin_in,append_out:append_out,up_stream:up_stream,down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_axis_append
        c0 = Clock.new(name:"axis_append_clk",freqM:148.5)
        r0 = Reset.new(name:"axis_append_rst_n",active:"low")

        mode = Parameter.new(name:"mode",value:"BOTH")
        dsize = Parameter.new(name:"dsize",value:8)
        head_field_len = Parameter.new(name:"head_field_len",value:16*8)
        head_field_name = Parameter.new(name:"head_field_name",value:"HEAD Filed")
        end_field_len = Parameter.new(name:"end_field_len",value:16*8)
        end_field_name = Parameter.new(name:"end_field_name",value:"END Filed")
        head_value = Logic.new(name:"head_value")
        end_value = Logic.new(name:"end_value")
        origin_in = AxiStream.new(name:"origin_in",clock:c0,reset:r0)
        append_out = AxiStream.new(name:"append_out",clock:c0,reset:r0)
        up_stream = origin_in
        down_stream = append_out
        AxiStream.axis_append(mode:mode,dsize:dsize,head_field_len:head_field_len,head_field_name:head_field_name,end_field_len:end_field_len,end_field_name:end_field_name,head_value:head_value,end_value:end_value,origin_in:origin_in,append_out:append_out)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axis_append(
        mode:"BOTH",
        dsize:8,
        head_field_len:16*8,
        head_field_name:"HEAD Filed",
        end_field_len:16*8,
        end_field_name:"END Filed",
        head_value:"head_value",
        end_value:"end_value",
        origin_in:"origin_in",
        append_out:"append_out")
        hash = TdlHash.new
        
        unless mode.is_a? Hash
            hash.case_record(:mode,mode)
        else
            # hash.new_index(:mode)= lambda { a = Parameter.new(mode);a.name = "mode";return a }
            # hash[:mode] = lambda { a = Parameter.new(mode);a.name = "mode";return a }
            raise TdlError.new('axis_append Parameter mode TdlHash cant include Proc') if mode.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(mode)
                unless mode[:name]
                    a.name = "mode"
                end
                return a }
            hash.[]=(:mode,lam,false)
        end
                

        unless dsize.is_a? Hash
            hash.case_record(:dsize,dsize)
        else
            # hash.new_index(:dsize)= lambda { a = Parameter.new(dsize);a.name = "dsize";return a }
            # hash[:dsize] = lambda { a = Parameter.new(dsize);a.name = "dsize";return a }
            raise TdlError.new('axis_append Parameter dsize TdlHash cant include Proc') if dsize.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(dsize)
                unless dsize[:name]
                    a.name = "dsize"
                end
                return a }
            hash.[]=(:dsize,lam,false)
        end
                

        unless head_field_len.is_a? Hash
            hash.case_record(:head_field_len,head_field_len)
        else
            # hash.new_index(:head_field_len)= lambda { a = Parameter.new(head_field_len);a.name = "head_field_len";return a }
            # hash[:head_field_len] = lambda { a = Parameter.new(head_field_len);a.name = "head_field_len";return a }
            raise TdlError.new('axis_append Parameter head_field_len TdlHash cant include Proc') if head_field_len.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(head_field_len)
                unless head_field_len[:name]
                    a.name = "head_field_len"
                end
                return a }
            hash.[]=(:head_field_len,lam,false)
        end
                

        unless head_field_name.is_a? Hash
            hash.case_record(:head_field_name,head_field_name)
        else
            # hash.new_index(:head_field_name)= lambda { a = Parameter.new(head_field_name);a.name = "head_field_name";return a }
            # hash[:head_field_name] = lambda { a = Parameter.new(head_field_name);a.name = "head_field_name";return a }
            raise TdlError.new('axis_append Parameter head_field_name TdlHash cant include Proc') if head_field_name.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(head_field_name)
                unless head_field_name[:name]
                    a.name = "head_field_name"
                end
                return a }
            hash.[]=(:head_field_name,lam,false)
        end
                

        unless end_field_len.is_a? Hash
            hash.case_record(:end_field_len,end_field_len)
        else
            # hash.new_index(:end_field_len)= lambda { a = Parameter.new(end_field_len);a.name = "end_field_len";return a }
            # hash[:end_field_len] = lambda { a = Parameter.new(end_field_len);a.name = "end_field_len";return a }
            raise TdlError.new('axis_append Parameter end_field_len TdlHash cant include Proc') if end_field_len.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(end_field_len)
                unless end_field_len[:name]
                    a.name = "end_field_len"
                end
                return a }
            hash.[]=(:end_field_len,lam,false)
        end
                

        unless end_field_name.is_a? Hash
            hash.case_record(:end_field_name,end_field_name)
        else
            # hash.new_index(:end_field_name)= lambda { a = Parameter.new(end_field_name);a.name = "end_field_name";return a }
            # hash[:end_field_name] = lambda { a = Parameter.new(end_field_name);a.name = "end_field_name";return a }
            raise TdlError.new('axis_append Parameter end_field_name TdlHash cant include Proc') if end_field_name.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(end_field_name)
                unless end_field_name[:name]
                    a.name = "end_field_name"
                end
                return a }
            hash.[]=(:end_field_name,lam,false)
        end
                

        unless head_value.is_a? Hash
            hash.case_record(:head_value,head_value)
        else
            # hash.new_index(:head_value)= lambda { a = Logic.new(head_value);a.name = "head_value";return a }
            # hash[:head_value] = lambda { a = Logic.new(head_value);a.name = "head_value";return a }
            raise TdlError.new('axis_append Logic head_value TdlHash cant include Proc') if head_value.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(head_value)
                unless head_value[:name]
                    a.name = "head_value"
                end
                return a }
            hash.[]=(:head_value,lam,false)
        end
                

        unless end_value.is_a? Hash
            hash.case_record(:end_value,end_value)
        else
            # hash.new_index(:end_value)= lambda { a = Logic.new(end_value);a.name = "end_value";return a }
            # hash[:end_value] = lambda { a = Logic.new(end_value);a.name = "end_value";return a }
            raise TdlError.new('axis_append Logic end_value TdlHash cant include Proc') if end_value.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(end_value)
                unless end_value[:name]
                    a.name = "end_value"
                end
                return a }
            hash.[]=(:end_value,lam,false)
        end
                

        unless origin_in.is_a? Hash
            hash.case_record(:origin_in,origin_in)
        else
            # hash.new_index(:origin_in)= lambda { a = AxiStream.new(origin_in);a.name = "origin_in";return a }
            # hash[:origin_in] = lambda { a = AxiStream.new(origin_in);a.name = "origin_in";return a }
            raise TdlError.new('axis_append AxiStream origin_in TdlHash cant include Proc') if origin_in.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(origin_in)
                unless origin_in[:name]
                    a.name = "origin_in"
                end
                return a }
            hash.[]=(:origin_in,lam,false)
        end
                

        unless append_out.is_a? Hash
            hash.case_record(:append_out,append_out)
        else
            # hash.new_index(:append_out)= lambda { a = AxiStream.new(append_out);a.name = "append_out";return a }
            # hash[:append_out] = lambda { a = AxiStream.new(append_out);a.name = "append_out";return a }
            raise TdlError.new('axis_append AxiStream append_out TdlHash cant include Proc') if append_out.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(append_out)
                unless append_out[:name]
                    a.name = "append_out"
                end
                return a }
            hash.[]=(:append_out,lam,false)
        end
                

        hash.push_to_module_stack(AxiStream,:axis_append)
        hash.open_error = true
        return hash
    end
end
