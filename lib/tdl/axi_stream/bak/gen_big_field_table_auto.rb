
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def gen_big_field_table(master_mode:"OFF",dsize:8,field_len:16*8,field_name:"Big Filed",enable:"enable",value:"value",cm_tb:"cm_tb",down_stream:nil)

        Tdl.add_to_all_file_paths(['gen_big_field_table','../../axi/AXI_stream/gen_big_field_table.sv'])
        return_stream = self
        
        cm_tb = AxiStream.same_name_socket(:to_down,mix=true,cm_tb) unless cm_tb.is_a? String
        
        
        cm_tb = self unless self==AxiStream.NC

         @instance_draw_stack << lambda { gen_big_field_table_draw(master_mode:master_mode,dsize:dsize,field_len:field_len,field_name:field_name,enable:enable,value:value,cm_tb:cm_tb,down_stream:down_stream) }
        return return_stream
    end

    def gen_big_field_table_draw(master_mode:"OFF",dsize:8,field_len:16*8,field_name:"Big Filed",enable:"enable",value:"value",cm_tb:"cm_tb",down_stream:nil)

        large_name_len(master_mode,dsize,field_len,field_name,enable,value,cm_tb)
"
// FilePath:::../../axi/AXI_stream/gen_big_field_table.sv
gen_big_field_table#(
    .MASTER_MODE    (#{align_signal(master_mode)}),
    .DSIZE          (#{align_signal(dsize)}),
    .FIELD_LEN      (#{align_signal(field_len)}),
    .FIELD_NAME     (#{align_signal(field_name)})
) gen_big_field_table_#{signal}_inst(
/*  input                       */ .enable (#{align_signal(enable,q_mark=false)}),
/*  input  [DSIZE*FIELD_LEN-1:0]*/ .value  (#{align_signal(value,q_mark=false)}),
/*  axi_stream_inf.master       */ .cm_tb  (#{align_signal(cm_tb,q_mark=false)})
);
"
    end
    
    def self.gen_big_field_table(master_mode:"OFF",dsize:8,field_len:16*8,field_name:"Big Filed",enable:"enable",value:"value",cm_tb:"cm_tb",down_stream:nil)
        return_stream = nil
        
        
        
        if down_stream.is_a? AxiStream
            down_stream.gen_big_field_table(master_mode:master_mode,dsize:dsize,field_len:field_len,field_name:field_name,enable:enable,value:value,cm_tb:cm_tb,down_stream:down_stream)
        elsif cm_tb.is_a? AxiStream
            cm_tb.gen_big_field_table(master_mode:master_mode,dsize:dsize,field_len:field_len,field_name:field_name,enable:enable,value:value,cm_tb:cm_tb,down_stream:down_stream)
        else
            AxiStream.NC.gen_big_field_table(master_mode:master_mode,dsize:dsize,field_len:field_len,field_name:field_name,enable:enable,value:value,cm_tb:cm_tb,down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_gen_big_field_table
        c0 = Clock.new(name:"gen_big_field_table_clk",freqM:148.5)
        r0 = Reset.new(name:"gen_big_field_table_rst_n",active:"low")

        master_mode = Parameter.new(name:"master_mode",value:"OFF")
        dsize = Parameter.new(name:"dsize",value:8)
        field_len = Parameter.new(name:"field_len",value:16*8)
        field_name = Parameter.new(name:"field_name",value:"Big Filed")
        enable = Logic.new(name:"enable")
        value = Logic.new(name:"value")
        cm_tb = AxiStream.new(name:"cm_tb",clock:c0,reset:r0)
        
        down_stream = cm_tb
        AxiStream.gen_big_field_table(master_mode:master_mode,dsize:dsize,field_len:field_len,field_name:field_name,enable:enable,value:value,cm_tb:cm_tb)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_gen_big_field_table(
        master_mode:"OFF",
        dsize:8,
        field_len:16*8,
        field_name:"Big Filed",
        enable:"enable",
        value:"value",
        cm_tb:"cm_tb")
        hash = TdlHash.new
        
        unless master_mode.is_a? Hash
            hash.case_record(:master_mode,master_mode)
        else
            # hash.new_index(:master_mode)= lambda { a = Parameter.new(master_mode);a.name = "master_mode";return a }
            # hash[:master_mode] = lambda { a = Parameter.new(master_mode);a.name = "master_mode";return a }
            raise TdlError.new('gen_big_field_table Parameter master_mode TdlHash cant include Proc') if master_mode.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(master_mode)
                unless master_mode[:name]
                    a.name = "master_mode"
                end
                return a }
            hash.[]=(:master_mode,lam,false)
        end
                

        unless dsize.is_a? Hash
            hash.case_record(:dsize,dsize)
        else
            # hash.new_index(:dsize)= lambda { a = Parameter.new(dsize);a.name = "dsize";return a }
            # hash[:dsize] = lambda { a = Parameter.new(dsize);a.name = "dsize";return a }
            raise TdlError.new('gen_big_field_table Parameter dsize TdlHash cant include Proc') if dsize.select{ |k,v| v.is_a? Proc }.any?
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
            raise TdlError.new('gen_big_field_table Parameter field_len TdlHash cant include Proc') if field_len.select{ |k,v| v.is_a? Proc }.any?
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
            raise TdlError.new('gen_big_field_table Parameter field_name TdlHash cant include Proc') if field_name.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(field_name)
                unless field_name[:name]
                    a.name = "field_name"
                end
                return a }
            hash.[]=(:field_name,lam,false)
        end
                

        unless enable.is_a? Hash
            hash.case_record(:enable,enable)
        else
            # hash.new_index(:enable)= lambda { a = Logic.new(enable);a.name = "enable";return a }
            # hash[:enable] = lambda { a = Logic.new(enable);a.name = "enable";return a }
            raise TdlError.new('gen_big_field_table Logic enable TdlHash cant include Proc') if enable.select{ |k,v| v.is_a? Proc }.any?
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
            raise TdlError.new('gen_big_field_table Logic value TdlHash cant include Proc') if value.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(value)
                unless value[:name]
                    a.name = "value"
                end
                return a }
            hash.[]=(:value,lam,false)
        end
                

        unless cm_tb.is_a? Hash
            hash.case_record(:cm_tb,cm_tb)
        else
            # hash.new_index(:cm_tb)= lambda { a = AxiStream.new(cm_tb);a.name = "cm_tb";return a }
            # hash[:cm_tb] = lambda { a = AxiStream.new(cm_tb);a.name = "cm_tb";return a }
            raise TdlError.new('gen_big_field_table AxiStream cm_tb TdlHash cant include Proc') if cm_tb.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(cm_tb)
                unless cm_tb[:name]
                    a.name = "cm_tb"
                end
                return a }
            hash.[]=(:cm_tb,lam,false)
        end
                

        hash.push_to_module_stack(AxiStream,:gen_big_field_table)
        hash.open_error = true
        return hash
    end
end
