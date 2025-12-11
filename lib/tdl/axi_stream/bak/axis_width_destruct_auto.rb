
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def axis_width_destruct(wide_axis:"wide_axis",slim_axis:"slim_axis",up_stream:nil,down_stream:nil)

        Tdl.add_to_all_file_paths(['axis_width_destruct','../../axi/AXI_stream/data_width/axis_width_destruct.sv'])
        return_stream = self
        
        wide_axis = AxiStream.same_name_socket(:from_up,mix=true,wide_axis) unless wide_axis.is_a? String
        slim_axis = AxiStream.same_name_socket(:to_down,mix=true,slim_axis) unless slim_axis.is_a? String
        
        if up_stream==nil && wide_axis=="wide_axis"
            up_stream = self.copy(name:"wide_axis")
            return_stream = up_stream
        end

        wide_axis = up_stream if up_stream
        slim_axis = self unless self==AxiStream.NC

         @instance_draw_stack << lambda { axis_width_destruct_draw(wide_axis:wide_axis,slim_axis:slim_axis,up_stream:up_stream,down_stream:down_stream) }
        return return_stream
    end

    def axis_width_destruct_draw(wide_axis:"wide_axis",slim_axis:"slim_axis",up_stream:nil,down_stream:nil)

        large_name_len(wide_axis,slim_axis)
"
// FilePath:::../../axi/AXI_stream/data_width/axis_width_destruct.sv
axis_width_destruct axis_width_destruct_#{signal}_inst(
/*  axi_stream_inf.slaver*/ .wide_axis (#{align_signal(wide_axis,q_mark=false)}),
/*  axi_stream_inf.master*/ .slim_axis (#{align_signal(slim_axis,q_mark=false)})
);
"
    end
    
    def self.axis_width_destruct(wide_axis:"wide_axis",slim_axis:"slim_axis",up_stream:nil,down_stream:nil)
        return_stream = nil
        
        if down_stream==nil && slim_axis=="slim_axis"
            if up_stream.is_a? AxiStream
                down_stream = up_stream.copy(name:"slim_axis")
            else
                down_stream = wide_axis.copy(name:"slim_axis")
            end
            return_stream = down_stream
        end

        
        if up_stream==nil && wide_axis=="wide_axis"
            if down_stream.is_a? AxiStream
                up_stream = down_stream.copy(name:"wide_axis")
            else
                up_stream = slim_axis.copy(name:"wide_axis")
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? AxiStream
            down_stream.axis_width_destruct(wide_axis:wide_axis,slim_axis:slim_axis,up_stream:up_stream,down_stream:down_stream)
        elsif slim_axis.is_a? AxiStream
            slim_axis.axis_width_destruct(wide_axis:wide_axis,slim_axis:slim_axis,up_stream:up_stream,down_stream:down_stream)
        else
            AxiStream.NC.axis_width_destruct(wide_axis:wide_axis,slim_axis:slim_axis,up_stream:up_stream,down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_axis_width_destruct
        c0 = Clock.new(name:"axis_width_destruct_clk",freqM:148.5)
        r0 = Reset.new(name:"axis_width_destruct_rst_n",active:"low")

        wide_axis = AxiStream.new(name:"wide_axis",clock:c0,reset:r0)
        slim_axis = AxiStream.new(name:"slim_axis",clock:c0,reset:r0)
        up_stream = wide_axis
        down_stream = slim_axis
        AxiStream.axis_width_destruct(wide_axis:wide_axis,slim_axis:slim_axis)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axis_width_destruct(
        wide_axis:"wide_axis",
        slim_axis:"slim_axis")
        hash = TdlHash.new
        
        unless wide_axis.is_a? Hash
            hash.case_record(:wide_axis,wide_axis)
        else
            # hash.new_index(:wide_axis)= lambda { a = AxiStream.new(wide_axis);a.name = "wide_axis";return a }
            # hash[:wide_axis] = lambda { a = AxiStream.new(wide_axis);a.name = "wide_axis";return a }
            raise TdlError.new('axis_width_destruct AxiStream wide_axis TdlHash cant include Proc') if wide_axis.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(wide_axis)
                unless wide_axis[:name]
                    a.name = "wide_axis"
                end
                return a }
            hash.[]=(:wide_axis,lam,false)
        end
                

        unless slim_axis.is_a? Hash
            hash.case_record(:slim_axis,slim_axis)
        else
            # hash.new_index(:slim_axis)= lambda { a = AxiStream.new(slim_axis);a.name = "slim_axis";return a }
            # hash[:slim_axis] = lambda { a = AxiStream.new(slim_axis);a.name = "slim_axis";return a }
            raise TdlError.new('axis_width_destruct AxiStream slim_axis TdlHash cant include Proc') if slim_axis.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(slim_axis)
                unless slim_axis[:name]
                    a.name = "slim_axis"
                end
                return a }
            hash.[]=(:slim_axis,lam,false)
        end
                

        hash.push_to_module_stack(AxiStream,:axis_width_destruct)
        hash.open_error = true
        return hash
    end
end
