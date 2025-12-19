
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class DataInf_C


    def data_condition_mirror(h:0,l:0,condition_data:"condition_data",data_in:"data_in",data_out:"data_out",data_mirror:"data_mirror",up_stream:nil,down_stream:nil)

        Tdl.add_to_all_file_paths(['data_condition_mirror','../../axi/data_interface/data_inf_c/data_condition_mirror.sv'])
        return_stream = self
        
        data_in = DataInf_C.same_name_socket(:from_up,mix=true,data_in) unless data_in.is_a? String
        data_out = DataInf_C.same_name_socket(:to_down,mix=true,data_out) unless data_out.is_a? String
        data_mirror = DataInf_C.same_name_socket(:to_down,mix=true,data_mirror) unless data_mirror.is_a? String
        
        if up_stream==nil && data_in=="data_in"
            up_stream = self.copy(name:"data_in")
            return_stream = up_stream
        end

        data_in = up_stream if up_stream
        data_out = self unless self==DataInf_C.NC

         @instance_draw_stack << lambda { data_condition_mirror_draw(h:h,l:l,condition_data:condition_data,data_in:data_in,data_out:data_out,data_mirror:data_mirror,up_stream:up_stream,down_stream:down_stream) }
        return return_stream
    end

    def data_condition_mirror_draw(h:0,l:0,condition_data:"condition_data",data_in:"data_in",data_out:"data_out",data_mirror:"data_mirror",up_stream:nil,down_stream:nil)

        large_name_len(h,l,condition_data,data_in,data_out,data_mirror)
"
// FilePath:::../../axi/data_interface/data_inf_c/data_condition_mirror.sv
data_condition_mirror#(
    .H    (#{align_signal(h)}),
    .L    (#{align_signal(l)})
) data_condition_mirror_#{signal}_inst(
/*  input  [H:L]     */ .condition_data (#{align_signal(condition_data,q_mark=false)}),
/*  data_inf_c.slaver*/ .data_in        (#{align_signal(data_in,q_mark=false)}),
/*  data_inf_c.master*/ .data_out       (#{align_signal(data_out,q_mark=false)}),
/*  data_inf_c.master*/ .data_mirror    (#{align_signal(data_mirror,q_mark=false)})
);
"
    end
    
    def self.data_condition_mirror(h:0,l:0,condition_data:"condition_data",data_in:"data_in",data_out:"data_out",data_mirror:"data_mirror",up_stream:nil,down_stream:nil)
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
            down_stream.data_condition_mirror(h:h,l:l,condition_data:condition_data,data_in:data_in,data_out:data_out,data_mirror:data_mirror,up_stream:up_stream,down_stream:down_stream)
        elsif data_out.is_a? DataInf_C
            data_out.data_condition_mirror(h:h,l:l,condition_data:condition_data,data_in:data_in,data_out:data_out,data_mirror:data_mirror,up_stream:up_stream,down_stream:down_stream)
        else
            DataInf_C.NC.data_condition_mirror(h:h,l:l,condition_data:condition_data,data_in:data_in,data_out:data_out,data_mirror:data_mirror,up_stream:up_stream,down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_data_condition_mirror
        c0 = Clock.new(name:"data_condition_mirror_clk",freqM:148.5)
        r0 = Reset.new(name:"data_condition_mirror_rst_n",active:"low")

        h = Parameter.new(name:"h",value:0)
        l = Parameter.new(name:"l",value:0)
        condition_data = Logic.new(name:"condition_data")
        data_in = DataInf_C.new(name:"data_in",clock:c0,reset:r0)
        data_out = DataInf_C.new(name:"data_out",clock:c0,reset:r0)
        data_mirror = DataInf_C.new(name:"data_mirror",clock:c0,reset:r0)
        up_stream = data_in
        down_stream = data_out
        DataInf_C.data_condition_mirror(h:h,l:l,condition_data:condition_data,data_in:data_in,data_out:data_out,data_mirror:data_mirror)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_data_condition_mirror(
        h:0,
        l:0,
        condition_data:"condition_data",
        data_in:"data_in",
        data_out:"data_out",
        data_mirror:"data_mirror")
        hash = TdlHash.new
        
        unless h.is_a? Hash
            hash.case_record(:h,h)
        else
            # hash.new_index(:h)= lambda { a = Parameter.new(h);a.name = "h";return a }
            # hash[:h] = lambda { a = Parameter.new(h);a.name = "h";return a }
            raise TdlError.new('data_condition_mirror Parameter h TdlHash cant include Proc') if h.select{ |k,v| v.is_a? Proc }.any?
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
            raise TdlError.new('data_condition_mirror Parameter l TdlHash cant include Proc') if l.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(l)
                unless l[:name]
                    a.name = "l"
                end
                return a }
            hash.[]=(:l,lam,false)
        end
                

        unless condition_data.is_a? Hash
            hash.case_record(:condition_data,condition_data)
        else
            # hash.new_index(:condition_data)= lambda { a = Logic.new(condition_data);a.name = "condition_data";return a }
            # hash[:condition_data] = lambda { a = Logic.new(condition_data);a.name = "condition_data";return a }
            raise TdlError.new('data_condition_mirror Logic condition_data TdlHash cant include Proc') if condition_data.select{ |k,v| v.is_a? Proc }.any?
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
            raise TdlError.new('data_condition_mirror DataInf_C data_in TdlHash cant include Proc') if data_in.select{ |k,v| v.is_a? Proc }.any?
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
            raise TdlError.new('data_condition_mirror DataInf_C data_out TdlHash cant include Proc') if data_out.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = DataInf_C.new(data_out)
                unless data_out[:name]
                    a.name = "data_out"
                end
                return a }
            hash.[]=(:data_out,lam,false)
        end
                

        unless data_mirror.is_a? Hash
            hash.case_record(:data_mirror,data_mirror)
        else
            # hash.new_index(:data_mirror)= lambda { a = DataInf_C.new(data_mirror);a.name = "data_mirror";return a }
            # hash[:data_mirror] = lambda { a = DataInf_C.new(data_mirror);a.name = "data_mirror";return a }
            raise TdlError.new('data_condition_mirror DataInf_C data_mirror TdlHash cant include Proc') if data_mirror.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = DataInf_C.new(data_mirror)
                unless data_mirror[:name]
                    a.name = "data_mirror"
                end
                return a }
            hash.[]=(:data_mirror,lam,false)
        end
                

        hash.push_to_module_stack(DataInf_C,:data_condition_mirror)
        hash.open_error = true
        return hash
    end
end
