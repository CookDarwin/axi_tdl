
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class DataInf_C


    def data_condition_valve(h:0,l:0,condition_button:"condition_button",condition_data:"condition_data",data_in:"data_in",data_out:"data_out",up_stream:nil,down_stream:nil)

        Tdl.add_to_all_file_paths(['data_condition_valve','../../axi/data_interface/data_inf_c/data_condition_valve.sv'])
        return_stream = self
        
        data_in = DataInf_C.same_name_socket(:from_up,mix=true,data_in) unless data_in.is_a? String
        data_out = DataInf_C.same_name_socket(:to_down,mix=true,data_out) unless data_out.is_a? String
        
        if up_stream==nil && data_in=="data_in"
            up_stream = self.copy(name:"data_in")
            return_stream = up_stream
        end

        data_in = up_stream if up_stream
        data_out = self unless self==DataInf_C.NC

         @instance_draw_stack << lambda { data_condition_valve_draw(h:h,l:l,condition_button:condition_button,condition_data:condition_data,data_in:data_in,data_out:data_out,up_stream:up_stream,down_stream:down_stream) }
        return return_stream
    end

    def data_condition_valve_draw(h:0,l:0,condition_button:"condition_button",condition_data:"condition_data",data_in:"data_in",data_out:"data_out",up_stream:nil,down_stream:nil)

        large_name_len(h,l,condition_button,condition_data,data_in,data_out)
"
// FilePath:::../../axi/data_interface/data_inf_c/data_condition_valve.sv
data_condition_valve#(
    .H    (#{align_signal(h)}),
    .L    (#{align_signal(l)})
) data_condition_valve_#{signal}_inst(
/*  input            */ .condition_button (#{align_signal(condition_button,q_mark=false)}),
/*  input  [H:L]     */ .condition_data   (#{align_signal(condition_data,q_mark=false)}),
/*  data_inf_c.slaver*/ .data_in          (#{align_signal(data_in,q_mark=false)}),
/*  data_inf_c.master*/ .data_out         (#{align_signal(data_out,q_mark=false)})
);
"
    end
    
    def self.data_condition_valve(h:0,l:0,condition_button:"condition_button",condition_data:"condition_data",data_in:"data_in",data_out:"data_out",up_stream:nil,down_stream:nil)
        return_stream = nil
        
        if down_stream==nil && data_out=="data_out"
            if up_stream.is_a? DataInf_C
                down_stream = up_stream.copy(name:"data_out")
            else
                down_stream = data_in.copy(name:"data_out")
            end
            return_stream = down_stream
        end

        
        if up_stream==nil && data_in=="data_in"
            if down_stream.is_a? DataInf_C
                up_stream = down_stream.copy(name:"data_in")
            else
                up_stream = data_out.copy(name:"data_in")
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? DataInf_C
            down_stream.data_condition_valve(h:h,l:l,condition_button:condition_button,condition_data:condition_data,data_in:data_in,data_out:data_out,up_stream:up_stream,down_stream:down_stream)
        elsif data_out.is_a? DataInf_C
            data_out.data_condition_valve(h:h,l:l,condition_button:condition_button,condition_data:condition_data,data_in:data_in,data_out:data_out,up_stream:up_stream,down_stream:down_stream)
        else
            DataInf_C.NC.data_condition_valve(h:h,l:l,condition_button:condition_button,condition_data:condition_data,data_in:data_in,data_out:data_out,up_stream:up_stream,down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_data_condition_valve
        c0 = Clock.new(name:"data_condition_valve_clk",freqM:148.5)
        r0 = Reset.new(name:"data_condition_valve_rst_n",active:"low")

        h = Parameter.new(name:"h",value:0)
        l = Parameter.new(name:"l",value:0)
        condition_button = Logic.new(name:"condition_button")
        condition_data = Logic.new(name:"condition_data")
        data_in = DataInf_C.new(name:"data_in",clock:c0,reset:r0)
        data_out = DataInf_C.new(name:"data_out",clock:c0,reset:r0)
        up_stream = data_in
        down_stream = data_out
        DataInf_C.data_condition_valve(h:h,l:l,condition_button:condition_button,condition_data:condition_data,data_in:data_in,data_out:data_out)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_data_condition_valve(
        h:0,
        l:0,
        condition_button:"condition_button",
        condition_data:"condition_data",
        data_in:"data_in",
        data_out:"data_out")
        hash = TdlHash.new
        
        unless h.is_a? Hash
            hash.case_record(:h,h)
        else
            # hash.new_index(:h)= lambda { a = Parameter.new(h);a.name = "h";return a }
            # hash[:h] = lambda { a = Parameter.new(h);a.name = "h";return a }
            raise TdlError.new('data_condition_valve Parameter h TdlHash cant include Proc') if h.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(h)
                unless h[:name]
                    a.name = "h"
                end
                return a }
            hash.[]=(:h,lam,false)
        end
                

        unless l.is_a? Hash
            hash.case_record(:l,l)
        else
            # hash.new_index(:l)= lambda { a = Parameter.new(l);a.name = "l";return a }
            # hash[:l] = lambda { a = Parameter.new(l);a.name = "l";return a }
            raise TdlError.new('data_condition_valve Parameter l TdlHash cant include Proc') if l.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(l)
                unless l[:name]
                    a.name = "l"
                end
                return a }
            hash.[]=(:l,lam,false)
        end
                

        unless condition_button.is_a? Hash
            hash.case_record(:condition_button,condition_button)
        else
            # hash.new_index(:condition_button)= lambda { a = Logic.new(condition_button);a.name = "condition_button";return a }
            # hash[:condition_button] = lambda { a = Logic.new(condition_button);a.name = "condition_button";return a }
            raise TdlError.new('data_condition_valve Logic condition_button TdlHash cant include Proc') if condition_button.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(condition_button)
                unless condition_button[:name]
                    a.name = "condition_button"
                end
                return a }
            hash.[]=(:condition_button,lam,false)
        end
                

        unless condition_data.is_a? Hash
            hash.case_record(:condition_data,condition_data)
        else
            # hash.new_index(:condition_data)= lambda { a = Logic.new(condition_data);a.name = "condition_data";return a }
            # hash[:condition_data] = lambda { a = Logic.new(condition_data);a.name = "condition_data";return a }
            raise TdlError.new('data_condition_valve Logic condition_data TdlHash cant include Proc') if condition_data.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(condition_data)
                unless condition_data[:name]
                    a.name = "condition_data"
                end
                return a }
            hash.[]=(:condition_data,lam,false)
        end
                

        unless data_in.is_a? Hash
            hash.case_record(:data_in,data_in)
        else
            # hash.new_index(:data_in)= lambda { a = DataInf_C.new(data_in);a.name = "data_in";return a }
            # hash[:data_in] = lambda { a = DataInf_C.new(data_in);a.name = "data_in";return a }
            raise TdlError.new('data_condition_valve DataInf_C data_in TdlHash cant include Proc') if data_in.select{ |k,v| v.is_a? Proc }.any?
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
            raise TdlError.new('data_condition_valve DataInf_C data_out TdlHash cant include Proc') if data_out.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = DataInf_C.new(data_out)
                unless data_out[:name]
                    a.name = "data_out"
                end
                return a }
            hash.[]=(:data_out,lam,false)
        end
                

        hash.push_to_module_stack(DataInf_C,:data_condition_valve)
        hash.open_error = true
        return hash
    end
end
