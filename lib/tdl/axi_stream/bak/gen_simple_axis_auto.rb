
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def gen_simple_axis(mode:"RANGE",trigger:"trigger",gen_en:"gen_en",length:"length",led:"led",axis_out:"axis_out",down_stream:nil)

        Tdl.add_to_all_file_paths(['gen_simple_axis','../../axi/AXI_stream/gen_simple_axis.sv'])
        return_stream = self
        
        axis_out = AxiStream.same_name_socket(:to_down,mix=true,axis_out) unless axis_out.is_a? String
        
        
        axis_out = self unless self==AxiStream.NC

         @instance_draw_stack << lambda { gen_simple_axis_draw(mode:mode,trigger:trigger,gen_en:gen_en,length:length,led:led,axis_out:axis_out,down_stream:down_stream) }
        return return_stream
    end

    def gen_simple_axis_draw(mode:"RANGE",trigger:"trigger",gen_en:"gen_en",length:"length",led:"led",axis_out:"axis_out",down_stream:nil)

        large_name_len(mode,trigger,gen_en,length,led,axis_out)
"
// FilePath:::../../axi/AXI_stream/gen_simple_axis.sv
gen_simple_axis#(
    .MODE    (#{align_signal(mode)})
) gen_simple_axis_#{signal}_inst(
/*  input                */ .trigger  (#{align_signal(trigger,q_mark=false)}),
/*  input                */ .gen_en   (#{align_signal(gen_en,q_mark=false)}),
/*  input  [15:0]        */ .length   (#{align_signal(length,q_mark=false)}),
/*  output               */ .led      (#{align_signal(led,q_mark=false)}),
/*  axi_stream_inf.master*/ .axis_out (#{align_signal(axis_out,q_mark=false)})
);
"
    end
    
    def self.gen_simple_axis(mode:"RANGE",trigger:"trigger",gen_en:"gen_en",length:"length",led:"led",axis_out:"axis_out",down_stream:nil)
        return_stream = nil
        
        
        
        if down_stream.is_a? AxiStream
            down_stream.gen_simple_axis(mode:mode,trigger:trigger,gen_en:gen_en,length:length,led:led,axis_out:axis_out,down_stream:down_stream)
        elsif axis_out.is_a? AxiStream
            axis_out.gen_simple_axis(mode:mode,trigger:trigger,gen_en:gen_en,length:length,led:led,axis_out:axis_out,down_stream:down_stream)
        else
            AxiStream.NC.gen_simple_axis(mode:mode,trigger:trigger,gen_en:gen_en,length:length,led:led,axis_out:axis_out,down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_gen_simple_axis
        c0 = Clock.new(name:"gen_simple_axis_clk",freqM:148.5)
        r0 = Reset.new(name:"gen_simple_axis_rst_n",active:"low")

        mode = Parameter.new(name:"mode",value:"RANGE")
        trigger = Logic.new(name:"trigger")
        gen_en = Logic.new(name:"gen_en")
        length = Logic.new(name:"length")
        led = Logic.new(name:"led")
        axis_out = AxiStream.new(name:"axis_out",clock:c0,reset:r0)
        
        down_stream = axis_out
        AxiStream.gen_simple_axis(mode:mode,trigger:trigger,gen_en:gen_en,length:length,led:led,axis_out:axis_out)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_gen_simple_axis(
        mode:"RANGE",
        trigger:"trigger",
        gen_en:"gen_en",
        length:"length",
        led:"led",
        axis_out:"axis_out")
        hash = TdlHash.new
        
        unless mode.is_a? Hash
            hash.case_record(:mode,mode)
        else
            # hash.new_index(:mode)= lambda { a = Parameter.new(mode);a.name = "mode";return a }
            # hash[:mode] = lambda { a = Parameter.new(mode);a.name = "mode";return a }
            raise TdlError.new('gen_simple_axis Parameter mode TdlHash cant include Proc') if mode.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(mode)
                unless mode[:name]
                    a.name = "mode"
                end
                return a }
            hash.[]=(:mode,lam,false)
        end
                

        unless trigger.is_a? Hash
            hash.case_record(:trigger,trigger)
        else
            # hash.new_index(:trigger)= lambda { a = Logic.new(trigger);a.name = "trigger";return a }
            # hash[:trigger] = lambda { a = Logic.new(trigger);a.name = "trigger";return a }
            raise TdlError.new('gen_simple_axis Logic trigger TdlHash cant include Proc') if trigger.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(trigger)
                unless trigger[:name]
                    a.name = "trigger"
                end
                return a }
            hash.[]=(:trigger,lam,false)
        end
                

        unless gen_en.is_a? Hash
            hash.case_record(:gen_en,gen_en)
        else
            # hash.new_index(:gen_en)= lambda { a = Logic.new(gen_en);a.name = "gen_en";return a }
            # hash[:gen_en] = lambda { a = Logic.new(gen_en);a.name = "gen_en";return a }
            raise TdlError.new('gen_simple_axis Logic gen_en TdlHash cant include Proc') if gen_en.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(gen_en)
                unless gen_en[:name]
                    a.name = "gen_en"
                end
                return a }
            hash.[]=(:gen_en,lam,false)
        end
                

        unless length.is_a? Hash
            hash.case_record(:length,length)
        else
            # hash.new_index(:length)= lambda { a = Logic.new(length);a.name = "length";return a }
            # hash[:length] = lambda { a = Logic.new(length);a.name = "length";return a }
            raise TdlError.new('gen_simple_axis Logic length TdlHash cant include Proc') if length.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(length)
                unless length[:name]
                    a.name = "length"
                end
                return a }
            hash.[]=(:length,lam,false)
        end
                

        unless led.is_a? Hash
            hash.case_record(:led,led)
        else
            # hash.new_index(:led)= lambda { a = Logic.new(led);a.name = "led";return a }
            # hash[:led] = lambda { a = Logic.new(led);a.name = "led";return a }
            raise TdlError.new('gen_simple_axis Logic led TdlHash cant include Proc') if led.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(led)
                unless led[:name]
                    a.name = "led"
                end
                return a }
            hash.[]=(:led,lam,false)
        end
                

        unless axis_out.is_a? Hash
            hash.case_record(:axis_out,axis_out)
        else
            # hash.new_index(:axis_out)= lambda { a = AxiStream.new(axis_out);a.name = "axis_out";return a }
            # hash[:axis_out] = lambda { a = AxiStream.new(axis_out);a.name = "axis_out";return a }
            raise TdlError.new('gen_simple_axis AxiStream axis_out TdlHash cant include Proc') if axis_out.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(axis_out)
                unless axis_out[:name]
                    a.name = "axis_out"
                end
                return a }
            hash.[]=(:axis_out,lam,false)
        end
                

        hash.push_to_module_stack(AxiStream,:gen_simple_axis)
        hash.open_error = true
        return hash
    end
end
