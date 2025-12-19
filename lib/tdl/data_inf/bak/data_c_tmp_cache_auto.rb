
#2017-12-21 10:22:02 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class DataInf_C


    def data_c_tmp_cache(slaver:"slaver",master:"master",up_stream:nil,down_stream:nil)

        Tdl.add_to_all_file_paths(['data_c_tmp_cache','../../axi/data_interface/data_inf_c/data_c_tmp_cache.sv'])
        return_stream = self
        
        slaver = DataInf_C.same_name_socket(:from_up,mix=true,slaver) unless slaver.is_a? String
        master = DataInf_C.same_name_socket(:to_down,mix=true,master) unless master.is_a? String
        
        if up_stream==nil && slaver=="slaver"
            up_stream = self.copy(name:"slaver")
            return_stream = up_stream
        end

        slaver = up_stream if up_stream
        master = self unless self==DataInf_C.NC

         @instance_draw_stack << lambda { data_c_tmp_cache_draw(slaver:slaver,master:master,up_stream:up_stream,down_stream:down_stream) }
        return return_stream
    end

    def data_c_tmp_cache_draw(slaver:"slaver",master:"master",up_stream:nil,down_stream:nil)

        large_name_len(slaver,master)
"
// FilePath:::../../axi/data_interface/data_inf_c/data_c_tmp_cache.sv
data_c_tmp_cache data_c_tmp_cache_#{signal}_inst(
/*  data_inf_c.slaver*/ .slaver (#{align_signal(slaver,q_mark=false)}),
/*  data_inf_c.master*/ .master (#{align_signal(master,q_mark=false)})
);
"
    end
    
    def self.data_c_tmp_cache(slaver:"slaver",master:"master",up_stream:nil,down_stream:nil)
        return_stream = nil
        
        if down_stream==nil && master=="master"
            if up_stream.is_a? DataInf_C
                down_stream = up_stream.copy(name:"master")
            else
                down_stream = slaver.copy(name:"master")
            end
            return_stream = down_stream
        end

        
        if up_stream==nil && slaver=="slaver"
            if down_stream.is_a? DataInf_C
                up_stream = down_stream.copy(name:"slaver")
            else
                up_stream = master.copy(name:"slaver")
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? DataInf_C
            down_stream.data_c_tmp_cache(slaver:slaver,master:master,up_stream:up_stream,down_stream:down_stream)
        elsif master.is_a? DataInf_C
            master.data_c_tmp_cache(slaver:slaver,master:master,up_stream:up_stream,down_stream:down_stream)
        else
            DataInf_C.NC.data_c_tmp_cache(slaver:slaver,master:master,up_stream:up_stream,down_stream:down_stream)
        end
        return return_stream
    end
        

end


class TdlTest

    def self.test_data_c_tmp_cache
        c0 = Clock.new(name:"data_c_tmp_cache_clk",freqM:148.5)
        r0 = Reset.new(name:"data_c_tmp_cache_rst_n",active:"low")

        slaver = DataInf_C.new(name:"slaver",clock:c0,reset:r0)
        master = DataInf_C.new(name:"master",clock:c0,reset:r0)
        up_stream = slaver
        down_stream = master
        DataInf_C.data_c_tmp_cache(slaver:slaver,master:master)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_data_c_tmp_cache(
        slaver:"slaver",
        master:"master")
        hash = TdlHash.new
        
        unless slaver.is_a? Hash
            hash.case_record(:slaver,slaver)
        else
            # hash.new_index(:slaver)= lambda { a = DataInf_C.new(slaver);a.name = "slaver";return a }
            # hash[:slaver] = lambda { a = DataInf_C.new(slaver);a.name = "slaver";return a }
            raise TdlError.new('data_c_tmp_cache DataInf_C slaver TdlHash cant include Proc') if slaver.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = DataInf_C.new(slaver)
                unless slaver[:name]
                    a.name = "slaver"
                end
                return a }
            hash.[]=(:slaver,lam,false)
        end
                

        unless master.is_a? Hash
            hash.case_record(:master,master)
        else
            # hash.new_index(:master)= lambda { a = DataInf_C.new(master);a.name = "master";return a }
            # hash[:master] = lambda { a = DataInf_C.new(master);a.name = "master";return a }
            raise TdlError.new('data_c_tmp_cache DataInf_C master TdlHash cant include Proc') if master.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = DataInf_C.new(master)
                unless master[:name]
                    a.name = "master"
                end
                return a }
            hash.[]=(:master,lam,false)
        end
                

        hash.push_to_module_stack(DataInf_C,:data_c_tmp_cache)
        hash.open_error = true
        return hash
    end
end
