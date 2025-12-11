module TdlSpace

    class ArrayChainSignalMethod
        attr_reader :name
        def initialize(symb)
            @name = symb
        end
    end

    class ArrayChain
        attr_reader :obj,:chain,:end_slice,:belong_to_module
        def initialize(obj="tmp",lchain=[],end_slice=false,belong_to_module=nil)
            @belong_to_module=belong_to_module
            @obj = obj
            if !end_slice
                if lchain.is_a? Array
                    @chain = lchain
                    @end_slice = end_slice
                else 
                    @chain = [lchain]
                    @end_slice = end_slice
                end
            elsif lchain 
                @chain = []
                @end_slice = [lchain,end_slice]
            else
                raise TdlError.new("数组下标类型出错")
            end

            unless @belong_to_module
                raise TdlError.new "ArrayChain<#{obj.to_s}> 必须添加 belong_to_module"
            end
        end

        def self.create(obj: "tmp",lchain: [],end_slice: false,belong_to_module: nil)
            ArrayChain.new(obj, lchain, end_slice, belong_to_module)
        end

        def root_ref(&block)
            "#{belong_to_module.root_ref(&block)}.#{to_s}".to_nq
        end

        def inspect
            self.to_s
        end

        def signal
            self.to_s.to_nq
        end

        def method_missing(method,arg=nil)
            if arg 
                raise TdlError.new("ArrayChain 末尾调用方法[#{method}]不能带参数")
            end

            if @end_slice
                raise TdlError.new("ArrayChain 末尾slice不能再调用方法 #{method} #{arg.to_s}")
            end
            ## 判断 obj是否响应方法
            if @obj.respond_to?(method) && !method.to_s.eql?("inst_name")
                ArrayChain.create(obj: @obj,lchain:@chain.dup.concat([ArrayChainSignalMethod.new(method)]) ,belong_to_module: belong_to_module)
            else 
            
                # raise TdlError.new("ArrayChain 没有末尾方法 #{method} #{arg}")
                super
            end
        end

    end
end

module AxiTdl
    class SdlModuleActiveBaseElm
    end
end


class BaseElm < AxiTdl::SdlModuleActiveBaseElm
    # attr_accessor :belong_module
    attr_accessor :belong_to_module
    attr_accessor :name
    # def initialize
    #     @belong_module =

    def s(index=nil)
        signal
    end

    def signal(index=nil)
        RedefOpertor.with_normal_operators do
            with_new_align(0) do
                unless index
                    NqString.new(@name.to_s)
                else
                    unless index.is_a? String
                        NqString.new("#{@name.to_s}[#{align_signal(index)}]")
                    else
                        NqString.new("#{@name.to_s}[#{index.strip}]")
                    end
                end
            end
        end
    end

    def matrix(*indexs)
        with_new_align(0) do
            str = indexs.map do |i|
                "[#{align_signal(i,q_mark=false)}]"
            end.join("")
            NqString.new("#{@name.to_s}#{str}")
        end
    end

    # def signal
    #     @name.to_s
    # end

    def self.recfg_nc(new_nc)
        new_nc.instance_variable_set("@_id",0)
        new_nc.define_singleton_method(:signal) do
            id = new_nc.instance_variable_get("@_id")
            new_nc.instance_variable_set("@_id",id+1).to_s
        end
    end

    def name_copy(nstr)
        if nstr.is_a?(StringBandItegration) && true
            return nstr
        else
            if nstr.to_s.eql?(@name.to_s)
                @copy_id ||= 0
                str = "#{nstr.to_s}_copy_#{@copy_id}"
                @copy_id += 1
                str
            else
                nstr.to_s
            end
        end
    end

    private
        # def array_inst(msb_high:true)
        def array_inst
            return "" if @dimension.empty?

            m = @dimension.map do |e|
                if e.respond_to? signal
                    "[#{e.signal}-1:0]"
                elsif (e.is_a? Numeric) && e < 0
                    "[0:#{-e}-1]"
                else
                    "[#{e}-1:0]"
                end
            end
            return m.join("")
        end

        def name_legal?(name)
            if (name.to_s !~ /^[a-zA-Z]/ || name.to_s !~ /([a-zA-Z0-9]|_)+/)
                # puts "===#{name.to_s}==="
                # puts name.to_s !~ /^[a-zA-Z]/
                # puts name.to_s !~ /([a-zA-Z0-9]|_)+/
                raise TdlError.new(" Name << #{name.to_s[0,31]} class[#{name.class}]>> Illegal")
            end
        end

        ## ArrayChain 相关
        def self.define_arraychain_tail_method(name,width=1,rv=false,&block)
            self.define_method(name) do 
                RedefOpertor.with_normal_operators do 
                    if @dimension.empty?
                        NqString.new(signal.concat ".#{name}") 
                    else 
                        @_array_chain_hash_ ||= {}
                        unless @_array_chain_hash_[name.to_s]
                            if width.is_a? Proc 
                                r_width = width.call(self)
                            else 
                                r_width = width
                            end
                            rel = generate_inf_to_signals(name.to_s,width=r_width,rv=rv)
                            
                            @_array_chain_hash_[name.to_s] = rel
                        end
                        TdlSpace::ArrayChain.create(obj: @_array_chain_hash_[name.to_s],lchain:[],belong_to_module: self.belong_to_module)
                    end
                end
            end
        end
end

class SignalElm < BaseElm

    @@child = []

    def self.inherited(subclass)
        unless @@child.include? subclass
            @@child << subclass
        end
    end

    def self.subclass
        @@child
    end

### parse text for autogen method and constant ###
    def self.parse_ports(port_str)
        normal_ports = []
        del_ports = []
        if port_str
            normal_ports = port_str.map do |e|
                me = e.match(/(?<in_out>input|output|inout)\s*(logic|wire|reg|bit)?\s*(?<vector>\[.*?\])?\s+(?<name>\w+)\s*(?<array>\[.*?\])?/)
                # me = e.match(/(?<in_out>input|output|inout)\s*(logic|wire)?\s*(?<vector>\[.*?\])?\s*(?<name>\w+)/)
                if me
                    del_ports << e
                    h = Hash.new
                    h[:type] = Logic
                    h[:name]    = me["name"].downcase
                    h[:origin_name] = me["name"]
                    h[:in_out]  = me["in_out"]
                    if me["vector"]
                        h[:vector]  = me["vector"]
                    end
                    if me["array"]
                        h[:array] = me["array"]
                    end

                    h[:port_left_len] = 4+6+1+(h[:vector] ? h[:vector].length : 0) +6
                    h[:port_right_len]= 4+h[:origin_name].length

                    h[:inst_ex_port] = lambda { |ml,mr|
                        if ml  >= h[:port_left_len]
                            ll = ml - h[:port_left_len]
                        else
                            ll = 1
                        end

                        if mr  >= h[:port_right_len]
                            rl = mr - h[:port_right_len]
                        else
                            rl = 1
                        end
                        "/*  #{(h[:in_out]=="output") ? h[:in_out] : h[:in_out]+" "} #{h[:vector]}" +" "*(ll) + "*/ " + ".#{h[:origin_name]}"+" "*(rl)+" (\#{align_signal(#{h[:name]},q_mark=false)})"
                    }

                    yield h

                    h
                else
                    nil
                end
            end
        end
        return_port_str = port_str - del_ports
        return return_port_str
    end

    def [](a,b=nil)
        if a.is_a? ClassHDL::OpertorChain
            a.slaver = true
        end

        if b.is_a? ClassHDL::OpertorChain
            b.slaver = true
        end

        # b = a unless b
        if a== :all
            square = ""
        elsif b
            square = "[#{a}:#{b}]"
        else
            square = "[#{a}]"
        end

        NqString.new("#{name}#{square}")
    end

    def inst
        unless @ghost
            # "logic  #{signal};"
            if dsize.eql?(1)
                "logic  #{signal};"
            else
                if (@dsize.is_a? Numeric) && @dsize < 0
                    str = "logic [0:#{(-@dsize-1)}] #{signal};"
                else
                    str = "logic [#{(@dsize-1)}:0]  #{signal};"
                end
            end
        else
            ""
        end
    end

# array_single_ops = %W{! ~}


    define_method("!") do # 定义取反
        NqString.new("!#{signal}")
    end

    define_method("~") do # 定义取反
        NqString.new("~#{signal}")
    end

end

class InfElm < BaseElm

    @@child = []

    def self.inherited(subclass)
        unless @@child.include? subclass
            @@child << subclass if subclass != CLKInfElm
        end
    end

    def self.subclass
        @@child
    end

    def port_length()
        ("#{@inf_name}." + @port.to_s + " ").length
    end

    def inst_port

        return ["#{@inf_name}." + @port.to_s, @name.to_s,array_inst]

    end

    # def left_port_length()
    #     ("/*  #{@inf_name}." + @port.to_s + " */ ").length
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
    #         ("/*  #{@inf_name}." + @port.to_s + " "*sub_left_len + "*/ " + "."+@name.to_s + " "*sub_right_len)
    #     end
    # end

    def self.parse_ports(port_array=nil,rep,inf_name,up_stream_rep)
        ports = []
        del_ports = []
        if port_array
            ports = port_array.map do |e|
                me = e.match(rep)
                if me
                    del_ports << e
                    h = Hash.new
                    h[:type] = AxiLite
                    h[:modport] = me["modport"].downcase

                    if h[:modport]=="master"
                        h[:way] = :to_down
                    elsif  h[:modport]=="slaver"
                        h[:way] = :from_up
                    else
                        h[:way] = :mirror
                    end

                    h[:name]    = me["name"].downcase
                    h[:origin_name] = me["name"]
                    h[:vector]  = me["vector"] if me["vector"]
                    if me["ud_name"]
                        h[:up_down] = me["ud_name"] =~ up_stream_rep ? "up_stream" : "down_stream"
                    else
                        h[:up_down] = "nil"
                    end

                    ##
                    port_left_len  = 4+"#{inf_name}.#{h[:modport]}".length+6
                    port_right_len = 4+h[:origin_name].length

                    h[:port_left_len] = port_left_len
                    h[:port_right_len] = port_right_len

                    h[:inst_ex_port] = lambda {|left,right|
                        if left >= port_left_len
                            ll  = left - port_left_len
                        else
                            ll = 1
                        end

                        if right >= port_right_len
                            rl  = right - port_right_len
                        else
                            rl = 1
                        end

                        "/*  #{inf_name}.#{h[:modport]}" + " "*ll+ "*/ " + ".#{h[:origin_name]}"+" "*rl + " (\#{align_signal(#{h[:name]},q_mark=false)})"
                    }

                    yield h
                    ##
                    h
                else
                    nil
                end
            end
        end
        # puts port_array,"=====",del_ports
        return_ports = port_array - del_ports
        return  return_ports
    end

end

class InfElm
    attr_accessor :dimension

    def initialize(dimension:[])
        @instance_draw_stack = []
        @correlation_proc = ""
        @dimension = dimension
    end

    def draw
        @instance_draw_stack.each do |each_inst|
            if each_inst.is_a? Proc
                @correlation_proc += each_inst.call
            elsif each_inst.is_a? String
                @correlation_proc += each_inst
            end
        end
    end


    def [](a,b=false)
        if a.is_a? ClassHDL::OpertorChain
            a.slaver = true
        end

        if b.is_a? ClassHDL::OpertorChain
            b.slaver = true
        end

        return signal if @dimension.empty?
        
        TdlSpace::ArrayChain.create(obj: self,lchain: a, end_slice: b, belong_to_module: belong_to_module)
    end

    def self.same_name_socket(way,mix,inf_array,base_new_inf=nil,belong_to_module=nil)
        # return inf_array unless inf_array.is_a? Array
        unless inf_array.is_a? Array
            return inf_array if inf_array.respond_to?(:dimension) && inf_array.dimension.any?
            inf_array = [inf_array]
        end
        return nil if inf_array.empty?
        return inf_array[0] if (inf_array.length == 1 && mix.eql?(true))


        unless base_new_inf
            unless inf_array[0].is_a? String
                new_inf = inf_array[0].copy()
            else
                new_inf = self.string_copy_inf(inf_array[0],belong_to_module)
            end
        else
            new_inf = base_new_inf
        end

        unless mix
            # new_inf = DataInf_C.new(copy_inf:data_c_array[0],dimension:[data_c_array.length])
            new_inf.dimension = [inf_array.length]
            inf_array.each_index do |index|
                # DataInf_C.data_c_direct(slaver:data_c_array[index],master:new_data_c.signal(index))
                if way == :to_down
                    inf_array[index].direct(slaver:new_inf.signal(index))
                elsif way == :from_up
                    self.direct(master:new_inf.signal(index),slaver:inf_array[index],belong_to_module:belong_to_module)
                elsif way == :mirror
                    self.data_c_direct_mirror(master:new_inf.signal(index),slaver:inf_array[index],belong_to_module:belong_to_module)
                else
                    raise TdlError.new("\nASSIGN Array to port that dont support SAME_NAME_SOCKET\n")
                end
                # puts new_inf.signal(index),inf_array[index].signal
            end
        else
            new_inf.<<(*inf_array)
        end
        # puts new_data_c.signal
        return new_inf
    end

    def signal(index=nil)       #array interface
        # large_name_len("")
        RedefOpertor.with_normal_operators do
            with_new_align(0) do
                if @dimension.any? && index
                    # puts "#{index}"
                    # puts index.is_a? String
                    if index.is_a? String
                        sq = "[#{index}]"
                        NqString.new("#{@name}#{sq}")
                        # NqString.new("#{@name}")
                    else
                        NqString.new("#{@name}[#{align_signal(index)}]")
                    end
                else
                    NqString.new("#{@name}")
                end
            end
        end
    end

    def dimension_num(e)
        if e.is_a? Array
            return e.size
        else
            if e.respond_to?(:dimension) && e.dimension.any?
                return e.dimension.last
            else
                return 1
            end
        end
    end

    ## Array Chain
    private
    def generate_inf_to_signals(name,width=1,rv=false)
        rel = belong_to_module.Def().logic(name: "#{signal}_#{name}",dsize: width,dimension: dimension)
        belong_to_module.DataInf_C_inst << "generate\n"+generate_chains(name,rv=rv)+"\nendgenerate\n"
        return rel
    end

    def generate_chains(name,rv=false)
        str = []
        index = 0
        dimension.each do |e|
            str << "#{'    '*index}for(genvar KK#{index}=0;KK#{index}<#{e};KK#{index}++)begin"
            index += 1
        end
        ti = (0...dimension.length).to_a.map{|e| "[KK#{e}]"}.join('')
        unless rv
            str << "#{'    '*index}assign #{signal}_#{name}#{ti} = #{signal}#{ti}.#{name};"
        else 
            str << "#{'    '*index}assign #{signal}#{ti}.#{name} = #{signal}_#{name}#{ti};"
        end
        dimension.each do |e|
            index -= 1
            str << "#{'    '*index}end"
        end
        return str.join("\n")
    end

end

# class InfElm
#     private
#
#     # def add_dsize_func
#     #     _dsize = @dsize
#     #     @dsize.define_singleton_method("*") do |a|
#     #         if(_dsize.is_a? Numeric)
#     #             @dsize * a
#     #         elsif _dsize.is_a? String
#     #             "#{_dsize} * #{a}"
#     #         else
#     #             @dsize * a
#     #         end
#     #     end
#     # end
# end

class CLKInfElm < InfElm
    attr_accessor :clock,:reset,:origin_freqM
    def initialize(clock:nil,reset:nil,dimension:[],freqM:nil)
        # super(dimension:dimension,clock:clock,reset:reset,freqM:freqM)
        super(dimension:dimension)
        @clock = clock
        @reset = reset
        @origin_freqM = freqM
        check_freqM

    end

    def freqM
        if @clock.is_a?(Clock)
            @clock.freqM
        elsif @origin_freqM
            @origin_freqM
        else
            nil
        end
    end

    def intf_def_freqM
        if @clock.is_a?(Clock)
            @clock.freqM
        elsif @origin_freqM
            @origin_freqM
        else
            1.11
        end
    end

    def freq_align_signal
        data = freqM
        if data
            align_signal(data)
        else
            align_signal( 1.11 )
        end
    end

    def FreqM()
        "#{@name}.FreqM".to_nq
    end

    def check_freqM
        if @origin_freqM && @clock.is_a?(Clock)
            if @origin_freqM != @clock.freqM
                raise TdlError.new("Interface origin clock freqM[#{@origin_freqM}Mhz] dont eql CLOCK freqM[#{@clock.freqM}Mhz]")
            end
        end
    end

    def use_which_freq_when_copy(argv_clock,argv_origin)
        if argv_clock == @clock && @clock
            @origin_freqM
        elsif argv_clock != @clock && argv_clock.is_a?(Clock)
            argv_clock.freqM
        elsif !(argv_clock.is_a?(Clock)) && argv_origin
            argv_origin
        else
            nil
        end
    end
end

## clock_reset_taps
class CLKInfElm

    def clock_reset_taps(def_clock_name,def_reset_name,self_clock,self_reset)

        new_clk = belong_to_module.logic.clock(self.FreqM) - def_clock_name
        new_reset = belong_to_module.logic.reset('low') - def_reset_name

        belong_to_module.Assign do 
            new_clk <= self_clock 
            new_reset <= self_reset
        end 
        [new_clk,new_reset]
    end
end

