# require_relative "./tdlerror"
# require_relative "./clock"
# require_relative "./Reset"
# require_relative "./logic"
# require_relative "./basefunc"
# require_relative "./axi_stream"
# require_relative "./axi4/axi4_lib"

require "cmath"

class Axi4 < CLKInfElm
    extend BaseFunc
    include BaseModule
    BOTH = "BOTH"
    ONLY_READ  = "ONLY_READ"
    ONLY_WRITE = "ONLY_WRITE"

    attr_accessor :id,:name,:dsize,:idsize,:asize,:lsize,:mode,:addr_step,:port,:ghost

    # def initialize(name:"axi4",clock:nil,reset:nil,dsize:8,idsize:1,asize:8,max_len:256,mode:BOTH,port:false)
    def initialize(name:"axi4",clock:nil,reset:nil,dsize:8,idsize:1,asize:8,lsize:8,mode:BOTH,port:false,addr_step:1.0,dimension:[],freqM:nil)
        name_legal?(name)
        super(dimension:dimension,clock:clock,reset:reset,freqM:freqM)
        @name = name
        # raise TdlError.new "\nRESET CAN'T BE NIL\n" if reset.nil?
        @dsize = dsize
        @idsize = idsize
        @asize = asize
        # @lsize = CMath.log2(max_len).to_i + ( (max_len > 2**(CMath.log2(max_len).to_i))? 1:0)
        # @max_len= max_len
        @lsize = lsize
        @mode = mode
        @port = port
        @addr_step = addr_step
        @dimension = dimension
        # @id = GlobalParam.CurrTdlModule.BindEleClassVars.Axi4.id
        # @correlation_proc = ""
        # if @port
        #     GlobalParam.CurrTdlModule.BindEleClassVars.Axi4.ports << self
        # else
        #     GlobalParam.CurrTdlModule.BindEleClassVars.Axi4.inst_stack << method(:inst).to_proc
        # end
        # GlobalParam.CurrTdlModule.BindEleClassVars.Axi4.pre_inst_stack << method(:inter_pre_inst_stack).to_proc
        # GlobalParam.CurrTdlModule.BindEleClassVars.Axi4.draw_stack << method(:draw).to_proc
    end

    # def signal
    #     if @port
    #         NqString.new(@name.to_s)
    #     else
    #         NqString.new("axi_#{@name}_#{@id}_inf")
    #     end
    # end

    def inst
        return "" if @ghost
        raise TdlError.new "\n #{@name} DSIZE CAN'T BE NIL\n" if @dsize.nil?
        raise TdlError.new "\n #{@name} CLOCK CAN'T BE NIL\n" if @clock.nil?
        raise TdlError.new "\n #{@name} RESET CAN'T BE NIL\n" if @reset.nil?
        raise TdlError.new "\n #{@name} ASIZE CAN'T BE NIL\n" if @asize.nil?
        raise TdlError.new "\n #{@name} IDSIZE CAN'T BE NIL\n" if @idsize.nil?
        raise TdlError.new "\n #{@name} LSIZE CAN'T BE NIL\n" if @lsize.nil?

        large_name_len(@mode,@clock,@reset,addr_step,@mode)
"\naxi_inf #(
    .IDSIZE    (#{align_signal(idsize)}),
    .ASIZE     (#{align_signal(asize)}),
    .LSIZE     (#{align_signal(lsize)}),
    .DSIZE     (#{align_signal(dsize)}),
    .MODE      (#{align_signal(@mode)}),
    .ADDR_STEP (#{align_signal(addr_step,false)}),
    .FreqM     (#{freq_align_signal})
)#{signal} #{array_inst}(
    .axi_aclk      (#{align_signal(@clock,false)}),
    .axi_aresetn   (#{align_signal(@reset.low_signal,false)})
);\n"
    end

    # def port_length
    #     ("axi_inf." + @port.to_s + " ").length
    # end

    def inst_port


        # if @port
        #     ("axi_inf." + @port.to_s + " " + " "*sub_len + @name.to_s)
        # end

        return ["axi_inf." + @port.to_s,@name.to_s,array_inst]
    end

    # def left_port_length
    #     ("/*  axi_inf." + @port.to_s + " */ ").length
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
    #         ("/*  axi_inf." + @port.to_s + " "*sub_left_len + "*/ " + "."+@name.to_s + " "*sub_right_len)
    #     end
    # end

    # def inter_pre_inst_stack
    #     return if @interconnect_up_streams.empty?
    #     cal_idsize_asize
    #     cal_addr_step
    #     long_slim_to_wide
    #     num = combin_wr_rd_slaver_and_sub_list
    #     @sub_num = num
    #     @correlation_proc += interconnect_draw
    # end

    # def self.inst
    #     GlobalParam.CurrTdlModule.BindEleClassVars.Axi4.pre_inst_stack.map { |e| e.call }
    #     GlobalParam.CurrTdlModule.BindEleClassVars.Axi4.inst_stack.map { |e| e.call }.join("")
    # end
    #
    # def self.draw
    #     # @@module_stack.each{ |e| e.call }
    #     str = ""
    #     GlobalParam.CurrTdlModule.BindEleClassVars.Axi4.draw_stack.each do |e|
    #         str += e.call
    #     end
    #     return str
    # end

    # def draw
    #     super
    #     return ''   if @interconnect_up_streams.empty? && @correlation_proc.empty?
    #     head_str = "\n//-------->>>> #{signal} <<<<----------------\n"
    #     end_str  = "\n//========<<<< #{signal} >>>>================\n"
    #     # unless @interconnect_up_streams.empty?
    #     #     @correlation_proc += interconnect_draw
    #     # end
    #     return head_str+@correlation_proc+end_str
    # end
    #### mode trans ============================================================
    def to_both
        if mode == BOTH
            return self
        end
        # new_obj = Axi4.new(name:@name+"_both",clock:@clock,reset:@reset,mode:Axi4::BOTH,dsize:@dsize,idsize:@idsize,asize:@asize,max_len:@max_len)
        new_obj = belong_to_module.Def.axi4(name:@name+"_both",clock:@clock,reset:@reset,mode:Axi4::BOTH,dsize:@dsize,idsize:@idsize,asize:@asize,lsize:@lsize,addr_step:@addr_step,freqM:@origin_freqM)

        new_obj.axi4_direct(up_stream:self)
        return new_obj
    end

    def to_only_read
        if mode == ONLY_READ
            return self
        elsif mode == ONLY_WRITE
            raise TdlError.new("AXI4 can be ONLY_WRITE to ONLY_READ\n")
        end

        # new_obj = Axi4.new(name:@name+"_only_read",clock:@clock,reset:@reset,mode:Axi4::ONLY_READ,dsize:@dsize,idsize:@idsize,asize:@asize,max_len:@max_len)
        new_obj = belong_to_module.Def.axi4(name:@name+"_only_read",clock:@clock,reset:@reset,mode:Axi4::ONLY_READ,dsize:@dsize,idsize:@idsize,asize:@asize,lsize:@lsize,addr_step:@addr_step,freqM:@origin_freqM)
        new_obj.axi4_direct(up_stream:self)
        return new_obj
    end

    def to_only_write
        if mode == ONLY_WRITE
            return self
        elsif mode == ONLY_READ
            raise TdlError.new("AXI4 can be ONLY_READ to ONLY_WRITE\n")
        end

        # new_obj = Axi4.new(name:@name+"_only_write",clock:@clock,reset:@reset,mode:Axi4::ONLY_WRITE,dsize:@dsize,idsize:@idsize,asize:@asize,max_len:@max_len)
        new_obj = belong_to_module.Def.axi4(name:@name+"_only_write",clock:@clock,reset:@reset,mode:Axi4::ONLY_WRITE,dsize:@dsize,idsize:@idsize,asize:@asize,lsize:@lsize,addr_step:@addr_step,freqM:@origin_freqM)
        new_obj.axi4_direct(up_stream:self)
        return new_obj
    end

    def from_both
        if mode == BOTH
            return self
        end
        # new_obj = Axi4.new(name:@name+"_both",clock:@clock,reset:@reset,mode:Axi4::BOTH,dsize:@dsize,idsize:@idsize,asize:@asize,max_len:@max_len)
        new_obj = belong_to_module.Def.axi4(name:@name+"_both",clock:@clock,reset:@reset,mode:Axi4::BOTH,dsize:@dsize,idsize:@idsize,asize:@asize,lsize:@lsize,addr_step:@addr_step,freqM:@origin_freqM)
        new_obj.axi4_direct(down_stream:self)
        return new_obj
    end

    def from_only_read
        if mode == ONLY_READ
            return self
        elsif mode == ONLY_WRITE
            raise TdlError.new("AXI4 can be ONLY_READ to ONLY_WRITE\n")
        end

        # new_obj = Axi4.new(name:@name+"_only_read",clock:@clock,reset:@reset,mode:Axi4::ONLY_READ,dsize:@dsize,idsize:@idsize,asize:@asize,max_len:@max_len)
        new_obj = belong_to_module.Def.axi4(name:@name+"_only_read",clock:@clock,reset:@reset,mode:Axi4::ONLY_READ,dsize:@dsize,idsize:@idsize,asize:@asize,lsize:@lsize,addr_step:@addr_step,freqM:@origin_freqM)
        new_obj.axi4_direct(down_stream:self)
        return new_obj
    end

    def from_only_write
        if mode == ONLY_WRITE
            return self
        elsif mode == ONLY_READ
            # Test.puts_sv Axi4.inst
            raise TdlError.new("AXI4 can be ONLY_WRITE to ONLY_READ\n")
        end

        # new_obj = Axi4.new(name:@name+"_only_write",clock:@clock,reset:@reset,mode:Axi4::ONLY_WRITE,dsize:@dsize,idsize:@idsize,asize:@asize,max_len:@max_len)
        new_obj = belong_to_module.Def.axi4(name:@name+"_only_write",clock:@clock,reset:@reset,mode:Axi4::ONLY_WRITE,dsize:@dsize,idsize:@idsize,asize:@asize,lsize:@lsize,addr_step:@addr_step,freqM:@origin_freqM)
        new_obj.axi4_direct(down_stream:self)
        return new_obj
    end

    def sync_mode(up_stream:nil,down_stream:nil)
        if up_stream
            if up_stream.mode == BOTH
                return self.from_both
            elsif up_stream.mode == ONLY_READ
                return self.from_only_read
            elsif up_stream.mode == ONLY_WRITE
                return self.from_only_write
            end
        elsif down_stream
            if down_stream.mode == BOTH
                return self.to_both
            elsif down_stream.mode == ONLY_READ
                return self.to_only_read
            elsif down_stream.mode == ONLY_WRITE
                return self.to_only_write
            end
        end
    end

    #### ==== mode trans =======================================================
    def self.sync_mode(up_stream:nil,down_stream:nil)
        if up_stream.mode == down_stream.mode
            return [up_stream,down_stream]
        elsif up_stream.mode != BOTH
            return [up_stream,down_stream.sync_mode(up_stream:up_stream)]
        elsif down_stream.mode != BOTH
            return [up_stream.sync_mode(down_stream:down_stream),down_stream]
        end
    end

    # def self.sync_dsize(up_stream:nil,down_stream:nil)
    #     if(up_stream.dsize == down_stream.dsize)
    #         return [up_stream,down_stream]
    #     else
    #         down_stream

    def copy(name:@name.to_s,clock:@clock,reset:@reset,mode:@mode,dsize:@dsize,idsize:@idsize,asize:@asize,lsize:@lsize,addr_step:@addr_step,belong_to_module:@belong_to_module,dimension:[],freqM:nil)
        # new_obj = Axi4.new(name:@name+append_name,clock:clock,reset:reset,mode:mode,dsize:dsize,idsize:idsize,asize:asize,max_len:max_len)
        append_name = name_copy(name)
        if clock.nil?
            _clock = self.axi_aclk
        else
            _clock = clock
        end

        _freqM = use_which_freq_when_copy(clock,freqM) || (!(_clock.is_a?( Clock)) && self.FreqM)

        if reset.nil?
            _reset = self.axi_aresetn
        else
            _reset = reset
        end
        new_obj = belong_to_module.Def.axi4(name:append_name,clock:_clock,reset:_reset,mode:mode,dsize:dsize,idsize:idsize,asize:asize,lsize:lsize,addr_step:addr_step,dimension:dimension,freqM:_freqM)
        return new_obj
    end

    def inherited(name:@name.to_s,
        clock: nil ,
        reset: nil,
        mode:  nil,
        dsize: nil,
        idsize: nil,
        asize: nil,
        lsize: nil,
        addr_step: nil,
        belong_to_module: @belong_to_module,
        dimension: [],
        freqM: nil)

        new_obj = nil 

        ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
            append_name = name_copy(name)
            if clock.nil?
                _clock = self.axi_aclk
            else
                _clock = clock
            end

            _freqM = use_which_freq_when_copy(clock,freqM) || (!(_clock.is_a?( Clock)) && self.FreqM)

            if reset.nil?
                _reset = self.axi_aresetn
            else
                _reset = reset
            end
            new_obj = belong_to_module.Def.axi4(
                name:append_name,
                clock:_clock,
                reset:_reset,
                mode:mode || self.MODE,
                dsize:dsize || self.DSIZE,
                idsize:idsize || self.IDSIZE,
                asize:asize || self.ASIZE,
                lsize:lsize || self.LSIZE,
                addr_step:addr_step || self.ADDR_STEP,
                dimension: dimension ,
                freqM:_freqM)
        end

        return new_obj
    end

    def branch(name:@name,clock:@clock,reset:@reset,mode:@mode,dsize:@dsize,idsize:@idsize,asize:@asize,lsize:@lsize,addr_step:@addr_step,belong_to_module:@belong_to_module,dimension:[],freqM:nil)
        # puts "freqM :: ",freqM
        a = copy(name:name,clock:clock,reset:reset,mode:mode,dsize:dsize,idsize:idsize,asize:asize,lsize:lsize,addr_step:addr_step,belong_to_module:belong_to_module,dimension:dimension,freqM:freqM)
        self << a
        return a
    end

    # def self.clear
    #     @@id = 1
    #     @@pre_inst_stack = []
    #     @@inst_stack = []
    #     @@ports = []
    #     # @@draw_stack = [NC.method(:draw).to_proc]
    #     @@draw_stack = []
    #     # NC.instance_variable_set("@correlation_proc","")
    #     @@nc = Axi4.new(name:"implicit",dsize:1,clock:Clock.NC,reset:Reset.NC)
    #     BaseElm.recfg_nc(@@nc)
    # end

    # NC = Axi4.new(name:"implicit",dsize:1,clock:Clock.NC,reset:Reset.NC)
    # NC.instance_variable_set("@_id",0)
    #
    # def NC.signal
    #     id = NC.instance_variable_get("@_id")
    #     NC.instance_variable_set("@_id",id+1).to_s
    # end

    # def self.NC
    #     GlobalParam.CurrTdlModule.BindEleClassVars.Axi4.nc
    # end
    #
    #
    # def self.nc_create
    #     Axi4.new(name:"implicit",dsize:1,clock:Clock.NC,reset:Reset.NC)
    # end

### parse text for autogen method and constant ###

Synth_REP = Regexp.union(/\(\*\s+axi4\s*=\s*"true"\s+\*\)/,/\(\*\s+axi_inf\s*=\s*"true"\s+\*\)/)

    def self.parse_ports(port_array=nil)
        rep = /(?<up_down>\(\*\s+(?<ud_name>axi4_up|axi4_down)\s*=\s*"true"\s+\*\))?\s*(axi_inf\.)(?<modport>master|slaver|master_wr|slaver_wr|master_rd|slaver_rd|master_wr_aux|master_wr_aux_no_resp|master_rd_aux|mirror_wr|mirror_rd)\s+(?<name>\w+)\s*(?<vector>\[.*?\])?/m
        up_stream_rep = /axi4_up/

        super(port_array,rep,"axi_inf",up_stream_rep) do |h|
            h[:type]   = Axi4
            yield h
        end
    end

end

class Axi4 # same_name_socket

    def self.same_name_socket(way,mix,inf_array,base_new_inf=nil,belong_to_module=nil)
        ##----
        unless inf_array.is_a? Array
            return inf_array if inf_array.respond_to?(:dimension) && inf_array.dimension.any?
            inf_array = [inf_array]
        end

        return nil if inf_array.empty?

        return inf_array[0] if (inf_array.length == 1 && mix==true)
        ## =====
        unless base_new_inf
            if mix
                new_inf = inf_array[0].copy(idsize:(inf_array[0].idsize + inf_array.length.clog2 ))
            else
                new_inf = inf_array[0].copy()
            end
        else
            new_inf = base_new_inf
        end

        super(way,mix,inf_array,new_inf,belong_to_module)
    end

end

class Axi4 ## signals in interface

    def __inf_signal__(name)
        raise TdlError.new("\nARRAY Don't have '#{name}'\n") unless @dimension.empty?
        # puts "--------------"
        # puts $new_m.instance_variable_get("@port_axisinfs")
        # puts "============="
        NqString.new(signal.concat ".#{name}")
        # signal.concat ".#{name}"
    end

    array_signals = %W{
axi_aclk
axi_aresetn
axi_awsize
axi_awburst
axi_awlock
axi_awcache
axi_awprot
axi_awqos
axi_awvalid
axi_awready
axi_arsize
axi_arburst
axi_arlock
axi_arcache
axi_arprot
axi_arqos
axi_arvalid
axi_arready
axi_bready
axi_bresp
axi_bvalid
axi_wlast
axi_wvalid
axi_wready
axi_rready
axi_rlast
axi_rvalid
DSIZE
IDSIZE
ASIZE
ADDR_STEP
LSIZE
MODE
axi_wcnt
axi_rcnt
}

    array_signals.each do |item|
        define_method(item) do
            __inf_signal__(item)
        end
    end

    # def vld_rdy
    #     axis_tvalid.concat(" && ").concat(axis_tready)
    # end
    #
    # def vld_rdy_last
    #     axis_tvalid.concat(" && ").concat(axis_tready).concat(" && ").concat(axis_tlast)
    # end

    def _axi_data(name,h=nil,l=nil)
        raise TdlError.new("\nARRAY Don't have '#{name}'") unless @dimension.empty?

        if h.is_a? Range
            l = h.to_a.min
            h = h.to_a.max
        end

        if h
            if l
                sqr = "[#{h.to_s}:#{l.to_s}]"
            else
                sqr = "[#{h.to_s}]"
            end
        else
            sqr = ""
        end
        NqString.new(signal.concat(".#{name}").concat(sqr))
    end

INTERFACE_VECTOR_SIGNALS = %W{
    axi_awid
    axi_awaddr
    axi_awlen
    axi_arid
    axi_araddr
    axi_arlen
    axi_wdata
    axi_wstrb
    axi_rdata
    axi_rresp
    axi_rid
    axi_bid
    axi_wcnt
    axi_rcnt
}

array_data_signals = Axi4::INTERFACE_VECTOR_SIGNALS

    array_data_signals.each do |item|
        define_method(item) do
            _axi_data(item)
        end
    end


end

class Axi4 # add cal addr_step

    def cal_addr_step(target_dsize)
        with_new_align do
            NqString.new("#{signal}.ADDR_STEP*#{align_signal(target_dsize)}/#{signal}.DSIZE")
        end
    end

    def self.cal_addr_step(target_dsize,origin_data)
        if origin_data.is_a? Axi4
            origin_data.cal_addr_step(target_dsize)
        elsif origin_data.is_a? Hash
            raise TdlError.new("\nWhen Cal Axi4 ADDR_STEP: Hash\n[#{origin_data}]\n dont have key dsize\n")  unless( origin_data.include? :dsize)
            raise TdlError.new("\nWhen Cal Axi4 ADDR_STEP: Hash\n[#{origin_data}]\n dont have key addr_step\n")  unless( origin_data.include? :addr_step)
            with_new_align do
                NqString.new("#{align_signal(origin_data[:addr_step])}*#{align_signal(target_dsize)}/#{align_signal(origin_data[:dsize])}")
            end
        else
            raise TdlError.new("\nCant Cal Axi4 ADDR_STEP,because origin_data Type Error,it must Hash or Axi4 \n")
        end
    end
end

class Axi4

    INTERFACE_S_SIGNALS = %W{
        axi_aclk
        axi_aresetn
        axi_awsize
        axi_awburst
        axi_awlock
        axi_awcache
        axi_awprot
        axi_awqos
        axi_awvalid
        axi_awready
        axi_arsize
        axi_arburst
        axi_arlock
        axi_arcache
        axi_arprot
        axi_arqos
        axi_arvalid
        axi_arready
        axi_bready
        axi_bresp
        axi_bvalid
        axi_wlast
        axi_wvalid
        axi_wready
        axi_rready
        axi_rlast
        axi_rvalid
        DSIZE
        IDSIZE
        ASIZE
        ADDR_STEP
        LSIZE
        MODE
        axi_wcnt
        axi_rcnt
        FreqM
    }

    class << self
        array_signals = Axi4::INTERFACE_S_SIGNALS

        array_signals.each do |item|
            define_method(item) do |obj|
                if(obj.is_a? Axi4)
                    obj.send(item)
                elsif obj.is_a? String
                    NqString.new(obj.concat ".#{item}")
                end
            end
        end
    end

end


class Axi4

    def [](a)
        if a.is_a? ClassHDL::OpertorChain
            a.slaver = true
        end

        raise TdlError.new("#{signal} isn't vector") if dimension.empty?
        signal(a)
    end
end

## 添加 兼容 VCS 的 方法

class Axi4

    def vcs_comptable(origin: 'master',to: 'slaver',lock: "origin")

        if belong_to_module.respond_to? "#{@name}_#{origin}_to_#{to}_L#{lock}"
            return belong_to_module.send("#{@name}_#{origin}_to_#{to}_L#{lock}").name.to_nq
        end
        ''' 返回字符串'''
        belong_to_module.instance_exec(self,origin,to,lock) do |origin_inf,origin_modport,to_modport,lock|
            Instance(:vcs_axi4_comptable,"vcs_axi4_comptable_#{origin_inf.name}_#{origin_modport}_#{to_modport}_lock_#{lock}_inst") do |h|
                h[:ORIGIN]  = origin_modport
                h[:TO]      = to_modport
                if lock.to_s.downcase == "origin"
                    h[:origin]  = origin_inf
                    h[:to]      = origin_inf.copy(name: "#{origin_inf.name}_#{origin_modport}_to_#{to_modport}_L#{lock}")
                else 
                    h[:to]      = origin_inf
                    h[:origin]  = origin_inf.copy(name: "#{origin_inf.name}_#{origin_modport}_to_#{to_modport}_L#{lock}")
                end
            end
        end

        return belong_to_module.send("#{@name}_#{origin}_to_#{to}_L#{lock}").name.to_nq
    end
end
