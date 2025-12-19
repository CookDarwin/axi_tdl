
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def axis_width_convert(in_axis:"in_axis",out_axis:"out_axis",up_stream:nil,down_stream:nil)

        Tdl.add_to_all_file_paths(['axis_width_convert','../../axi/AXI_stream/data_width/axis_width_convert.sv'])
        return_stream = self
        
        in_axis = AxiStream.same_name_socket(:from_up,mix=true,in_axis) unless in_axis.is_a? String
        out_axis = AxiStream.same_name_socket(:to_down,mix=true,out_axis) unless out_axis.is_a? String
        
        if up_stream==nil && in_axis=="in_axis"
            up_stream = self.copy(name:"in_axis")
            return_stream = up_stream
        end

        in_axis = up_stream if up_stream
        out_axis = self unless self==AxiStream.NC

         @instance_draw_stack << lambda { axis_width_convert_draw(in_axis:in_axis,out_axis:out_axis,up_stream:up_stream,down_stream:down_stream) }
        return return_stream
    end

    def axis_width_convert_draw(in_axis:"in_axis",out_axis:"out_axis",up_stream:nil,down_stream:nil)

        large_name_len(in_axis,out_axis)
"
// FilePath:::../../axi/AXI_stream/data_width/axis_width_convert.sv
axis_width_convert axis_width_convert_#{signal}_inst(
/*  axi_stream_inf.slaver*/ .in_axis  (#{align_signal(in_axis,q_mark=false)}),
/*  axi_stream_inf.master*/ .out_axis (#{align_signal(out_axis,q_mark=false)})
);
"
    end
    
    def self.axis_width_convert(in_axis:"in_axis",out_axis:"out_axis",up_stream:nil,down_stream:nil)
        return_stream = nil
        
        if down_stream==nil && out_axis=="out_axis"
            if up_stream.is_a? AxiStream
                down_stream = up_stream.copy(name:"out_axis")
            else
                down_stream = in_axis.copy(name:"out_axis")
            end
            return_stream = down_stream
        end

        
        if up_stream==nil && in_axis=="in_axis"
            if down_stream.is_a? AxiStream
                up_stream = down_stream.copy(name:"in_axis")
            else
                up_stream = out_axis.copy(name:"in_axis")
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? AxiStream
            down_stream.axis_width_convert(in_axis:in_axis,out_axis:out_axis,up_stream:up_stream,down_stream:down_stream)
        elsif out_axis.is_a? AxiStream
            out_axis.axis_width_convert(in_axis:in_axis,out_axis:out_axis,up_stream:up_stream,down_stream:down_stream)
        else
            AxiStream.NC.axis_width_convert(in_axis:in_axis,out_axis:out_axis,up_stream:up_stream,down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_axis_width_convert
        c0 = Clock.new(name:"axis_width_convert_clk",freqM:148.5)
        r0 = Reset.new(name:"axis_width_convert_rst_n",active:"low")

        in_axis = AxiStream.new(name:"in_axis",clock:c0,reset:r0)
        out_axis = AxiStream.new(name:"out_axis",clock:c0,reset:r0)
        up_stream = in_axis
        down_stream = out_axis
        AxiStream.axis_width_convert(in_axis:in_axis,out_axis:out_axis)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axis_width_convert(
        in_axis:"in_axis",
        out_axis:"out_axis")
        hash = TdlHash.new
        
        unless in_axis.is_a? Hash
            hash.case_record(:in_axis,in_axis)
        else
            # hash.new_index(:in_axis)= lambda { a = AxiStream.new(in_axis);a.name = "in_axis";return a }
            # hash[:in_axis] = lambda { a = AxiStream.new(in_axis);a.name = "in_axis";return a }
            raise TdlError.new('axis_width_convert AxiStream in_axis TdlHash cant include Proc') if in_axis.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(in_axis)
                unless in_axis[:name]
                    a.name = "in_axis"
                end
                return a }
            hash.[]=(:in_axis,lam,false)
        end
                

        unless out_axis.is_a? Hash
            hash.case_record(:out_axis,out_axis)
        else
            # hash.new_index(:out_axis)= lambda { a = AxiStream.new(out_axis);a.name = "out_axis";return a }
            # hash[:out_axis] = lambda { a = AxiStream.new(out_axis);a.name = "out_axis";return a }
            raise TdlError.new('axis_width_convert AxiStream out_axis TdlHash cant include Proc') if out_axis.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(out_axis)
                unless out_axis[:name]
                    a.name = "out_axis"
                end
                return a }
            hash.[]=(:out_axis,lam,false)
        end
                

        hash.push_to_module_stack(AxiStream,:axis_width_convert)
        hash.open_error = true
        return hash
    end
end
