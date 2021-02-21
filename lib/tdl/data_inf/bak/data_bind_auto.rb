
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class DataInf_C


    def _data_bind(num:2,data_in:"data_in",data_out:"data_out")

        Tdl.add_to_all_file_paths(['data_bind','../../axi/data_interface/data_inf_c/data_bind.sv'])
        return_stream = self
        
        data_in = DataInf_C.same_name_socket(:from_up,mix=false,data_in) unless data_in.is_a? String
        data_out = DataInf_C.same_name_socket(:to_down,mix=true,data_out) unless data_out.is_a? String
        
        
        

         @instance_draw_stack << lambda { _data_bind_draw(num:num,data_in:data_in,data_out:data_out) }
        return return_stream
    end

    def _data_bind_draw(num:2,data_in:"data_in",data_out:"data_out")

        large_name_len(num,data_in,data_out)
"
// FilePath:::../../axi/data_interface/data_inf_c/data_bind.sv
data_bind#(
    .NUM    (#{align_signal(num)})
) data_bind_#{signal}_inst(
/*  data_inf_c.slaver*/ .data_in  (#{align_signal(data_in,q_mark=false)}),
/*  data_inf_c.master*/ .data_out (#{align_signal(data_out,q_mark=false)})
);
"
    end
    
    def self.data_bind(num:2,data_in:"data_in",data_out:"data_out")
        return_stream = nil
        
        
        DataInf_C.NC._data_bind(num:num,data_in:data_in,data_out:data_out)
        return return_stream
    end
        

end


class TdlTest

    def self.test_data_bind
        c0 = Clock.new(name:"data_bind_clk",freqM:148.5)
        r0 = Reset.new(name:"data_bind_rst_n",active:"low")

        num = Parameter.new(name:"num",value:2)
        data_in = DataInf_C.new(name:"data_in",clock:c0,reset:r0)
        data_out = DataInf_C.new(name:"data_out",clock:c0,reset:r0)
        
        
        DataInf_C.data_bind(num:num,data_in:data_in,data_out:data_out)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_data_bind(
        num:2,
        data_in:"data_in",
        data_out:"data_out")
        hash = TdlHash.new
        
        unless num.is_a? Hash
            hash.case_record(:num,num)
        else
            # hash.new_index(:num)= lambda { a = Parameter.new(num);a.name = "num";return a }
            # hash[:num] = lambda { a = Parameter.new(num);a.name = "num";return a }
            raise TdlError.new('data_bind Parameter num TdlHash cant include Proc') if num.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Parameter.new(num)
                unless num[:name]
                    a.name = "num"
                end
                return a }
            hash.[]=(:num,lam,false)
        end
                

        unless data_in.is_a? Hash
            hash.case_record(:data_in,data_in)
        else
            # hash.new_index(:data_in)= lambda { a = DataInf_C.new(data_in);a.name = "data_in";return a }
            # hash[:data_in] = lambda { a = DataInf_C.new(data_in);a.name = "data_in";return a }
            raise TdlError.new('data_bind DataInf_C data_in TdlHash cant include Proc') if data_in.select{ |k,v| v.is_a? Proc }.any?
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
            raise TdlError.new('data_bind DataInf_C data_out TdlHash cant include Proc') if data_out.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = DataInf_C.new(data_out)
                unless data_out[:name]
                    a.name = "data_out"
                end
                return a }
            hash.[]=(:data_out,lam,false)
        end
                

        hash.push_to_module_stack(DataInf_C,:data_bind)
        hash.open_error = true
        return hash
    end
end
