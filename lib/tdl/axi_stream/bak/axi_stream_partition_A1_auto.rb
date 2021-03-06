
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def axi_stream_partition_a1(valve:"valve",partition_len:"partition_len",axis_in:"axis_in",axis_out:"axis_out",up_stream:nil,down_stream:nil)

        Tdl.add_to_all_file_paths(['axi_stream_partition_a1','../../axi/AXI_stream/axi_stream_partition_A1.sv'])
        return_stream = self
        
        axis_in = AxiStream.same_name_socket(:from_up,mix=true,axis_in) unless axis_in.is_a? String
        axis_out = AxiStream.same_name_socket(:to_down,mix=true,axis_out) unless axis_out.is_a? String
        
        if up_stream==nil && axis_in=="axis_in"
            up_stream = self.copy(name:"axis_in")
            return_stream = up_stream
        end

        axis_in = up_stream if up_stream
        axis_out = self unless self==AxiStream.NC

         @instance_draw_stack << lambda { axi_stream_partition_a1_draw(valve:valve,partition_len:partition_len,axis_in:axis_in,axis_out:axis_out,up_stream:up_stream,down_stream:down_stream) }
        return return_stream
    end

    def axi_stream_partition_a1_draw(valve:"valve",partition_len:"partition_len",axis_in:"axis_in",axis_out:"axis_out",up_stream:nil,down_stream:nil)

        large_name_len(valve,partition_len,axis_in,axis_out)
"
// FilePath:::../../axi/AXI_stream/axi_stream_partition_A1.sv
axi_stream_partition_A1 axi_stream_partition_A1_#{signal}_inst(
/*  input                */ .valve         (#{align_signal(valve,q_mark=false)}),
/*  input  [31:0]        */ .partition_len (#{align_signal(partition_len,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .axis_in       (#{align_signal(axis_in,q_mark=false)}),
/*  axi_stream_inf.master*/ .axis_out      (#{align_signal(axis_out,q_mark=false)})
);
"
    end
    
    def self.axi_stream_partition_a1(valve:"valve",partition_len:"partition_len",axis_in:"axis_in",axis_out:"axis_out",up_stream:nil,down_stream:nil)
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
            down_stream.axi_stream_partition_a1(valve:valve,partition_len:partition_len,axis_in:axis_in,axis_out:axis_out,up_stream:up_stream,down_stream:down_stream)
        elsif axis_out.is_a? AxiStream
            axis_out.axi_stream_partition_a1(valve:valve,partition_len:partition_len,axis_in:axis_in,axis_out:axis_out,up_stream:up_stream,down_stream:down_stream)
        else
            AxiStream.NC.axi_stream_partition_a1(valve:valve,partition_len:partition_len,axis_in:axis_in,axis_out:axis_out,up_stream:up_stream,down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_axi_stream_partition_a1
        c0 = Clock.new(name:"axi_stream_partition_a1_clk",freqM:148.5)
        r0 = Reset.new(name:"axi_stream_partition_a1_rst_n",active:"low")

        valve = Logic.new(name:"valve")
        partition_len = Logic.new(name:"partition_len")
        axis_in = AxiStream.new(name:"axis_in",clock:c0,reset:r0)
        axis_out = AxiStream.new(name:"axis_out",clock:c0,reset:r0)
        up_stream = axis_in
        down_stream = axis_out
        AxiStream.axi_stream_partition_a1(valve:valve,partition_len:partition_len,axis_in:axis_in,axis_out:axis_out)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axi_stream_partition_a1(
        valve:"valve",
        partition_len:"partition_len",
        axis_in:"axis_in",
        axis_out:"axis_out")
        hash = TdlHash.new
        
        unless valve.is_a? Hash
            hash.case_record(:valve,valve)
        else
            # hash.new_index(:valve)= lambda { a = Logic.new(valve);a.name = "valve";return a }
            # hash[:valve] = lambda { a = Logic.new(valve);a.name = "valve";return a }
            raise TdlError.new('axi_stream_partition_a1 Logic valve TdlHash cant include Proc') if valve.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(valve)
                unless valve[:name]
                    a.name = "valve"
                end
                return a }
            hash.[]=(:valve,lam,false)
        end
                

        unless partition_len.is_a? Hash
            hash.case_record(:partition_len,partition_len)
        else
            # hash.new_index(:partition_len)= lambda { a = Logic.new(partition_len);a.name = "partition_len";return a }
            # hash[:partition_len] = lambda { a = Logic.new(partition_len);a.name = "partition_len";return a }
            raise TdlError.new('axi_stream_partition_a1 Logic partition_len TdlHash cant include Proc') if partition_len.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(partition_len)
                unless partition_len[:name]
                    a.name = "partition_len"
                end
                return a }
            hash.[]=(:partition_len,lam,false)
        end
                

        unless axis_in.is_a? Hash
            hash.case_record(:axis_in,axis_in)
        else
            # hash.new_index(:axis_in)= lambda { a = AxiStream.new(axis_in);a.name = "axis_in";return a }
            # hash[:axis_in] = lambda { a = AxiStream.new(axis_in);a.name = "axis_in";return a }
            raise TdlError.new('axi_stream_partition_a1 AxiStream axis_in TdlHash cant include Proc') if axis_in.select{ |k,v| v.is_a? Proc }.any?
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
            raise TdlError.new('axi_stream_partition_a1 AxiStream axis_out TdlHash cant include Proc') if axis_out.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(axis_out)
                unless axis_out[:name]
                    a.name = "axis_out"
                end
                return a }
            hash.[]=(:axis_out,lam,false)
        end
                

        hash.push_to_module_stack(AxiStream,:axi_stream_partition_a1)
        hash.open_error = true
        return hash
    end
end
