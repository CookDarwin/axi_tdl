# require_relative "./tdlerror"
# require_relative "./clock"
# require_relative "./Reset"
# require_relative "./logic"
# require_relative "./basefunc"

class DataInf < InfElm
    extend BaseFunc
    include BaseModule
    attr_accessor :name,:dsize,:id,:ghost,:port
    def initialize(name:"data_inf",dsize:8,port:false,dimension:[])
        name_legal?(name)
        super()
        @port = port
        @dsize = dsize
        @name = name
        # @id = GlobalParam.CurrTdlModule.BindEleClassVars.DataInf.id

        # @correlation_proc = ""
        @_to_data_inf_c = ""
        # if @port
        #     GlobalParam.CurrTdlModule.BindEleClassVars.DataInf.ports << self
        # else
        #     GlobalParam.CurrTdlModule.BindEleClassVars.DataInf.inst_stack << method(:inst).to_proc
        # end
        @interconnect_up_streams = []
        @interconnect_idsize = 1
        # GlobalParam.CurrTdlModule.BindEleClassVars.DataInf.draw_stack << method(:draw).to_proc
    end

    # def signal
    #     if @port
    #         NqString.new(@name.to_s)
    #     else
    #         # "data_#{name}_#{@id}_inf"
    #         NqString.new("#{@name}_#{@id}_inf")
    #     end
    # end

    def inst
        return "" if @ghost
        "data_inf #(.DSIZE(#{dsize.abs}))  #{signal} ();"
    end

    # def port_length
    #     ("data_inf." + @port.to_s + " ").length
    # end

    def inst_port

        # if @port
        #     ("data_inf." + @port.to_s + " " + " "*sub_len + @name.to_s)
        # end
        return ["data_inf." + @port.to_s,@name.to_s,array_inst]
    end

    # def left_port_length
    #     ("/*  data_inf." + @port.to_s + " */ ").length
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
    #         ("/*  data_inf." + @port.to_s + " "*sub_left_len + "*/ " + "."+@name.to_s + " "*sub_right_len)
    #     end
    # end

    # def self.inst
    #     GlobalParam.CurrTdlModule.BindEleClassVars.DataInf.inst_stack.map { |e| e.call }.join("")
    # end
    #
    # def self.draw
    #     str = ""
    #     GlobalParam.CurrTdlModule.BindEleClassVars.DataInf.draw_stack.each do |e|
    #         str += e.call
    #     end
    #     return str
    # end


    def to_data_inf_c(clock:nil,reset:nil)
        new_obj = belong_to_module.Def.datainf_c(name:@name+"_c",clock:clock,reset:reset,dsize:@dsize)
        belong_to_module.DataInf_C_draw << to_data_inf_c_draw(up_stream:self,down_stream:new_obj)
        return new_obj
    end

    def to_data_inf_c_draw(up_stream:nil,down_stream:nil)
        large_name_len(up_stream,down_stream)
"data_inf_A2B data_inf_A2B_#{signal}_inst (
/*  data_inf.slaver   */  .slaver   (#{align_signal(up_stream)}),
/*  data_inf_c.master */  .master   (#{align_signal(down_stream)})
);"
    end

    def from_data_inf_c(clock:nil,reset:nil)
        new_obj = belong_to_module.Def.datainf_c(name:@name+"_c",clock:clock,reset:reset,dsize:@dsize)
        belong_to_module.DataInf_C_draw << from_data_inf_c_draw(up_stream:new_obj,down_stream:self)
        return new_obj
    end

    def from_data_inf_c_draw(up_stream:nil,down_stream:nil)
        large_name_len(up_stream,down_stream)
"data_inf_B2A data_inf_B2A_#{signal}_inst (
/*  data_inf_c.slaver */  .slaver   (#{align_signal(up_stream)}),
/*  data_inf.master   */  .master   (#{align_signal(down_stream)})
);"
    end

    # def self.clear
    #     @@pre_inst = []
    #     @@id = 1
    #     @@inst_stack = []
    #     @@ports = []
    #     # @@draw_stack = [NC.method(:draw).to_proc]
    #     @@draw_stack = []
    #     # NC.instance_variable_set("@correlation_proc","")
    #     @@nc = DataInf.new(name:"implicit",dsize:1)
    #     BaseElm.recfg_nc(@@nc)
    # end

    # NC = DataInf.new(name:"implicit",dsize:1)
    # NC.instance_variable_set("@_id",0)
    #
    # def NC.signal
    #     id = NC.instance_variable_get("@_id")
    #     NC.instance_variable_set("@_id",id+1).to_s
    # end

    # def self.NC
    #     GlobalParam.CurrTdlModule.BindEleClassVars.DataInf.nc
    # end
    #
    # def self.nc_create
    #      DataInf.new(name:"implicit",dsize:1)
    # end

    def self.master_empty(*ms)
        ms.each do |e|
            self.datainf_master_empty(master:e)
        end
    end

    def self.slaver_empty(*ss)
        ss.each do |e|
            self.datainf_slaver_empty(slaver:e)
        end
    end

    def copy(name:@name.to_s,dsize:"#{signal}.DSIZE")
        append_name = name_copy(name)
        belong_to_module.Def.datainf(name:append_name,dsize:dsize)
    end

    def branch(name:@name,dsize:@dsize)
        a =  copy(name:name,dsize:dsize)
        self << a
        return a
    end

### parse text for autogen method and constant ###

Synth_REP = Regexp.union(/\(\*\s+datainf\s*=\s*"true"\s+\*\)/, /\(\*\s+data_inf\s*=\s*"true"\s+\*\)/)

    def self.parse_ports(port_array=nil)
        rep = /(?<up_down>\(\*\s+(?<ud_name>data_up|data_down|up_stream|down_stream)\s*=\s*"true"\s+\*\))?\s*(data_inf\.)(?<modport>master|slaver|mirror)\s+(?<name>\w+)\s*(?<vector>\[.*?\])?/m
        up_stream_rep = /data_up/

        InfElm.parse_ports(port_array,rep,"data_inf",up_stream_rep) do |h|
            h[:type]   = DataInf
            yield h
        end
    end

end

class DataInf_C < CLKInfElm
    extend BaseFunc
    include BaseModule
    attr_accessor :name,:dsize,:id,:ghost,:port
    def initialize(name:"data_inf",dsize:8,clock:nil,reset:nil,port:false,dimension:[],freqM:nil)
        name_legal?(name)
        super(dimension:dimension,clock:clock,reset:reset,freqM:freqM)
        # unless port
        #     raise TdlError.new("\nRESET can not be nil\n") unless reset
        #     raise TdlError.new("\nCLOCK can not be nil\n") unless clock
        # end
        if clock && reset
            @clock = clock
            @reset = reset
        end
        @port = port
        @dsize = dsize
        @name = name
        @dimension = dimension
        # @id = GlobalParam.CurrTdlModule.BindEleClassVars.DataInf_C.id
        #
        # if @port
        #     GlobalParam.CurrTdlModule.BindEleClassVars.DataInf_C.ports << self
        # else
        #     GlobalParam.CurrTdlModule.BindEleClassVars.DataInf_C.inst_stack << method(:inst).to_proc
        # end
        # @correlation_proc = ""
        @_to_data_inf = ""
        # GlobalParam.CurrTdlModule.BindEleClassVars.DataInf_C.draw_stack    << method(:draw).to_proc
        @interconnect_up_streams = []
    end

    # def signal(index=nil)
    #     # "data_#{@id}_inf_c"
    #     square_str = super(index)
    #     if @port
    #         String.new(@name.to_s).concat square_str
    #     else
    #         String.new("#{@name}_#{@id}_inf").concat square_str
    #     end
    # end

    def []=(a,b)
        if a.is_a? ClassHDL::OpertorChain
            a.slaver = true
        end

        if b.is_a? ClassHDL::OpertorChain
            b.slaver = true
        end

        DataInf_C.data_c_direct(up_stream:b,down_stream:signal(a))
        return nil
    end

    def inst
        return "" if @ghost || @port
        with_new_align(0) do
            if @reset.is_a? SignalElm
                if @reset.active.casecmp("LOW") == 0
                    "data_inf_c #(.DSIZE(#{dsize}),.FreqM(#{intf_def_freqM}))  #{signal} #{array_inst}(.clock(#{align_signal(@clock,false)}),.rst_n(#{align_signal(@reset,false)}));"
                else
                    "data_inf_c #(.DSIZE(#{dsize}),.FreqM(#{intf_def_freqM}))  #{signal} #{array_inst}(.clock(#{align_signal(@clock,false)}),.rst_n(!#{align_signal(@reset,false)}));"
                end
            else
                "data_inf_c #(.DSIZE(#{dsize}),.FreqM(#{intf_def_freqM}))  #{signal} #{array_inst}(.clock(#{align_signal(@clock,false)}),.rst_n(#{align_signal(@reset,false)}));"
            end
        end
    end

    # def port_length
    #     ("data_inf_c." + @port.to_s + " ").length
    # end

    def inst_port

        # if @port
        #     ("data_inf_c." + @port.to_s + " " + " "*sub_len + @name.to_s + array_inst)
        # end

        return ["data_inf_c." + @port.to_s,@name.to_s,array_inst]
    end

    # def left_port_length
    #     ("/*  data_inf_c." + @port.to_s + " */ ").length
    # end
    #
    # def right_port_length
    #     (".#{@name.to_s}#{array_inst} ").length
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
    #         ("/*  data_inf_c." + @port.to_s + " "*sub_left_len + "*/ " + "."+@name.to_s + array_inst + " "*sub_right_len)
    #     end
    # end

    def draw
        super
        return ''   if @_to_data_inf.empty? && @correlation_proc.empty? && @interconnect_up_streams.empty?


        unless @interconnect_up_streams.empty?
            @correlation_proc += interconnect_draw(prio:"WAIT_IDLE")
        end

        # return head_str+@_to_data_inf+@correlation_proc+end_str
        if @name == "implicit"
            tag = "DATA_INF_C NC"
        else
            tag = signal
        end
        page(tag:tag,body:@_to_data_inf+@correlation_proc)
    end

    # def self.inst
    #
    #     port_str = GlobalParam.CurrTdlModule.BindEleClassVars.DataInf_C.pre_inst.map { |e| e.call  }.join("\n")
    #     # puts @@inst_stack[0].call
    #     # puts port_str
    #     GlobalParam.CurrTdlModule.BindEleClassVars.DataInf_C.inst_stack.map { |e| e.call }.join("")+page(tag:"DATA_INF_C POST",body:port_str)
    # end
    #
    # def self.draw
    #     str = ""
    #     GlobalParam.CurrTdlModule.BindEleClassVars.DataInf_C.draw_stack.each do |e|
    #         str += e.call
    #     end
    #     return str
    # end

    def to_data_inf()
        new_obj = belong_to_module.Def.datainf(name:@name+"_nc",dsize:@dsize)
        belong_to_module.DataInf_C_draw << to_data_inf_draw(up_stream:self,down_stream:new_obj)
        return new_obj
    end

    def to_data_inf_draw(up_stream:nil,down_stream:nil)
        large_name_len(up_stream,down_stream)
"data_inf_B2A data_inf_B2A_#{signal}_inst (
/*  data_inf_c.slaver */  .slaver   (#{align_signal(up_stream)}),
/*  data_inf.master   */  .master   (#{align_signal(down_stream)})
);"
    end

    def from_data_inf()
        new_obj = belong_to_module.Def.datainf(name:@name+"_nc",dsize:@dsize)
        belong_to_module.DataInf_C_draw << from_data_inf_draw(up_stream:new_obj,down_stream:self)
        return new_obj
    end

    def from_data_inf_draw(up_stream:nil,down_stream:nil)
        large_name_len(up_stream,down_stream)
"data_inf_A2B data_inf_A2B_#{signal}_inst (
/*  data_inf.slaver   */  .slaver   (#{align_signal(up_stream)}),
/*  data_inf_c.master */  .master   (#{align_signal(down_stream)})
);"
    end

    # def self.clear
    #     @@pre_inst = []
    #     @@id = 1
    #     @@inst_stack = []
    #     @@ports = []
    #     # @@draw_stack = [NC.method(:draw).to_proc]
    #     @@draw_stack = []
    #     # NC.instance_variable_set("@correlation_proc","")
    #     @@nc = DataInf_C.new(name:"implicit",clock:Clock.NC,reset:Reset.NC,dsize:1)
    #     BaseElm.recfg_nc(@@nc)
    # end

    # NC = DataInf_C.new(name:"implicit",clock:Clock.NC,reset:Reset.NC,dsize:1)
    # NC.instance_variable_set("@_id",0)
    #
    # def NC.signal
    #     id = NC.instance_variable_get("@_id")
    #     NC.instance_variable_set("@_id",id+1).to_s
    # end

    # def self.NC
    #     GlobalParam.CurrTdlModule.BindEleClassVars.DataInf_C.nc
    # end
    #
    # def self.nc_create
    #     DataInf_C.new(name:"implicit",clock:Clock.NC,reset:Reset.NC,dsize:1)
    # end

    def self.master_empty(*ms)
        ms.each do |e|
            self.datainf_c_master_empty(master:e)
        end
    end

    def self.slaver_empty(*ss)
        ss.each do |e|
            self.datainf_c_slaver_empty(slaver:e)
        end
    end


    # def copy(name:@name,clock:ref_signal(:clock),reset:ref_signal(:reset),dsize:ref_signal(:dsize),dimension:@dimension,freqM:nil)
    #     append_name = name_copy(name)
    #     _freqM = use_which_freq_when_copy(clock,freqM)
    #     belong_to_module.Def.datainf_c(name:append_name,clock:clock,reset:reset,dsize:dsize,dimension:dimension,freqM:_freqM)
    # end

    def copy(name:@name.to_s,clock: @clock,reset: @reset,dsize: @dsize,dimension:@dimension,freqM:nil)
        append_name = name_copy(name)
        _freqM = use_which_freq_when_copy(clock,freqM)
        belong_to_module.Def.datainf_c(name:append_name,clock:clock,reset:reset,dsize:dsize,dimension:dimension,freqM:_freqM)
    end

    def branch(name:@name,clock:@clock,reset:@reset,dsize:@dsize,freqM:nil)
        a =  copy(name:name,clock:clock,reset:reset,dsize:dsize,freqM:freqM)
        self << a
        return a
    end

    def clock_reset_taps(def_clock_name,def_reset_name)

        # new_clk = belong_to_module.logic.clock(self.FreqM) - def_clock_name
        # new_reset = belong_to_module.logic.reset('low') - def_reset_name

        # belong_to_module.Assign do 
        #     new_clk <= self.clock 
        #     new_reset <= self.rst_n 
        # end 
        # [new_clk,new_reset]
        super(def_clock_name,def_reset_name,self.clock,self.rst_n)
    end


    def inherited(name:@name.to_s,clock: nil,reset: nil,dsize: nil,freqM: nil,dimension:[])
        a = nil 
        ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
            append_name = name_copy(name)
            _freqM = use_which_freq_when_copy(clock,freqM)
            a = belong_to_module.Def.datainf_c(
                name:append_name,
                clock: clock || self.clock,
                reset: reset || self.rst_n,
                dsize: dsize || self.DSIZE,
                freqM: _freqM,
                dimension: dimension)
        end
        a
    end

    private
        def ref_signal(m)
            if @dimension.empty?
                case m
                when :clock
                    "#{signal}.clock"
                when :reset
                    "#{signal}.rst_n"
                when :dsize
                    "#{signal}.DSIZE"
                else
                    ""
                end
            else
                method(m).call
            end
        end
    public
### parse text for autogen method and constant ###

Synth_REP = Regexp.union(/\(\*\s+datainf_c\s*=\s*"true"\s+\*\)/, /\(\*\s+data_inf_c\s*=\s*"true"\s+\*\)/)

    def self.parse_ports(port_array=nil)
        rep = /(?<up_down>\(\*\s+(?<ud_name>data_up|data_down|up_stream|down_stream)\s*=\s*"true"\s+\*\))?\s*(data_inf_c\.)(?<modport>master|slaver|mirror|out_mirror)\s+(?<name>\w+)\s*(?<vector>\[.*?\])?/m
        up_stream_rep = /data_up/

        rh = InfElm.parse_ports(port_array,rep,"data_inf_c",up_stream_rep) do |h|
            h[:type]   = DataInf_C
            yield h
        end
    end

end


class DataInf_C # add |

    # def copy()

    def |(a)
        raise TdlError.new(" PIPE STREAM is not a DataInf_C or DataInf") if( !(a.is_a? DataInf_C) || !(a.is_a? DataInf))
        if a.is_a? DataInf
            b = a.to_data_inf_c
        else
            b = a
        end
        data_connect_pipe_inf(up_stream:b)
    end

    def &(*a)
        return nil if a.empty?
        @_bind_up_streams = []
        a.each do |e|
            raise TdlError.new(" PIPE STREAM is not a DataInf_C or DataInf") if( !(e.is_a? DataInf_C) || !(e.is_a? DataInf))
            if e.is_a? DataInf
                b = e.to_data_inf_c
            else
                b = e
            end
            @_bind_up_streams  << b
        end
        @_bind_down_stream =    @_bind_up_streams[0].copy()
        # GlobalParam.CurrTdlModule.BindEleClassVars.DataInf_C.pre_inst = lambda {_sub_band_inst() + _sub_bind_direct() + _bind_interconnect_draw() }
        belong_to_module.DataInf_C_inst << (_sub_band_inst() + _sub_bind_direct() + _bind_interconnect_draw())
        return @_bind_down_stream
    end

    private

    def _sub_band_inst
        "data_inf_c #(.DSIZE(#{dsize}))  bind_#{signal} [#{@_bind_down_stream.length-1}:0](#{align_signal(clock)},#{align_signal(reset)});\n"
    end


    def _sub_bind_direct
        str = ""
        @_bind_up_streams.each_index do |index|
            str +=
"
data_valve bind_#{signal}_inst#{index}(
/*  input              */       .button     (1'b1),          //[1] OPEN ; [0] CLOSE
/*  data_inf_c.slaver  */       .data_in    (#{align_signal(@_bind_up_streams[index])}),
/*  data_inf_c.master  */       .data_out   (#{align_signal("bind_#{signal}",false)}[#{index}])
);
"
        end
        return str
    end

    def _bind_interconnect_draw
"
data_bind #(
    .NUM        (#{@_bind_up_streams.length})
)data_bind_#{signal}_inst(
/*  data_inf_c.slaver  */   .data_in     (#{align_signal("bind_#{signal}",false)})//[NUM-1:0],
/*  data_inf_c.master  */   .data_out    (#{align_signal(@_bind_down_stream)})//[data_NUM]...[data_0]
);
"
    end

end

class DataInf_C
    # @@pre_inst << lambda {
    #     alias_method :direct,:data_c_direct
    #     return ""
    # }

    def direct(slaver:"slaver",master:"master",up_stream:nil,down_stream:nil)
        data_c_direct(slaver:slaver,master:master,up_stream:up_stream,down_stream:up_stream)
    end

    def self.direct(slaver:"slaver",master:"master",up_stream:nil,down_stream:nil)
        self.data_c_direct(slaver:slaver,master:master,up_stream:up_stream,down_stream:up_stream)
    end
end

class DataInf_C ## signals in interface

    define_arraychain_tail_method('valid')
    define_arraychain_tail_method('ready',width=1,rv=true)
    define_arraychain_tail_method('vld_rdy')

    # def ready
    #     raise TdlError.new("\nARRAY Don't have 'ready'") unless @dimension.empty?
    #     NqString.new(signal.concat ".ready")
    # end

    # def vld_rdy
    #     raise TdlError.new("\nARRAY Don't have 'vld_rdy'") unless @dimension.empty?
    #     NqString.new(signal.concat ".vld_rdy")
    # end

    # def data(h=nil,l=nil)
    #     raise TdlError.new("\nARRAY Don't have 'data'") unless @dimension.empty?

    #     if h.is_a? Range
    #         h = h.to_a.max
    #         l = h.to_a.min
    #     end

    #     if h
    #         if l
    #             sqr = "[#{h.to_s}:#{l.to_s}]"
    #         else
    #             sqr = "[#{h.to_s}]"
    #         end
    #     else
    #         sqr = ""
    #     end
    #     NqString.new(signal.concat ".data").concat sqr
    # end

    define_arraychain_tail_method('data',width=lambda{|inf| inf.DSIZE(0) })

end

class DataInf_C

    def DSIZE(index=nil)
        if dimension.empty? && !port
            @dsize
        else
            unless index
                "#{signal(index)}.DSIZE".to_nq
            else 
                dimension_size = dimension.size 
                zstr = ''
                ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
                    zstr = "[0]"*dimension_size
                end
                "#{signal}#{zstr}.DSIZE".to_nq
            end
        end
    end

    def rst_n(index=nil)
        if dimension.empty? && !port
            @reset
        else
            "#{signal(index)}.rst_n".to_nq
        end
    end

    def clock(index=nil)
        if dimension.empty? && !port
            @clock
        else
            "#{signal(index)}.clock".to_nq
        end
    end

end
