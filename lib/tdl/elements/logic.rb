# require_relative "./tdlerror"
# require_relative "./basefunc"


$__tdl_cur_self__ = self

def Logic(name,dsize:1,dimension:[],assign:nil)
    a = Logic.new(name:name,dsize:dsize,dimension:dimension)
    $__tdl_cur_self__.send(:define_method,name) { a }
    if assign
        Assign { a <= assign }
    end
    nil
end

class Logic < SignalElm
    include BaseModule
    INPUT = "INPUT"
    OUTPUT = "OUTPUT"
    INOUT = "INOUT"
    # attr_reader :dsize
    attr_accessor :name,:dsize,:id,:ghost,:type
    attr_reader :dimension,:port
    def initialize(name:"tmp",dsize:1,port: false,default: nil,msb_high: true,dimension: [],type: "logic")
        @name   = name
        # @id = GlobalParam.CurrTdlModule.BindEleClassVars.Logic.id
        @dsize = dsize
        @port = port
        @default = default
        # @msb_high = msb_high
        @dimension = dimension
        @type = type
        # raise TdlError.new("#{name} DATA ERROR")  unless dsize.is_a? Fixnum
        # raise TdlError.new("STOP")  if @id == 10
        name_legal?(name)
        if block_given?
            yield
        end

        # if @port && (@port != :origin)
        #     GlobalParam.CurrTdlModule.BindEleClassVars.Logic.ports << self if @id != 0
        # else
        #     # @@inst_stack << method(:inst).to_proc
        #     GlobalParam.CurrTdlModule.BindEleClassVars.Logic.inst_stack << lambda{ inst() }
        # end
        # define_method(:signal) do |h,l|
        #     if h
        #         hh = h
        #     else
        #         hh = dsize-1
        #     end
        #
        #     if l
        #         ll = l
        #     else
        #         l = 0
        #     end
        #
        #     if dsize == 1
        #         "#{name}_id#{@id}"
        #     else
        #         "#{name}_id#{@id}[#{hh}:#{ll}]"
        #     end
        # end
    end

    def copy(name:@name.to_s,dsize:@dsize,port:@port,default:@default,msb_high:@msb_high,dimension:@dimension,type:@type,belong_to_module:@belong_to_module)
        append_name = name_copy(name)
        belong_to_module.Def.logic(name:append_name,dsize:dsize,port:port,default:default,msb_high:msb_high,dimension:dimension,type:type)
    end

    def active
        "low"
    end

    def [](a,b=nil)
        # if dimension.empty?
        #     if a.eql?(:all)
        #         square = ""
        #     elsif b
        #         square = "[#{a}:#{b}]"
        #     else
        #         square = "[#{a}]"
        #     end
    
        #     if @port
        #         NqString.new("#{@name.to_s}#{square}")
        #     else
        #         NqString.new("#{name}#{square}")
        #     end
        # else

        if a.is_a? ClassHDL::OpertorChain
            a.slaver = true
        end

        if b.is_a? ClassHDL::OpertorChain
            b.slaver = true
        end

        # RedefOpertor.with_normal_operators do
        #     TdlSpace::ArrayChain.new(self,a,b)
        # end
        # end
        ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
            TdlSpace::ArrayChain.new(self,a,b)
        end
    end

    def []=(a,b=nil,c)
        if a.is_a? ClassHDL::OpertorChain
            a.slaver = true
        end

        if b.is_a? ClassHDL::OpertorChain
            b.slaver = true
        end

        # b = a unless b
        if c.is_a? Logic
            cstr = c.signal
        elsif c.is_a? String
            cstr = c
        else
            ""
        end

        lbd = "assign #{self.[](a,b)} = #{cstr};"
        # GlobalParam.CurrTdlModule.BindEleClassVars.Logic.pre_inst << lambda do
        #     lbd
        # end
        belong_to_module.Logic_draw << lbd
        return lbd
    end

    def signal(h:nil,l:0,square:true)
        if h.is_a? Numeric
            if @dsize.is_a?(Numeric) && (h > @dsize-1)
                h = @dsize - 1
            end
            h = h
        elsif @dsize.is_a? Numeric
            h = (@dsize.abs-1)
        else
            h = "#{@dsize}-1"
        end

        if @port
            NqString.new (@name.to_s)
        elsif !square || @dimension.any?
            NqString.new("#{name}")
        elsif dsize.eql? 1
            NqString.new("#{name}")
        else
            NqString.new("#{name}[#{h}:#{l}]")
        end
    end

    def to_s
        ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do
            signal(square:false)
        end
    end

    def force_nege_index(bool=true)
        @nege_index = bool
    end

    def inst
        # if (@port != :origin)
        #     lname = "#{name}_id#{@id}"
        # else
        #     lname = @name.to_s
        # end
        lname = @name.to_s

        unless @ghost
            if dsize.eql?(1) && dimension.empty? 
                str = "#{@type} #{lname}#{@default ? " = #{align_signal(@default)};" : ";"}"
            else
                if (@dsize.is_a? Numeric) && @dsize < 0
                    str = "#{@type} [0:#{(-@dsize-1)}] #{lname}#{array_inst} #{@default ? " = #{align_signal(@default)};" : ";"}"
                elsif @nege_index
                    str = "#{@type} [0:#{@dsize}-1] #{lname}#{array_inst} #{@default ? " = #{align_signal(@default)};" : ";"}"
                else
                    str = "#{@type} [#{@dsize}-1:0]  #{lname}#{array_inst} #{@default ? " = #{align_signal(@default)};" : ";"}"
                end
            end
        else
            str = ""
        end
        str
    end

    def port_length
        if dsize.eql? 1
            n = ""
        else
            if @dsize.is_a? Numeric
                n = "[#{(@dsize.abs-1)}:0]"
            else
                n = "[#{(@dsize.to_s-1)}:0]"
            end
        end

        (@port.to_s + n +  " ").length
    end

    def inst_port

        if dsize.eql? 1
            n = " #{@type}"
        else
            n = " #{@type}[#{(@dsize-1)}:0]"
        end

        return [@port.to_s + n, @name.to_s,array_inst]
    end


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
    #     if dsize == 1
    #         n = " "
    #     else
    #         n = "[#{(@dsize-1)}:0] "
    #     end
    #
    #     if @port
    #         ("/*  #{@port.to_s}#{n}" + " "*sub_left_len + "*/ " + "."+@name.to_s + " "*sub_right_len)
    #     end
    # end

    # def self.inst
    #     port_str = GlobalParam.CurrTdlModule.BindEleClassVars.Logic.pre_inst.map { |e| e.call  }.join("\n")
    #     if self.respond_to? :lazy_def_exec
    #         GlobalParam.CurrTdlModule.BindEleClassVars.Logic.inst_stack.map{|e| e.call }.join("")+port_str+lazy_def_exec
    #     else
    #         GlobalParam.CurrTdlModule.BindEleClassVars.Logic.inst_stack.map{|e| e.call }.join("")+port_str
    #     end
    # end

    # def self.clear
    #     @@id = 1
    #     @@inst_stack = []
    #     @@ports = []
    #     @@nc = self.new
    #     BaseElm.recfg_nc(@@nc)
    # end

    def merge_from(*args)
        m = args.map do |e|
            align_signal(e)
        end
        # GlobalParam.CurrTdlModule.BindEleClassVars.Logic.inst_stack += "\nassign #{signal} = {#{m.join(',')}};\n"
        belong_to_module.Logic_draw << "\nassign #{signal} = {#{m.join(',')}};\n"
    end

    def destruct_to(*args)
        m = args.map do |e|
            align_signal(e)
        end
        # GlobalParam.CurrTdlModule.BindEleClassVars.Logic.inst_stack += "\nassign #{signal} = {#{m.join(',')}};\n"
        belong_to_module.Logic_draw << "\nassign {#{m.join(',')}} = #{signal};\n"
    end

    # def self.merge(*args)
    #     d = 0
    #     m = args.map do |e|
    #         d += e.dsize
    #         align_signal(e)
    #     end
    #     l0 = Logic.new(name:"merge",dsize:d)
    #     GlobalParam.CurrTdlModule.BindEleClassVars.Logic.inst_stack += "\nassign #{l0.signal} = {#{m.join(',')}};\n"
    #     return l0
    # end

    # NC = self.new
    # NC.instance_variable_set("@_id",0)
    #
    # def NC.signal
    #     id = NC.instance_variable_get("@_id")
    #     NC.instance_variable_set("@_id",id+1).to_s
    # end

    # def self.NC
    #     GlobalParam.CurrTdlModule.BindEleClassVars.Logic.nc
    # end
    #
    # def self.nc_create
    #     self.new
    # end

### parse text for autogen method and constant ###
Synth_REP = /\(\*\s+logic\s*=\s*"true"\s+\*\)/i

    def self.parse_ports(port_str)
        rh = super.parse_ports(port_str)
        rh[:type]   = Logic
        return rh
    end

end

# class Logic     #定义取反
#
#     define_method("!") do
#         "!#{signal}"
#     end
#
# end

class Logic
    OP_SYMBOLS = %w{+ - * / % > < >= <= << | &}


    OP_SYMBOLS.each do |symb|
        define_method(symb) do |a|
            return "#{self} #{symb} #{a}".to_nq
        end
    end

end

class DebugLogic < Logic
    def inst

        lname = @name.to_s

        unless @ghost
            if dsize.eql?(1)
                str = "(* MARK_DEBUG=\"true\" *)(* dont_touch=\"true\" *)#{@type} #{lname}#{@default ? " = #{align_signal(@default)};" : ";"}"
            else
                if (@dsize.is_a? Numeric) && @dsize < 0
                    str = "(* MARK_DEBUG=\"true\" *)(* dont_touch=\"true\" *)#{@type} [0:#{(-@dsize-1)}] #{lname}#{array_inst} #{@default ? " = #{align_signal(@default)};" : ";"}"
                else
                    str = "(* MARK_DEBUG=\"true\" *)(* dont_touch=\"true\" *)#{@type} [#{(@dsize-1)}:0]  #{lname}#{array_inst} #{@default ? " = #{align_signal(@default)};" : ";"}"
                end
            end
        else
            str = ""
        end
        str
    end
end
