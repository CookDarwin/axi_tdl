
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def axis_valve_with_pipe(button:"button",axis_in:"axis_in",axis_out:"axis_out",up_stream:nil,down_stream:nil)

        Tdl.add_to_all_file_paths(['axis_valve_with_pipe','../../axi/AXI_stream/axis_valve_with_pipe.sv'])
        return_stream = self
        
        axis_in = AxiStream.same_name_socket(:from_up,mix=true,axis_in) unless axis_in.is_a? String
        axis_out = AxiStream.same_name_socket(:to_down,mix=true,axis_out) unless axis_out.is_a? String
        
        if up_stream==nil && axis_in=="axis_in"
            up_stream = self.copy(name:"axis_in")
            return_stream = up_stream
        end

        axis_in = up_stream if up_stream
        axis_out = self unless self==AxiStream.NC

         @instance_draw_stack << lambda { axis_valve_with_pipe_draw(button:button,axis_in:axis_in,axis_out:axis_out,up_stream:up_stream,down_stream:down_stream) }
        return return_stream
    end

    def axis_valve_with_pipe_draw(button:"button",axis_in:"axis_in",axis_out:"axis_out",up_stream:nil,down_stream:nil)

        large_name_len(button,axis_in,axis_out)
"
// FilePath:::../../axi/AXI_stream/axis_valve_with_pipe.sv
axis_valve_with_pipe axis_valve_with_pipe_#{signal}_inst(
/*  input                */ .button   (#{align_signal(button,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .axis_in  (#{align_signal(axis_in,q_mark=false)}),
/*  axi_stream_inf.master*/ .axis_out (#{align_signal(axis_out,q_mark=false)})
);
"
    end
    
    def self.axis_valve_with_pipe(button:"button",axis_in:"axis_in",axis_out:"axis_out",up_stream:nil,down_stream:nil)
        return_stream = nil
        
        if down_stream==nil && axis_out=="axis_out"
            if up_stream.is_a? AxiStream
                down_stream = up_stream.copy(name:"axis_out")
            else
                down_stream = axis_in.copy(name:"axis_out")
            end
            return_stream = down_stream
        end

        
        if up_stream==nil && axis_in=="axis_in"
            if down_stream.is_a? AxiStream
                up_stream = down_stream.copy(name:"axis_in")
            else
                up_stream = axis_out.copy(name:"axis_in")
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? AxiStream
            down_stream.axis_valve_with_pipe(button:button,axis_in:axis_in,axis_out:axis_out,up_stream:up_stream,down_stream:down_stream)
        elsif axis_out.is_a? AxiStream
            axis_out.axis_valve_with_pipe(button:button,axis_in:axis_in,axis_out:axis_out,up_stream:up_stream,down_stream:down_stream)
        else
            AxiStream.NC.axis_valve_with_pipe(button:button,axis_in:axis_in,axis_out:axis_out,up_stream:up_stream,down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_axis_valve_with_pipe
        c0 = Clock.new(name:"axis_valve_with_pipe_clk",freqM:148.5)
        r0 = Reset.new(name:"axis_valve_with_pipe_rst_n",active:"low")

        button = Logic.new(name:"button")
        axis_in = AxiStream.new(name:"axis_in",clock:c0,reset:r0)
        axis_out = AxiStream.new(name:"axis_out",clock:c0,reset:r0)
        up_stream = axis_in
        down_stream = axis_out
        AxiStream.axis_valve_with_pipe(button:button,axis_in:axis_in,axis_out:axis_out)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axis_valve_with_pipe(
        button:"button",
        axis_in:"axis_in",
        axis_out:"axis_out")
        hash = TdlHash.new
        
        unless button.is_a? Hash
            hash.case_record(:button,button)
        else
            # hash.new_index(:button)= lambda { a = Logic.new(button);a.name = "button";return a }
            # hash[:button] = lambda { a = Logic.new(button);a.name = "button";return a }
            raise TdlError.new('axis_valve_with_pipe Logic button TdlHash cant include Proc') if button.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(button)
                unless button[:name]
                    a.name = "button"
                end
                return a }
            hash.[]=(:button,lam,false)
        end
                

        unless axis_in.is_a? Hash
            hash.case_record(:axis_in,axis_in)
        else
            # hash.new_index(:axis_in)= lambda { a = AxiStream.new(axis_in);a.name = "axis_in";return a }
            # hash[:axis_in] = lambda { a = AxiStream.new(axis_in);a.name = "axis_in";return a }
            raise TdlError.new('axis_valve_with_pipe AxiStream axis_in TdlHash cant include Proc') if axis_in.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(axis_in)
                unless axis_in[:name]
                    a.name = "axis_in"
                end
                return a }
            hash.[]=(:axis_in,lam,false)
        end
                

        unless axis_out.is_a? Hash
            hash.case_record(:axis_out,axis_out)
        else
            # hash.new_index(:axis_out)= lambda { a = AxiStream.new(axis_out);a.name = "axis_out";return a }
            # hash[:axis_out] = lambda { a = AxiStream.new(axis_out);a.name = "axis_out";return a }
            raise TdlError.new('axis_valve_with_pipe AxiStream axis_out TdlHash cant include Proc') if axis_out.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(axis_out)
                unless axis_out[:name]
                    a.name = "axis_out"
                end
                return a }
            hash.[]=(:axis_out,lam,false)
        end
                

        hash.push_to_module_stack(AxiStream,:axis_valve_with_pipe)
        hash.open_error = true
        return hash
    end
end
