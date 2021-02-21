
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def _axis_to_data_inf(data_out_inf:"data_out_inf",axis_in:"axis_in")

        Tdl.add_to_all_file_paths(['axis_to_data_inf','../../axi/AXI_stream/axis_to_data_inf.sv'])
        return_stream = self
        
        data_out_inf = DataInf_C.same_name_socket(:to_down,mix=true,data_out_inf) unless data_out_inf.is_a? String
        axis_in = AxiStream.same_name_socket(:from_up,mix=true,axis_in) unless axis_in.is_a? String
        
        
        

         @instance_draw_stack << lambda { _axis_to_data_inf_draw(data_out_inf:data_out_inf,axis_in:axis_in) }
        return return_stream
    end

    def _axis_to_data_inf_draw(data_out_inf:"data_out_inf",axis_in:"axis_in")

        large_name_len(data_out_inf,axis_in)
"
// FilePath:::../../axi/AXI_stream/axis_to_data_inf.sv
axis_to_data_inf axis_to_data_inf_#{signal}_inst(
/*  data_inf_c.master    */ .data_out_inf (#{align_signal(data_out_inf,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .axis_in      (#{align_signal(axis_in,q_mark=false)})
);
"
    end
    
    def self.axis_to_data_inf(data_out_inf:"data_out_inf",axis_in:"axis_in")
        return_stream = nil
        
        
        AxiStream.NC._axis_to_data_inf(data_out_inf:data_out_inf,axis_in:axis_in)
        return return_stream
    end
        

end


class TdlTest

    def self.test_axis_to_data_inf
        c0 = Clock.new(name:"axis_to_data_inf_clk",freqM:148.5)
        r0 = Reset.new(name:"axis_to_data_inf_rst_n",active:"low")

        data_out_inf = DataInf_C.new(name:"data_out_inf",clock:c0,reset:r0)
        axis_in = AxiStream.new(name:"axis_in",clock:c0,reset:r0)
        
        
        AxiStream.axis_to_data_inf(data_out_inf:data_out_inf,axis_in:axis_in)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axis_to_data_inf(
        data_out_inf:"data_out_inf",
        axis_in:"axis_in")
        hash = TdlHash.new
        
        unless data_out_inf.is_a? Hash
            hash.case_record(:data_out_inf,data_out_inf)
        else
            # hash.new_index(:data_out_inf)= lambda { a = DataInf_C.new(data_out_inf);a.name = "data_out_inf";return a }
            # hash[:data_out_inf] = lambda { a = DataInf_C.new(data_out_inf);a.name = "data_out_inf";return a }
            raise TdlError.new('axis_to_data_inf DataInf_C data_out_inf TdlHash cant include Proc') if data_out_inf.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = DataInf_C.new(data_out_inf)
                unless data_out_inf[:name]
                    a.name = "data_out_inf"
                end
                return a }
            hash.[]=(:data_out_inf,lam,false)
        end
                

        unless axis_in.is_a? Hash
            hash.case_record(:axis_in,axis_in)
        else
            # hash.new_index(:axis_in)= lambda { a = AxiStream.new(axis_in);a.name = "axis_in";return a }
            # hash[:axis_in] = lambda { a = AxiStream.new(axis_in);a.name = "axis_in";return a }
            raise TdlError.new('axis_to_data_inf AxiStream axis_in TdlHash cant include Proc') if axis_in.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(axis_in)
                unless axis_in[:name]
                    a.name = "axis_in"
                end
                return a }
            hash.[]=(:axis_in,lam,false)
        end
                

        hash.push_to_module_stack(AxiStream,:axis_to_data_inf)
        hash.open_error = true
        return hash
    end
end
