
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class DataInf_C


    def data_uncompress(asize:8,lsize:8,data_zip:"data_zip",data_unzip:"data_unzip",up_stream:nil,down_stream:nil)

        Tdl.add_to_all_file_paths(['data_uncompress','../../axi/data_interface/data_inf_c/data_uncompress.sv'])
        return_stream = self
        
        data_zip = DataInf_C.same_name_socket(:from_up,mix=true,data_zip) unless data_zip.is_a? String
        data_unzip = DataInf_C.same_name_socket(:to_down,mix=true,data_unzip) unless data_unzip.is_a? String
        
        if up_stream==nil && data_zip=="data_zip"
            up_stream = self.copy(name:"data_zip")
            return_stream = up_stream
        end

        data_zip = up_stream if up_stream
        data_unzip = self unless self==DataInf_C.NC

         @instance_draw_stack << lambda { data_uncompress_draw(asize:asize,lsize:lsize,data_zip:data_zip,data_unzip:data_unzip,up_stream:up_stream,down_stream:down_stream) }
        return return_stream
    end

    def data_uncompress_draw(asize:8,lsize:8,data_zip:"data_zip",data_unzip:"data_unzip",up_stream:nil,down_stream:nil)

        large_name_len(asize,lsize,data_zip,data_unzip)
"
// FilePath:::../../axi/data_interface/data_inf_c/data_uncompress.sv
data_uncompress#(
    .ASIZE    (#{align_signal(asize)}),
    .LSIZE    (#{align_signal(lsize)})
) data_uncompress_#{signal}_inst(
/*  data_inf_c.slaver*/ .data_zip   (#{align_signal(data_zip,q_mark=false)}),
/*  data_inf_c.master*/ .data_unzip (#{align_signal(data_unzip,q_mark=false)})
);
"
    end
    
    def self.data_uncompress(asize:8,lsize:8,data_zip:"data_zip",data_unzip:"data_unzip",up_stream:nil,down_stream:nil)
        return_stream = nil
        
        if down_stream==nil && data_unzip=="data_unzip"
            if up_stream.is_a? DataInf_C
                down_stream = up_stream.copy(name:"data_unzip")
            else
                down_stream = data_zip.copy(name:"data_unzip")
            end
            return_stream = down_stream
        end

        
        if up_stream==nil && data_zip=="data_zip"
            if down_stream.is_a? DataInf_C
                up_stream = down_stream.copy(name:"data_zip")
            else
                up_stream = data_unzip.copy(name:"data_zip")
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? DataInf_C
            down_stream.data_uncompress(asize:asize,lsize:lsize,data_zip:data_zip,data_unzip:data_unzip,up_stream:up_stream,down_stream:down_stream)
        elsif data_unzip.is_a? DataInf_C
            data_unzip.data_uncompress(asize:asize,lsize:lsize,data_zip:data_zip,data_unzip:data_unzip,up_stream:up_stream,down_stream:down_stream)
        else
            DataInf_C.NC.data_uncompress(asize:asize,lsize:lsize,data_zip:data_zip,data_unzip:data_unzip,up_stream:up_stream,down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_data_uncompress
        c0 = Clock.new(name:"data_uncompress_clk",freqM:148.5)
        r0 = Reset.new(name:"data_uncompress_rst_n",active:"low")

        asize = Parameter.new(name:"asize",value:8)
        lsize = Parameter.new(name:"lsize",value:8)
        data_zip = DataInf_C.new(name:"data_zip",clock:c0,reset:r0)
        data_unzip = DataInf_C.new(name:"data_unzip",clock:c0,reset:r0)
        up_stream = data_zip
        down_stream = data_unzip
        DataInf_C.data_uncompress(asize:asize,lsize:lsize,data_zip:data_zip,data_unzip:data_unzip)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_data_uncompress(
        asize:8,
        lsize:8,
        data_zip:"data_zip",
        data_unzip:"data_unzip")
        hash = TdlHash.new
        
        unless asize.is_a? Hash
            hash.case_record(:asize,asize)
        else
            # hash.new_index(:asize)= lambda { a = Parameter.new(asize);a.name = "asize";return a }
            # hash[:asize] = lambda { a = Parameter.new(asize);a.name = "asize";return a }
            raise TdlError.new('data_uncompress Parameter asize TdlHash cant include Proc') if asize.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(asize)
                unless asize[:name]
                    a.name = "asize"
                end
                return a }
            hash.[]=(:asize,lam,false)
        end
                

        unless lsize.is_a? Hash
            hash.case_record(:lsize,lsize)
        else
            # hash.new_index(:lsize)= lambda { a = Parameter.new(lsize);a.name = "lsize";return a }
            # hash[:lsize] = lambda { a = Parameter.new(lsize);a.name = "lsize";return a }
            raise TdlError.new('data_uncompress Parameter lsize TdlHash cant include Proc') if lsize.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(lsize)
                unless lsize[:name]
                    a.name = "lsize"
                end
                return a }
            hash.[]=(:lsize,lam,false)
        end
                

        unless data_zip.is_a? Hash
            hash.case_record(:data_zip,data_zip)
        else
            # hash.new_index(:data_zip)= lambda { a = DataInf_C.new(data_zip);a.name = "data_zip";return a }
            # hash[:data_zip] = lambda { a = DataInf_C.new(data_zip);a.name = "data_zip";return a }
            raise TdlError.new('data_uncompress DataInf_C data_zip TdlHash cant include Proc') if data_zip.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = DataInf_C.new(data_zip)
                unless data_zip[:name]
                    a.name = "data_zip"
                end
                return a }
            hash.[]=(:data_zip,lam,false)
        end
                

        unless data_unzip.is_a? Hash
            hash.case_record(:data_unzip,data_unzip)
        else
            # hash.new_index(:data_unzip)= lambda { a = DataInf_C.new(data_unzip);a.name = "data_unzip";return a }
            # hash[:data_unzip] = lambda { a = DataInf_C.new(data_unzip);a.name = "data_unzip";return a }
            raise TdlError.new('data_uncompress DataInf_C data_unzip TdlHash cant include Proc') if data_unzip.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = DataInf_C.new(data_unzip)
                unless data_unzip[:name]
                    a.name = "data_unzip"
                end
                return a }
            hash.[]=(:data_unzip,lam,false)
        end
                

        hash.push_to_module_stack(DataInf_C,:data_uncompress)
        hash.open_error = true
        return hash
    end
end
