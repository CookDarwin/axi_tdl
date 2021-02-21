
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class DataInf_C


    def _data_valve(button:"button",data_in:"data_in",data_out:"data_out")

        Tdl.add_to_all_file_paths(['data_valve','../../axi/data_interface/data_inf_c/data_valve.sv'])
        return_stream = self
        
        data_in = DataInf_C.same_name_socket(:from_up,mix=true,data_in) unless data_in.is_a? String
        data_out = DataInf_C.same_name_socket(:to_down,mix=true,data_out) unless data_out.is_a? String
        
        
        

         @instance_draw_stack << lambda { _data_valve_draw(button:button,data_in:data_in,data_out:data_out) }
        return return_stream
    end

    def _data_valve_draw(button:"button",data_in:"data_in",data_out:"data_out")

        large_name_len(button,data_in,data_out)
"
// FilePath:::../../axi/data_interface/data_inf_c/data_valve.sv
data_valve data_valve_#{signal}_inst(
/*  input            */ .button   (#{align_signal(button,q_mark=false)}),
/*  data_inf_c.slaver*/ .data_in  (#{align_signal(data_in,q_mark=false)}),
/*  data_inf_c.master*/ .data_out (#{align_signal(data_out,q_mark=false)})
);
"
    end
    
    def self.data_valve(button:"button",data_in:"data_in",data_out:"data_out")
        return_stream = nil
        
        
        DataInf_C.NC._data_valve(button:button,data_in:data_in,data_out:data_out)
        return return_stream
    end
        

end


class TdlTest

    def self.test_data_valve
        c0 = Clock.new(name:"data_valve_clk",freqM:148.5)
        r0 = Reset.new(name:"data_valve_rst_n",active:"low")

        button = Logic.new(name:"button")
        data_in = DataInf_C.new(name:"data_in",clock:c0,reset:r0)
        data_out = DataInf_C.new(name:"data_out",clock:c0,reset:r0)
        
        
        DataInf_C.data_valve(button:button,data_in:data_in,data_out:data_out)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_data_valve(
        button:"button",
        data_in:"data_in",
        data_out:"data_out")
        hash = TdlHash.new
        
        unless button.is_a? Hash
            hash.case_record(:button,button)
        else
            # hash.new_index(:button)= lambda { a = Logic.new(button);a.name = "button";return a }
            # hash[:button] = lambda { a = Logic.new(button);a.name = "button";return a }
            raise TdlError.new('data_valve Logic button TdlHash cant include Proc') if button.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(button)
                unless button[:name]
                    a.name = "button"
                end
                return a }
            hash.[]=(:button,lam,false)
        end
                

        unless data_in.is_a? Hash
            hash.case_record(:data_in,data_in)
        else
            # hash.new_index(:data_in)= lambda { a = DataInf_C.new(data_in);a.name = "data_in";return a }
            # hash[:data_in] = lambda { a = DataInf_C.new(data_in);a.name = "data_in";return a }
            raise TdlError.new('data_valve DataInf_C data_in TdlHash cant include Proc') if data_in.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = DataInf_C.new(data_in)
                unless data_in[:name]
                    a.name = "data_in"
                end
                return a }
            hash.[]=(:data_in,lam,false)
        end
                

        unless data_out.is_a? Hash
            hash.case_record(:data_out,data_out)
        else
            # hash.new_index(:data_out)= lambda { a = DataInf_C.new(data_out);a.name = "data_out";return a }
            # hash[:data_out] = lambda { a = DataInf_C.new(data_out);a.name = "data_out";return a }
            raise TdlError.new('data_valve DataInf_C data_out TdlHash cant include Proc') if data_out.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = DataInf_C.new(data_out)
                unless data_out[:name]
                    a.name = "data_out"
                end
                return a }
            hash.[]=(:data_out,lam,false)
        end
                

        hash.push_to_module_stack(DataInf_C,:data_valve)
        hash.open_error = true
        return hash
    end
end
