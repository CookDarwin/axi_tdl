
#2017-06-21 14:20:16 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def _data_to_axis_inf_a1(last_flag:"last_flag",data_slaver:"data_slaver",axis_master:"axis_master")



        $_draw = lambda { _data_to_axis_inf_a1_draw(last_flag:last_flag,data_slaver:data_slaver,axis_master:axis_master) }
        @correlation_proc += $_draw.call
        return self
    end

    def _data_to_axis_inf_a1_draw(last_flag:"last_flag",data_slaver:"data_slaver",axis_master:"axis_master")
        large_name_len(last_flag,data_slaver,axis_master)
"
data_to_axis_inf_A1 data_to_axis_inf_a1_#{signal}_inst(
/*  input                */ .last_flag   (#{align_signal(last_flag,q_mark=false)}),
/*  data_inf_c.slaver    */ .data_slaver (#{align_signal(data_slaver,q_mark=false)}),
/*  axi_stream_inf.master*/ .axis_master (#{align_signal(axis_master,q_mark=false)})
);
"
    end

    def self.data_to_axis_inf_a1(last_flag:"last_flag",data_slaver:"data_slaver",axis_master:"axis_master")
        NC._data_to_axis_inf_a1(last_flag:last_flag,data_slaver:data_slaver,axis_master:axis_master)

    end


end


class TdlTest

    def self.test_data_to_axis_inf_a1
        c0 = Clock.new(name:"data_to_axis_inf_a1_clk",freqM:148.5)
        r0 = Reset.new(name:"data_to_axis_inf_a1_rst_n",active:"low")

        Logic.new(name:"last_flag")
        DataInf_C.new(name:"data_slaver",clock:c0,reset:r0)
        AxiStream.new(name:"axis_master",clock:c0,reset:r0)


        AxiStream.data_to_axis_inf_a1(last_flag:last_flag,data_slaver:data_slaver,axis_master:axis_master)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def self.inst_data_to_axis_inf_a1(last_flag:"last_flag",data_slaver:"data_slaver",axis_master:"axis_master")
        hash = TdlHash.new

        unless last_flag.is_a? Hash
            # hash.new_index(:last_flag) = last_flag
            if last_flag.is_a? InfElm
                hash.[]=(:last_flag,last_flag,true)
            else
                hash.[]=(:last_flag,last_flag,false)
            end
        else
            # hash.new_index(:last_flag)= lambda { a = Logic.new(last_flag);a.name = "last_flag";return a }
            # hash[:last_flag] = lambda { a = Logic.new(last_flag);a.name = "last_flag";return a }
            hash.[]=(:last_flag,lambda { a = Logic.new(last_flag);a.name = "last_flag";return a },false)
        end


        unless data_slaver.is_a? Hash
            # hash.new_index(:data_slaver) = data_slaver
            if data_slaver.is_a? InfElm
                hash.[]=(:data_slaver,data_slaver,true)
            else
                hash.[]=(:data_slaver,data_slaver,false)
            end
        else
            # hash.new_index(:data_slaver)= lambda { a = DataInf_C.new(data_slaver);a.name = "data_slaver";return a }
            # hash[:data_slaver] = lambda { a = DataInf_C.new(data_slaver);a.name = "data_slaver";return a }
            hash.[]=(:data_slaver,lambda { a = DataInf_C.new(data_slaver);a.name = "data_slaver";return a },false)
        end


        unless axis_master.is_a? Hash
            # hash.new_index(:axis_master) = axis_master
            if axis_master.is_a? InfElm
                hash.[]=(:axis_master,axis_master,true)
            else
                hash.[]=(:axis_master,axis_master,false)
            end
        else
            # hash.new_index(:axis_master)= lambda { a = AxiStream.new(axis_master);a.name = "axis_master";return a }
            # hash[:axis_master] = lambda { a = AxiStream.new(axis_master);a.name = "axis_master";return a }
            hash.[]=(:axis_master,lambda { a = AxiStream.new(axis_master);a.name = "axis_master";return a },false)
        end


        Tdl.module_stack  << lambda {
            hash.each do |k,v|
                if v.is_a? Proc
                    hash.[]=(k,v.call,false)
                elsif v.is_a? Array
                    unless v.empty?
                        if v[0].is_a? Axi4
                            cm = v[0].copy(name:k,idsize:Math.log2(v.length).ceil+v[0].idsize)
                        else
                            cm = v[0].copy(name:k)
                        end
                        cm.<<(*v)
                        # hash[k] = cm
                        hash.[]=(k,cm)
                    else
                        hash.[]=(k,nil,false)
                    end
                else
                    # hash[k] = v
                end
            end
            hash.check_use("data_to_axis_inf_a1")
            AxiStream.data_to_axis_inf_a1(hash)
        }
        return hash
    end
end
