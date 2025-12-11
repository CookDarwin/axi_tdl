
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def gen_origin_axis(mode:"RANGE",enable:"enable",ready:"ready",length:"length",axis_out:"axis_out",down_stream:nil)

        Tdl.add_to_all_file_paths(['gen_origin_axis','../../axi/AXI_stream/gen_origin_axis.sv'])
        return_stream = self
        
        axis_out = AxiStream.same_name_socket(:to_down,mix=true,axis_out) unless axis_out.is_a? String
        
        
        axis_out = self unless self==AxiStream.NC

         @instance_draw_stack << lambda { gen_origin_axis_draw(mode:mode,enable:enable,ready:ready,length:length,axis_out:axis_out,down_stream:down_stream) }
        return return_stream
    end

    def gen_origin_axis_draw(mode:"RANGE",enable:"enable",ready:"ready",length:"length",axis_out:"axis_out",down_stream:nil)

        large_name_len(mode,enable,ready,length,axis_out)
"
// FilePath:::../../axi/AXI_stream/gen_origin_axis.sv
gen_origin_axis#(
    .MODE    (#{align_signal(mode)})
) gen_origin_axis_#{signal}_inst(
/*  input                */ .enable   (#{align_signal(enable,q_mark=false)}),
/*  output               */ .ready    (#{align_signal(ready,q_mark=false)}),
/*  input  [31:0]        */ .length   (#{align_signal(length,q_mark=false)}),
/*  axi_stream_inf.master*/ .axis_out (#{align_signal(axis_out,q_mark=false)})
);
"
    end
    
    def self.gen_origin_axis(mode:"RANGE",enable:"enable",ready:"ready",length:"length",axis_out:"axis_out",down_stream:nil)
        return_stream = nil
        
        
        
        if down_stream.is_a? AxiStream
            down_stream.gen_origin_axis(mode:mode,enable:enable,ready:ready,length:length,axis_out:axis_out,down_stream:down_stream)
        elsif axis_out.is_a? AxiStream
            axis_out.gen_origin_axis(mode:mode,enable:enable,ready:ready,length:length,axis_out:axis_out,down_stream:down_stream)
        else
            AxiStream.NC.gen_origin_axis(mode:mode,enable:enable,ready:ready,length:length,axis_out:axis_out,down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_gen_origin_axis
        c0 = Clock.new(name:"gen_origin_axis_clk",freqM:148.5)
        r0 = Reset.new(name:"gen_origin_axis_rst_n",active:"low")

        mode = Parameter.new(name:"mode",value:"RANGE")
        enable = Logic.new(name:"enable")
        ready = Logic.new(name:"ready")
        length = Logic.new(name:"length")
        axis_out = AxiStream.new(name:"axis_out",clock:c0,reset:r0)
        
        down_stream = axis_out
        AxiStream.gen_origin_axis(mode:mode,enable:enable,ready:ready,length:length,axis_out:axis_out)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_gen_origin_axis(
        mode:"RANGE",
        enable:"enable",
        ready:"ready",
        length:"length",
        axis_out:"axis_out")
        hash = TdlHash.new
        
        unless mode.is_a? Hash
            hash.case_record(:mode,mode)
        else
            # hash.new_index(:mode)= lambda { a = Parameter.new(mode);a.name = "mode";return a }
            # hash[:mode] = lambda { a = Parameter.new(mode);a.name = "mode";return a }
            raise TdlError.new('gen_origin_axis Parameter mode TdlHash cant include Proc') if mode.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(mode)
                unless mode[:name]
                    a.name = "mode"
                end
                return a }
            hash.[]=(:mode,lam,false)
        end
                

        unless enable.is_a? Hash
            hash.case_record(:enable,enable)
        else
            # hash.new_index(:enable)= lambda { a = Logic.new(enable);a.name = "enable";return a }
            # hash[:enable] = lambda { a = Logic.new(enable);a.name = "enable";return a }
            raise TdlError.new('gen_origin_axis Logic enable TdlHash cant include Proc') if enable.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(enable)
                unless enable[:name]
                    a.name = "enable"
                end
                return a }
            hash.[]=(:enable,lam,false)
        end
                

        unless ready.is_a? Hash
            hash.case_record(:ready,ready)
        else
            # hash.new_index(:ready)= lambda { a = Logic.new(ready);a.name = "ready";return a }
            # hash[:ready] = lambda { a = Logic.new(ready);a.name = "ready";return a }
            raise TdlError.new('gen_origin_axis Logic ready TdlHash cant include Proc') if ready.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(ready)
                unless ready[:name]
                    a.name = "ready"
                end
                return a }
            hash.[]=(:ready,lam,false)
        end
                

        unless length.is_a? Hash
            hash.case_record(:length,length)
        else
            # hash.new_index(:length)= lambda { a = Logic.new(length);a.name = "length";return a }
            # hash[:length] = lambda { a = Logic.new(length);a.name = "length";return a }
            raise TdlError.new('gen_origin_axis Logic length TdlHash cant include Proc') if length.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(length)
                unless length[:name]
                    a.name = "length"
                end
                return a }
            hash.[]=(:length,lam,false)
        end
                

        unless axis_out.is_a? Hash
            hash.case_record(:axis_out,axis_out)
        else
            # hash.new_index(:axis_out)= lambda { a = AxiStream.new(axis_out);a.name = "axis_out";return a }
            # hash[:axis_out] = lambda { a = AxiStream.new(axis_out);a.name = "axis_out";return a }
            raise TdlError.new('gen_origin_axis AxiStream axis_out TdlHash cant include Proc') if axis_out.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(axis_out)
                unless axis_out[:name]
                    a.name = "axis_out"
                end
                return a }
            hash.[]=(:axis_out,lam,false)
        end
                

        hash.push_to_module_stack(AxiStream,:gen_origin_axis)
        hash.open_error = true
        return hash
    end
end
