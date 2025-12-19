# require_relative "./tdlerror"
# require_relative "./basefunc"
class Reset < SignalElm
    include BaseModule
    attr_reader :name,:active
    attr_accessor :id,:ghost,:port,:dsize

    def initialize(name:"system_rst",active:"LOW",port:false,dsize:1, belong_to_module: nil)
        name_legal?(name)
        # @id = GlobalParam.CurrTdlModule.BindEleClassVars.Reset.id
        @dsize = dsize
        @name = name
        @port = port
        @active = active.to_s.downcase
        if @active.eql?("low") && @active.eql?("high")
            raise TdlError.new("RESET ACTIVE PARA #{@active} ERROR")
        end
        @belong_to_module = belong_to_module
        unless @belong_to_module 
            raise TdlError.new("Reset<#{name}> dnot have belong_to_module")
        end
    end

    # def signal
    #     if @port
    #         @name.to_s
    #     else
    #         if(active.eql? "low")
    #             "rst_#{@name}_id#{@id}_n"
    #         else
    #             "rst_#{@name}_id#{@id}"
    #         end
    #     end
    # end

    # def port_length
    #     (@port.to_s + " ").length
    # end

    def inst_port

        # if @port
        #     (@port.to_s + " " + " "*sub_len + @name.to_s)
        # end

        if dsize.eql? 1
            n = ""
        else
            n = "[#{(@dsize-1)}:0]"
        end

        return [@port.to_s+n,@name.to_s,""]
    end

    # def left_port_length
    #     ("/*  input" + " */ ").length
    # end
    #
    # def right_port_length
    #     (".#{@name.to_s} ").length
    # end
    #
    # def ex_port(left_align_len = 7,right_align_len = 7)
    #     if left_align_len >=  left_port_length
    #         sub_left_len = left_align_len -  left_port_length
    #     else
    #         sub_left_len = 0
    #     end
    #
    #     if right_align_len >=  right_port_length
    #         sub_right_len = right_align_len -  right_port_length
    #     else
    #         sub_right_len = 0
    #     end
    #
    #     if @port
    #         ("/*  input" + " "*sub_left_len + "*/ " + "."+@name.to_s + " "*sub_right_len)
    #     end
    # end

    def low_signal
        if(active.eql? "low")
            signal
        else
            NqString.new("~").concat signal
        end
    end

    def high_signal
        if(active.eql? "low")
            NqString.new("~").concat signal
        else
            signal
        end
    end

    # def inst
    #     unless @ghost
    #         # "logic  #{signal};"
    #         if dsize.eql?(1)
    #             "logic  #{signal};"
    #         else
    #             if (@dsize.is_a? Numeric) && @dsize < 0
    #                 str = "logic [0:#{(-@dsize-1)}] #{signal};"
    #             else
    #                 str = "logic [#{(@dsize-1)}:0]  #{signal};"
    #             end
    #         end
    #     else
    #         ""
    #     end
    # end

    # def self.inst
    #     GlobalParam.CurrTdlModule.BindEleClassVars.Reset.inst_stack.map{|e| e.call }.join("")
    # end

    # def self.clear
    #     @@id = 1
    #     @@inst_stack = []
    #     @@ports = []
    #     @@nc = Reset.new(name:"nc_rst",active:"LOW")
    #     BaseElm.recfg_nc(@@nc)
    # end

    # NC = Reset.new(name:"nc_rst",active:"LOW")
    # NC.instance_variable_set("@_id",0)
    #
    # def NC.signal
    #     id = NC.instance_variable_get("@_id")
    #     NC.instance_variable_set("@_id",id+1).to_s
    # end

    # def self.NC
    #     GlobalParam.CurrTdlModule.BindEleClassVars.Reset.nc
    # end
    #
    # def self.nc_create
    #     Reset.new(name:"nc_rst",active:"LOW")
    # end
### parse text for autogen method and constant ###
    def self.parse_ports(port_str)
        rh = super.parse_ports(port_str)
        rh[:type]   = Reset
        return rh
    end
end

# Test.reset
