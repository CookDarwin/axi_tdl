# require_relative "./tdlerror"
# require_relative "./clock"
# require_relative "./Reset"
# require_relative "./logic"
# require_relative "./basefunc"
# require_relative "./axi_stream/axi_stream_lib"

class AxiLite < CLKInfElm
    extend BaseFunc
    include BaseModule
    MACRO = '..\..\axi\macro\axil_macro.sv'
    BOTH = "BOTH"
    ONLY_READ  = "ONLY_READ"
    ONLY_WRITE = "ONLY_WRITE"

    attr_accessor :id,:name,:dsize,:asize,:mode,:ghost,:port

    def initialize(name:"axi_lite",clock:nil,reset:nil,dsize:8,asize:8,mode:BOTH,port:false,freqM:nil)
        name_legal?(name)
        super(clock:clock,reset:reset,freqM:freqM)
        @inf_name = "axi_lite_inf"
        @name = name
        @dsize = dsize
        @asize = asize
        @mode = mode
        @port = port

        # @id = GlobalParam.CurrTdlModule.BindEleClassVars.AxiLite.id
        # @correlation_proc = ""
        # if @port
        #     GlobalParam.CurrTdlModule.BindEleClassVars.AxiLite.ports << self
        # else
        #     GlobalParam.CurrTdlModule.BindEleClassVars.AxiLite.inst_stack << method(:inst).to_proc
        # end
        # @interconnect_up_streams = []
        # GlobalParam.CurrTdlModule.BindEleClassVars.AxiLite.draw_stack << method(:draw).to_proc
    end

    # def signal
    #     if @port
    #         @name.to_s
    #     else
    #         "lite_#{@name}_#{@id}_inf"
    #     end
    # end

    def inst
        return "" if @ghost
        large_name_len(@mode,@clock,@reset)
"
#{@inf_name} #(
    .ASIZE      (#{align_signal(asize)}),
    .DSIZE      (#{align_signal(dsize)}),
    .FreqM      (#{freq_align_signal})
)#{signal}(
    .axi_aclk       (#{align_signal(@clock,false)}),
    .axi_aresetn    (#{align_signal(@reset.low_signal,false)})
);
"
    end

    # def self.inst
    #     GlobalParam.CurrTdlModule.BindEleClassVars.AxiLite.inst_stack.map { |e| e.call }.join("")
    # end
    #
    # def self.draw
    #     str = ""
    #     GlobalParam.CurrTdlModule.BindEleClassVars.AxiLite.draw_stack.each do |e|
    #         str += e.call
    #     end
    #     return str
    # end

    def draw
        super
        return ''   if @interconnect_up_streams.empty? && @correlation_proc.empty?
        head_str = "\n//-------->>>> #{signal} <<<<----------------\n"
        end_str  = "\n//========<<<< #{signal} >>>>================\n"
        unless @interconnect_up_streams.empty?
            @correlation_proc += interconnect_draw
        end
        return head_str+@correlation_proc+end_str
    end

    def copy(name:@name.to_s,clock:@clock,reset:@reset,dsize:@dsize,asize:@asize,freqM:nil)
        _freqM = use_which_freq_when_copy(clock,freqM)
        append_name = name_copy(name)
        new_obj = AxiLite.new(name:append_name,clock:clock,reset:reset,dsize:dsize,asize:asize,freqM:_freqM)
        return new_obj
    end

    # def self.clear
    #     @@id = 1
    #     @@inst_stack = []
    #     @@ports = []
    #     # @@draw_stack = [NC.method(:draw).to_proc]
    #     @@draw_stack = []
    #     # NC.instance_variable_set("@correlation_proc","")
    #     @@nc = AxiLite.new(name:"implicit",dsize:1,clock:Clock.NC,reset:Reset.NC)
    #     BaseElm.recfg_nc(@@nc)
    # end

    # NC = AxiLite.new(name:"implicit",dsize:1,clock:Clock::NC,reset:Reset::NC)
    # NC.instance_variable_set("@_id",0)

    # def NC.signal
    #     id = NC.instance_variable_get("@_id")
    #     NC.instance_variable_set("@_id",id+1).to_s
    # end

    # @@nc = AxiLite.new(name:"implicit",dsize:1,clock:Clock.NC,reset:Reset.NC)
    # @@nc.instance_variable_set("@_id",0)

    # def self.NC
    #     GlobalParam.CurrTdlModule.BindEleClassVars.AxiLite.nc
    # end

    # def @@nc.signal
    #     id = @@nc.instance_variable_get("@_id")
    #     @@nc.instance_variable_set("@_id",id+1).to_s
    # end

    def self.nc_create
        AxiLite.new(name:"implicit",dsize:1,clock:Clock.NC,reset:Reset.NC)
    end

### parse text for autogen method and constant ###

Synth_REP = Regexp.union(/\(\*\s+axi_lite\s*=\s*"true"\s+\*\)/,/\(\*\s+lite\s*=\s*"true"\s+\*\)/)

    def self.parse_ports(port_array=nil)
        rep = /(?<up_down>\(\*\s+(?<ud_name>axil_up|axil_down)\s*=\s*"true"\s+\*\))?\s*(axi_lite_inf\.)(?<modport>master|slaver|master_rd|slaver_rd|master_wr|slaver_wr)\s+(?<name>\w+)\s*(?<vector>\[.*?\])?/m
        up_stream_rep = /axil_up/

        super(port_array,rep,"axi_lite_inf",up_stream_rep) do |h|
            h[:type]   = AxiLite
            yield h
        end
    end



end


class AxiLite ## signals in interface

    def __inf_signal__(name)
        raise TdlError.new("\nARRAY Don't have '#{name}'\n") unless @dimension.empty?
        # puts "--------------"
        # puts $new_m.instance_variable_get("@port_axisinfs")
        # puts "============="
        NqString.new(signal.concat ".#{name}")
        # signal.concat ".#{name}"
    end

    INTERFACE_S_SIGNALS = %W{
axi_aclk
axi_aresetn
axi_awsize
axi_awvalid
axi_awready
axi_arsize
axi_arvalid
axi_arready
axi_bready
axi_bresp
axi_bvalid
axi_wvalid
axi_wready
axi_rready
axi_rvalid
DSIZE
ASIZE
MODE
FreqM
}
array_signals = AxiLite::INTERFACE_S_SIGNALS

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
        signal.concat(".#{name}").concat(sqr)
    end

INTERFACE_VECTOR_SIGNALS = %W{
    axi_awaddr
    axi_araddr
    axi_wdata
    axi_rdata
}

array_data_signals = INTERFACE_VECTOR_SIGNALS

    array_data_signals.each do |item|
        define_method(item) do
            _axi_data(item)
        end
    end


end

class AxiLite # add empty
    def self.leave_empty(curr_type: :master,dsize:8,asize:32,clock:Clock.NC,reset:Reset.NC)
        nc = AxiLite.new(name:"empty",clock:clock,reset:reset,dsize:dsize,asize:asize,mode:BOTH,port:false)

        if curr_type.to_sym == :slaver
            self.axi_lite_master_empty(lite:nc)
        elsif curr_type.to_sym == :master
            self.axi_lite_slaver_empty(lite:nc)
        else
            raise TdlError.new("\n\n Axi Lite don't has this type << #{type} >> \n\n")
        end

        return nc
    end
end
