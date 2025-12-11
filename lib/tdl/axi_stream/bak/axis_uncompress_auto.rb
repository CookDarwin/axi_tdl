
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def _axis_uncompress(asize:8,lsize:8,axis_zip:"axis_zip",axis_unzip:"axis_unzip")

        Tdl.add_to_all_file_paths(['axis_uncompress','../../axi/AXI_stream/axis_uncompress.sv'])
        return_stream = self
        
        axis_zip = AxiStream.same_name_socket(:from_up,mix=true,axis_zip) unless axis_zip.is_a? String
        axis_unzip = AxiStream.same_name_socket(:to_down,mix=true,axis_unzip) unless axis_unzip.is_a? String
        
        
        

         @instance_draw_stack << lambda { _axis_uncompress_draw(asize:asize,lsize:lsize,axis_zip:axis_zip,axis_unzip:axis_unzip) }
        return return_stream
    end

    def _axis_uncompress_draw(asize:8,lsize:8,axis_zip:"axis_zip",axis_unzip:"axis_unzip")

        large_name_len(asize,lsize,axis_zip,axis_unzip)
"
// FilePath:::../../axi/AXI_stream/axis_uncompress.sv
axis_uncompress#(
    .ASIZE    (#{align_signal(asize)}),
    .LSIZE    (#{align_signal(lsize)})
) axis_uncompress_#{signal}_inst(
/*  axi_stream_inf.slaver*/ .axis_zip   (#{align_signal(axis_zip,q_mark=false)}),
/*  axi_stream_inf.master*/ .axis_unzip (#{align_signal(axis_unzip,q_mark=false)})
);
"
    end
    
    def self.axis_uncompress(asize:8,lsize:8,axis_zip:"axis_zip",axis_unzip:"axis_unzip")
        return_stream = nil
        
        
        AxiStream.NC._axis_uncompress(asize:asize,lsize:lsize,axis_zip:axis_zip,axis_unzip:axis_unzip)
        return return_stream
    end
        

end


class TdlTest

    def self.test_axis_uncompress
        c0 = Clock.new(name:"axis_uncompress_clk",freqM:148.5)
        r0 = Reset.new(name:"axis_uncompress_rst_n",active:"low")

        asize = Parameter.new(name:"asize",value:8)
        lsize = Parameter.new(name:"lsize",value:8)
        axis_zip = AxiStream.new(name:"axis_zip",clock:c0,reset:r0)
        axis_unzip = AxiStream.new(name:"axis_unzip",clock:c0,reset:r0)
        
        
        AxiStream.axis_uncompress(asize:asize,lsize:lsize,axis_zip:axis_zip,axis_unzip:axis_unzip)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axis_uncompress(
        asize:8,
        lsize:8,
        axis_zip:"axis_zip",
        axis_unzip:"axis_unzip")
        hash = TdlHash.new
        
        unless asize.is_a? Hash
            hash.case_record(:asize,asize)
        else
            # hash.new_index(:asize)= lambda { a = Parameter.new(asize);a.name = "asize";return a }
            # hash[:asize] = lambda { a = Parameter.new(asize);a.name = "asize";return a }
            raise TdlError.new('axis_uncompress Parameter asize TdlHash cant include Proc') if asize.select{ |k,v| v.is_a? Proc }.any?
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
            raise TdlError.new('axis_uncompress Parameter lsize TdlHash cant include Proc') if lsize.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(lsize)
                unless lsize[:name]
                    a.name = "lsize"
                end
                return a }
            hash.[]=(:lsize,lam,false)
        end
                

        unless axis_zip.is_a? Hash
            hash.case_record(:axis_zip,axis_zip)
        else
            # hash.new_index(:axis_zip)= lambda { a = AxiStream.new(axis_zip);a.name = "axis_zip";return a }
            # hash[:axis_zip] = lambda { a = AxiStream.new(axis_zip);a.name = "axis_zip";return a }
            raise TdlError.new('axis_uncompress AxiStream axis_zip TdlHash cant include Proc') if axis_zip.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(axis_zip)
                unless axis_zip[:name]
                    a.name = "axis_zip"
                end
                return a }
            hash.[]=(:axis_zip,lam,false)
        end
                

        unless axis_unzip.is_a? Hash
            hash.case_record(:axis_unzip,axis_unzip)
        else
            # hash.new_index(:axis_unzip)= lambda { a = AxiStream.new(axis_unzip);a.name = "axis_unzip";return a }
            # hash[:axis_unzip] = lambda { a = AxiStream.new(axis_unzip);a.name = "axis_unzip";return a }
            raise TdlError.new('axis_uncompress AxiStream axis_unzip TdlHash cant include Proc') if axis_unzip.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(axis_unzip)
                unless axis_unzip[:name]
                    a.name = "axis_unzip"
                end
                return a }
            hash.[]=(:axis_unzip,lam,false)
        end
                

        hash.push_to_module_stack(AxiStream,:axis_uncompress)
        hash.open_error = true
        return hash
    end
end
