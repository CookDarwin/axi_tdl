
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class DataInf_C


    def data_inf_c_pipe_condition(and_condition:"and_condition",indata:"indata",outdata:"outdata",up_stream:nil,down_stream:nil)

        Tdl.add_to_all_file_paths(['data_inf_c_pipe_condition','../../axi/data_interface/data_inf_c/data_inf_c_pipe_condition.sv'])
        return_stream = self
        
        indata = DataInf_C.same_name_socket(:from_up,mix=true,indata) unless indata.is_a? String
        outdata = DataInf_C.same_name_socket(:to_down,mix=true,outdata) unless outdata.is_a? String
        
        if up_stream==nil && indata=="indata"
            up_stream = self.copy(name:"indata")
            return_stream = up_stream
        end

        indata = up_stream if up_stream
        outdata = self unless self==DataInf_C.NC

         @instance_draw_stack << lambda { data_inf_c_pipe_condition_draw(and_condition:and_condition,indata:indata,outdata:outdata,up_stream:up_stream,down_stream:down_stream) }
        return return_stream
    end

    def data_inf_c_pipe_condition_draw(and_condition:"and_condition",indata:"indata",outdata:"outdata",up_stream:nil,down_stream:nil)

        large_name_len(and_condition,indata,outdata)
"
// FilePath:::../../axi/data_interface/data_inf_c/data_inf_c_pipe_condition.sv
data_inf_c_pipe_condition data_inf_c_pipe_condition_#{signal}_inst(
/*  input            */ .and_condition (#{align_signal(and_condition,q_mark=false)}),
/*  data_inf_c.slaver*/ .indata        (#{align_signal(indata,q_mark=false)}),
/*  data_inf_c.master*/ .outdata       (#{align_signal(outdata,q_mark=false)})
);
"
    end
    
    def self.data_inf_c_pipe_condition(and_condition:"and_condition",indata:"indata",outdata:"outdata",up_stream:nil,down_stream:nil)
        return_stream = nil
        
        if down_stream==nil && outdata=="outdata"
            if up_stream.is_a? DataInf_C
                down_stream = up_stream.copy(name:"outdata")
            else
                down_stream = indata.copy(name:"outdata")
            end
            return_stream = down_stream
        end

        
        if up_stream==nil && indata=="indata"
            if down_stream.is_a? DataInf_C
                up_stream = down_stream.copy(name:"indata")
            else
                up_stream = outdata.copy(name:"indata")
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? DataInf_C
            down_stream.data_inf_c_pipe_condition(and_condition:and_condition,indata:indata,outdata:outdata,up_stream:up_stream,down_stream:down_stream)
        elsif outdata.is_a? DataInf_C
            outdata.data_inf_c_pipe_condition(and_condition:and_condition,indata:indata,outdata:outdata,up_stream:up_stream,down_stream:down_stream)
        else
            DataInf_C.NC.data_inf_c_pipe_condition(and_condition:and_condition,indata:indata,outdata:outdata,up_stream:up_stream,down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_data_inf_c_pipe_condition
        c0 = Clock.new(name:"data_inf_c_pipe_condition_clk",freqM:148.5)
        r0 = Reset.new(name:"data_inf_c_pipe_condition_rst_n",active:"low")

        and_condition = Logic.new(name:"and_condition")
        indata = DataInf_C.new(name:"indata",clock:c0,reset:r0)
        outdata = DataInf_C.new(name:"outdata",clock:c0,reset:r0)
        up_stream = indata
        down_stream = outdata
        DataInf_C.data_inf_c_pipe_condition(and_condition:and_condition,indata:indata,outdata:outdata)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_data_inf_c_pipe_condition(
        and_condition:"and_condition",
        indata:"indata",
        outdata:"outdata")
        hash = TdlHash.new
        
        unless and_condition.is_a? Hash
            hash.case_record(:and_condition,and_condition)
        else
            # hash.new_index(:and_condition)= lambda { a = Logic.new(and_condition);a.name = "and_condition";return a }
            # hash[:and_condition] = lambda { a = Logic.new(and_condition);a.name = "and_condition";return a }
            raise TdlError.new('data_inf_c_pipe_condition Logic and_condition TdlHash cant include Proc') if and_condition.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(and_condition)
                unless and_condition[:name]
                    a.name = "and_condition"
                end
                return a }
            hash.[]=(:and_condition,lam,false)
        end
                

        unless indata.is_a? Hash
            hash.case_record(:indata,indata)
        else
            # hash.new_index(:indata)= lambda { a = DataInf_C.new(indata);a.name = "indata";return a }
            # hash[:indata] = lambda { a = DataInf_C.new(indata);a.name = "indata";return a }
            raise TdlError.new('data_inf_c_pipe_condition DataInf_C indata TdlHash cant include Proc') if indata.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = DataInf_C.new(indata)
                unless indata[:name]
                    a.name = "indata"
                end
                return a }
            hash.[]=(:indata,lam,false)
        end
                

        unless outdata.is_a? Hash
            hash.case_record(:outdata,outdata)
        else
            # hash.new_index(:outdata)= lambda { a = DataInf_C.new(outdata);a.name = "outdata";return a }
            # hash[:outdata] = lambda { a = DataInf_C.new(outdata);a.name = "outdata";return a }
            raise TdlError.new('data_inf_c_pipe_condition DataInf_C outdata TdlHash cant include Proc') if outdata.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = DataInf_C.new(outdata)
                unless outdata[:name]
                    a.name = "outdata"
                end
                return a }
            hash.[]=(:outdata,lam,false)
        end
                

        hash.push_to_module_stack(DataInf_C,:data_inf_c_pipe_condition)
        hash.open_error = true
        return hash
    end
end
