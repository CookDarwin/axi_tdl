
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def _data_to_axis_inf(mark_curr_data:"mark_curr_data",last_flag:"last_flag",data_slaver:"data_slaver",axis_master:"axis_master")

        Tdl.add_to_all_file_paths(['data_to_axis_inf','../../axi/AXI_stream/data_to_axis_inf.sv'])
        return_stream = self
        
        data_slaver = DataInf_C.same_name_socket(:from_up,mix=true,data_slaver) unless data_slaver.is_a? String
        axis_master = AxiStream.same_name_socket(:to_down,mix=true,axis_master) unless axis_master.is_a? String
        
        
        

         @instance_draw_stack << lambda { _data_to_axis_inf_draw(mark_curr_data:mark_curr_data,last_flag:last_flag,data_slaver:data_slaver,axis_master:axis_master) }
        return return_stream
    end

    def _data_to_axis_inf_draw(mark_curr_data:"mark_curr_data",last_flag:"last_flag",data_slaver:"data_slaver",axis_master:"axis_master")

        large_name_len(mark_curr_data,last_flag,data_slaver,axis_master)
"
// FilePath:::../../axi/AXI_stream/data_to_axis_inf.sv
data_to_axis_inf data_to_axis_inf_#{signal}_inst(
/*  input                */ .mark_curr_data (#{align_signal(mark_curr_data,q_mark=false)}),
/*  input                */ .last_flag      (#{align_signal(last_flag,q_mark=false)}),
/*  data_inf_c.slaver    */ .data_slaver    (#{align_signal(data_slaver,q_mark=false)}),
/*  axi_stream_inf.master*/ .axis_master    (#{align_signal(axis_master,q_mark=false)})
);
"
    end
    
    def self.data_to_axis_inf(mark_curr_data:"mark_curr_data",last_flag:"last_flag",data_slaver:"data_slaver",axis_master:"axis_master")
        return_stream = nil
        
        
        AxiStream.NC._data_to_axis_inf(mark_curr_data:mark_curr_data,last_flag:last_flag,data_slaver:data_slaver,axis_master:axis_master)
        return return_stream
    end
        

end


class TdlTest

    def self.test_data_to_axis_inf
        c0 = Clock.new(name:"data_to_axis_inf_clk",freqM:148.5)
        r0 = Reset.new(name:"data_to_axis_inf_rst_n",active:"low")

        mark_curr_data = Logic.new(name:"mark_curr_data")
        last_flag = Logic.new(name:"last_flag")
        data_slaver = DataInf_C.new(name:"data_slaver",clock:c0,reset:r0)
        axis_master = AxiStream.new(name:"axis_master",clock:c0,reset:r0)
        
        
        AxiStream.data_to_axis_inf(mark_curr_data:mark_curr_data,last_flag:last_flag,data_slaver:data_slaver,axis_master:axis_master)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_data_to_axis_inf(
        mark_curr_data:"mark_curr_data",
        last_flag:"last_flag",
        data_slaver:"data_slaver",
        axis_master:"axis_master")
        hash = TdlHash.new
        
        unless mark_curr_data.is_a? Hash
            hash.case_record(:mark_curr_data,mark_curr_data)
        else
            # hash.new_index(:mark_curr_data)= lambda { a = Logic.new(mark_curr_data);a.name = "mark_curr_data";return a }
            # hash[:mark_curr_data] = lambda { a = Logic.new(mark_curr_data);a.name = "mark_curr_data";return a }
            raise TdlError.new('data_to_axis_inf Logic mark_curr_data TdlHash cant include Proc') if mark_curr_data.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(mark_curr_data)
                unless mark_curr_data[:name]
                    a.name = "mark_curr_data"
                end
                return a }
            hash.[]=(:mark_curr_data,lam,false)
        end
                

        unless last_flag.is_a? Hash
            hash.case_record(:last_flag,last_flag)
        else
            # hash.new_index(:last_flag)= lambda { a = Logic.new(last_flag);a.name = "last_flag";return a }
            # hash[:last_flag] = lambda { a = Logic.new(last_flag);a.name = "last_flag";return a }
            raise TdlError.new('data_to_axis_inf Logic last_flag TdlHash cant include Proc') if last_flag.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(last_flag)
                unless last_flag[:name]
                    a.name = "last_flag"
                end
                return a }
            hash.[]=(:last_flag,lam,false)
        end
                

        unless data_slaver.is_a? Hash
            hash.case_record(:data_slaver,data_slaver)
        else
            # hash.new_index(:data_slaver)= lambda { a = DataInf_C.new(data_slaver);a.name = "data_slaver";return a }
            # hash[:data_slaver] = lambda { a = DataInf_C.new(data_slaver);a.name = "data_slaver";return a }
            raise TdlError.new('data_to_axis_inf DataInf_C data_slaver TdlHash cant include Proc') if data_slaver.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = DataInf_C.new(data_slaver)
                unless data_slaver[:name]
                    a.name = "data_slaver"
                end
                return a }
            hash.[]=(:data_slaver,lam,false)
        end
                

        unless axis_master.is_a? Hash
            hash.case_record(:axis_master,axis_master)
        else
            # hash.new_index(:axis_master)= lambda { a = AxiStream.new(axis_master);a.name = "axis_master";return a }
            # hash[:axis_master] = lambda { a = AxiStream.new(axis_master);a.name = "axis_master";return a }
            raise TdlError.new('data_to_axis_inf AxiStream axis_master TdlHash cant include Proc') if axis_master.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(axis_master)
                unless axis_master[:name]
                    a.name = "axis_master"
                end
                return a }
            hash.[]=(:axis_master,lam,false)
        end
                

        hash.push_to_module_stack(AxiStream,:data_to_axis_inf)
        hash.open_error = true
        return hash
    end
end
