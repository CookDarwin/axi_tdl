
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def _check_stream_crc(axis_in:"axis_in")

        Tdl.add_to_all_file_paths(['check_stream_crc','../../axi/AXI_stream/check_stream_crc.sv'])
        return_stream = self
        
        axis_in = AxiStream.same_name_socket(:mirror,mix=true,axis_in) unless axis_in.is_a? String
        
        
        

         @instance_draw_stack << lambda { _check_stream_crc_draw(axis_in:axis_in) }
        return return_stream
    end

    def _check_stream_crc_draw(axis_in:"axis_in")

        large_name_len(axis_in)
"
// FilePath:::../../axi/AXI_stream/check_stream_crc.sv
check_stream_crc check_stream_crc_#{signal}_inst(
/*  axi_stream_inf.mirror*/ .axis_in (#{align_signal(axis_in,q_mark=false)})
);
"
    end
    
    def self.check_stream_crc(axis_in:"axis_in")
        return_stream = nil
        
        
        AxiStream.NC._check_stream_crc(axis_in:axis_in)
        return return_stream
    end
        

end


class TdlTest

    def self.test_check_stream_crc
        c0 = Clock.new(name:"check_stream_crc_clk",freqM:148.5)
        r0 = Reset.new(name:"check_stream_crc_rst_n",active:"low")

        axis_in = AxiStream.new(name:"axis_in",clock:c0,reset:r0)
        
        
        AxiStream.check_stream_crc(axis_in:axis_in)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_check_stream_crc(
        axis_in:"axis_in")
        hash = TdlHash.new
        
        unless axis_in.is_a? Hash
            hash.case_record(:axis_in,axis_in)
        else
            # hash.new_index(:axis_in)= lambda { a = AxiStream.new(axis_in);a.name = "axis_in";return a }
            # hash[:axis_in] = lambda { a = AxiStream.new(axis_in);a.name = "axis_in";return a }
            raise TdlError.new('check_stream_crc AxiStream axis_in TdlHash cant include Proc') if axis_in.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(axis_in)
                unless axis_in[:name]
                    a.name = "axis_in"
                end
                return a }
            hash.[]=(:axis_in,lam,false)
        end
                

        hash.push_to_module_stack(AxiStream,:check_stream_crc)
        hash.open_error = true
        return hash
    end
end
