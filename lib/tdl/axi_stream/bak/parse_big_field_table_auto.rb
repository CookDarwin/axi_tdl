
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def parse_big_field_table(dsize:8,field_len:16*8,field_name:"Big Filed",try_parse:"OFF",enable:"enable",value:"value",out_valid:"out_valid",cm_tb_s:"cm_tb_s",cm_tb_m:"cm_tb_m",cm_mirror:"cm_mirror",up_stream:nil,down_stream:nil)

        Tdl.add_to_all_file_paths(['parse_big_field_table','../../axi/AXI_stream/parse_big_field_table.sv'])
        return_stream = self
        
        cm_tb_s = AxiStream.same_name_socket(:from_up,mix=true,cm_tb_s) unless cm_tb_s.is_a? String
        cm_tb_m = AxiStream.same_name_socket(:to_down,mix=true,cm_tb_m) unless cm_tb_m.is_a? String
        cm_mirror = AxiStream.same_name_socket(:mirror,mix=true,cm_mirror) unless cm_mirror.is_a? String
        
        if up_stream==nil && cm_tb_s=="cm_tb_s"
            up_stream = self.copy(name:"cm_tb_s")
            return_stream = up_stream
        end

        cm_tb_s = up_stream if up_stream
        cm_tb_m = self unless self==AxiStream.NC

         @instance_draw_stack << lambda { parse_big_field_table_draw(dsize:dsize,field_len:field_len,field_name:field_name,try_parse:try_parse,enable:enable,value:value,out_valid:out_valid,cm_tb_s:cm_tb_s,cm_tb_m:cm_tb_m,cm_mirror:cm_mirror,up_stream:up_stream,down_stream:down_stream) }
        return return_stream
    end

    def parse_big_field_table_draw(dsize:8,field_len:16*8,field_name:"Big Filed",try_parse:"OFF",enable:"enable",value:"value",out_valid:"out_valid",cm_tb_s:"cm_tb_s",cm_tb_m:"cm_tb_m",cm_mirror:"cm_mirror",up_stream:nil,down_stream:nil)

        large_name_len(dsize,field_len,field_name,try_parse,enable,value,out_valid,cm_tb_s,cm_tb_m,cm_mirror)
"
// FilePath:::../../axi/AXI_stream/parse_big_field_table.sv
parse_big_field_table#(
    .DSIZE         (#{align_signal(dsize)}),
    .FIELD_LEN     (#{align_signal(field_len)}),
    .FIELD_NAME    (#{align_signal(field_name)}),
    .TRY_PARSE     (#{align_signal(try_parse)})
) parse_big_field_table_#{signal}_inst(
/*  input                       */ .enable    (#{align_signal(enable,q_mark=false)}),
/*  output [DSIZE*FIELD_LEN-1:0]*/ .value     (#{align_signal(value,q_mark=false)}),
/*  output                      */ .out_valid (#{align_signal(out_valid,q_mark=false)}),
/*  axi_stream_inf.slaver       */ .cm_tb_s   (#{align_signal(cm_tb_s,q_mark=false)}),
/*  axi_stream_inf.master       */ .cm_tb_m   (#{align_signal(cm_tb_m,q_mark=false)}),
/*  axi_stream_inf.mirror       */ .cm_mirror (#{align_signal(cm_mirror,q_mark=false)})
);
"
    end
    
    def self.parse_big_field_table(dsize:8,field_len:16*8,field_name:"Big Filed",try_parse:"OFF",enable:"enable",value:"value",out_valid:"out_valid",cm_tb_s:"cm_tb_s",cm_tb_m:"cm_tb_m",cm_mirror:"cm_mirror",up_stream:nil,down_stream:nil)
        return_stream = nil
        
        if down_stream==nil && cm_tb_m=="cm_tb_m"
            if up_stream.is_a? AxiStream
                down_stream = up_stream.copy(name:"cm_tb_m")
            else
                down_stream = cm_tb_s.copy(name:"cm_tb_m")
            end
            return_stream = down_stream
        end

        
        if up_stream==nil && cm_tb_s=="cm_tb_s"
            if down_stream.is_a? AxiStream
                up_stream = down_stream.copy(name:"cm_tb_s")
            else
                up_stream = cm_tb_m.copy(name:"cm_tb_s")
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? AxiStream
            down_stream.parse_big_field_table(dsize:dsize,field_len:field_len,field_name:field_name,try_parse:try_parse,enable:enable,value:value,out_valid:out_valid,cm_tb_s:cm_tb_s,cm_tb_m:cm_tb_m,cm_mirror:cm_mirror,up_stream:up_stream,down_stream:down_stream)
        elsif cm_tb_m.is_a? AxiStream
            cm_tb_m.parse_big_field_table(dsize:dsize,field_len:field_len,field_name:field_name,try_parse:try_parse,enable:enable,value:value,out_valid:out_valid,cm_tb_s:cm_tb_s,cm_tb_m:cm_tb_m,cm_mirror:cm_mirror,up_stream:up_stream,down_stream:down_stream)
        else
            AxiStream.NC.parse_big_field_table(dsize:dsize,field_len:field_len,field_name:field_name,try_parse:try_parse,enable:enable,value:value,out_valid:out_valid,cm_tb_s:cm_tb_s,cm_tb_m:cm_tb_m,cm_mirror:cm_mirror,up_stream:up_stream,down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_parse_big_field_table
        c0 = Clock.new(name:"parse_big_field_table_clk",freqM:148.5)
        r0 = Reset.new(name:"parse_big_field_table_rst_n",active:"low")

        dsize = Parameter.new(name:"dsize",value:8)
        field_len = Parameter.new(name:"field_len",value:16*8)
        field_name = Parameter.new(name:"field_name",value:"Big Filed")
        try_parse = Parameter.new(name:"try_parse",value:"OFF")
        enable = Logic.new(name:"enable")
        value = Logic.new(name:"value")
        out_valid = Logic.new(name:"out_valid")
        cm_tb_s = AxiStream.new(name:"cm_tb_s",clock:c0,reset:r0)
        cm_tb_m = AxiStream.new(name:"cm_tb_m",clock:c0,reset:r0)
        cm_mirror = AxiStream.new(name:"cm_mirror",clock:c0,reset:r0)
        up_stream = cm_tb_s
        down_stream = cm_tb_m
        AxiStream.parse_big_field_table(dsize:dsize,field_len:field_len,field_name:field_name,try_parse:try_parse,enable:enable,value:value,out_valid:out_valid,cm_tb_s:cm_tb_s,cm_tb_m:cm_tb_m,cm_mirror:cm_mirror)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_parse_big_field_table(
        dsize:8,
        field_len:16*8,
        field_name:"Big Filed",
        try_parse:"OFF",
        enable:"enable",
        value:"value",
        out_valid:"out_valid",
        cm_tb_s:"cm_tb_s",
        cm_tb_m:"cm_tb_m",
        cm_mirror:"cm_mirror")
        hash = TdlHash.new
        
        unless dsize.is_a? Hash
            hash.case_record(:dsize,dsize)
        else
            # hash.new_index(:dsize)= lambda { a = Parameter.new(dsize);a.name = "dsize";return a }
            # hash[:dsize] = lambda { a = Parameter.new(dsize);a.name = "dsize";return a }
            raise TdlError.new('parse_big_field_table Parameter dsize TdlHash cant include Proc') if dsize.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(dsize)
                unless dsize[:name]
                    a.name = "dsize"
                end
                return a }
            hash.[]=(:dsize,lam,false)
        end
                

        unless field_len.is_a? Hash
            hash.case_record(:field_len,field_len)
        else
            # hash.new_index(:field_len)= lambda { a = Parameter.new(field_len);a.name = "field_len";return a }
            # hash[:field_len] = lambda { a = Parameter.new(field_len);a.name = "field_len";return a }
            raise TdlError.new('parse_big_field_table Parameter field_len TdlHash cant include Proc') if field_len.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(field_len)
                unless field_len[:name]
                    a.name = "field_len"
                end
                return a }
            hash.[]=(:field_len,lam,false)
        end
                

        unless field_name.is_a? Hash
            hash.case_record(:field_name,field_name)
        else
            # hash.new_index(:field_name)= lambda { a = Parameter.new(field_name);a.name = "field_name";return a }
            # hash[:field_name] = lambda { a = Parameter.new(field_name);a.name = "field_name";return a }
            raise TdlError.new('parse_big_field_table Parameter field_name TdlHash cant include Proc') if field_name.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(field_name)
                unless field_name[:name]
                    a.name = "field_name"
                end
                return a }
            hash.[]=(:field_name,lam,false)
        end
                

        unless try_parse.is_a? Hash
            hash.case_record(:try_parse,try_parse)
        else
            # hash.new_index(:try_parse)= lambda { a = Parameter.new(try_parse);a.name = "try_parse";return a }
            # hash[:try_parse] = lambda { a = Parameter.new(try_parse);a.name = "try_parse";return a }
            raise TdlError.new('parse_big_field_table Parameter try_parse TdlHash cant include Proc') if try_parse.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(try_parse)
                unless try_parse[:name]
                    a.name = "try_parse"
                end
                return a }
            hash.[]=(:try_parse,lam,false)
        end
                

        unless enable.is_a? Hash
            hash.case_record(:enable,enable)
        else
            # hash.new_index(:enable)= lambda { a = Logic.new(enable);a.name = "enable";return a }
            # hash[:enable] = lambda { a = Logic.new(enable);a.name = "enable";return a }
            raise TdlError.new('parse_big_field_table Logic enable TdlHash cant include Proc') if enable.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(enable)
                unless enable[:name]
                    a.name = "enable"
                end
                return a }
            hash.[]=(:enable,lam,false)
        end
                

        unless value.is_a? Hash
            hash.case_record(:value,value)
        else
            # hash.new_index(:value)= lambda { a = Logic.new(value);a.name = "value";return a }
            # hash[:value] = lambda { a = Logic.new(value);a.name = "value";return a }
            raise TdlError.new('parse_big_field_table Logic value TdlHash cant include Proc') if value.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(value)
                unless value[:name]
                    a.name = "value"
                end
                return a }
            hash.[]=(:value,lam,false)
        end
                

        unless out_valid.is_a? Hash
            hash.case_record(:out_valid,out_valid)
        else
            # hash.new_index(:out_valid)= lambda { a = Logic.new(out_valid);a.name = "out_valid";return a }
            # hash[:out_valid] = lambda { a = Logic.new(out_valid);a.name = "out_valid";return a }
            raise TdlError.new('parse_big_field_table Logic out_valid TdlHash cant include Proc') if out_valid.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(out_valid)
                unless out_valid[:name]
                    a.name = "out_valid"
                end
                return a }
            hash.[]=(:out_valid,lam,false)
        end
                

        unless cm_tb_s.is_a? Hash
            hash.case_record(:cm_tb_s,cm_tb_s)
        else
            # hash.new_index(:cm_tb_s)= lambda { a = AxiStream.new(cm_tb_s);a.name = "cm_tb_s";return a }
            # hash[:cm_tb_s] = lambda { a = AxiStream.new(cm_tb_s);a.name = "cm_tb_s";return a }
            raise TdlError.new('parse_big_field_table AxiStream cm_tb_s TdlHash cant include Proc') if cm_tb_s.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(cm_tb_s)
                unless cm_tb_s[:name]
                    a.name = "cm_tb_s"
                end
                return a }
            hash.[]=(:cm_tb_s,lam,false)
        end
                

        unless cm_tb_m.is_a? Hash
            hash.case_record(:cm_tb_m,cm_tb_m)
        else
            # hash.new_index(:cm_tb_m)= lambda { a = AxiStream.new(cm_tb_m);a.name = "cm_tb_m";return a }
            # hash[:cm_tb_m] = lambda { a = AxiStream.new(cm_tb_m);a.name = "cm_tb_m";return a }
            raise TdlError.new('parse_big_field_table AxiStream cm_tb_m TdlHash cant include Proc') if cm_tb_m.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(cm_tb_m)
                unless cm_tb_m[:name]
                    a.name = "cm_tb_m"
                end
                return a }
            hash.[]=(:cm_tb_m,lam,false)
        end
                

        unless cm_mirror.is_a? Hash
            hash.case_record(:cm_mirror,cm_mirror)
        else
            # hash.new_index(:cm_mirror)= lambda { a = AxiStream.new(cm_mirror);a.name = "cm_mirror";return a }
            # hash[:cm_mirror] = lambda { a = AxiStream.new(cm_mirror);a.name = "cm_mirror";return a }
            raise TdlError.new('parse_big_field_table AxiStream cm_mirror TdlHash cant include Proc') if cm_mirror.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(cm_mirror)
                unless cm_mirror[:name]
                    a.name = "cm_mirror"
                end
                return a }
            hash.[]=(:cm_mirror,lam,false)
        end
                

        hash.push_to_module_stack(AxiStream,:parse_big_field_table)
        hash.open_error = true
        return hash
    end
end
