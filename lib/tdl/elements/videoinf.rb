
# require_relative "./tdlerror"
# require_relative "./basefunc"
# require_relative "./VideoInf/video_lib"

class VideoInf < CLKInfElm
    extend BaseFunc
    include BaseModule

    attr_accessor :name,:dsize,:id,:ghost,:port

    def initialize(name:"video",dsize:24,clock:nil,reset:nil,port:false,dimension:[],freqM:nil)
        name_legal?(name)
        super(dimension:dimension,clock:clock,reset:reset,freqM:freqM)
        @name = name
        @dsize = dsize
        @port = port
        # @id = GlobalParam.CurrTdlModule.BindEleClassVars.VideoInf.id
        # @correlation_proc = ""
        # if @port
        #     GlobalParam.CurrTdlModule.BindEleClassVars.VideoInf.ports << self
        # else
        #     GlobalParam.CurrTdlModule.BindEleClassVars.VideoInf.inst_stack << method(:inst).to_proc
        # end

        # GlobalParam.CurrTdlModule.BindEleClassVars.VideoInf.draw_stack << method(:draw).to_proc
    end

    # def signal
    #     if @force_name
    #         @force_name.to_s
    #     elsif @port
    #         @name.to_s
    #     else
    #         "video_#{@name}_#{@id}"
    #     end
    # end

    def inst
        return "" if @ghost
        large_name_len("")
        if @reset.respond_to?(:low_signal)
            "video_native_inf #( .DSIZE(#{@dsize}),.FreqM(#{intf_def_freqM})) #{signal} (.pclk(#{align_signal(@clock,q_mark=false)}),.prst_n(#{align_signal(@reset.low_signal,q_mark=false)}));\n"
        else
            "video_native_inf #( .DSIZE(#{@dsize}),.FreqM(#{intf_def_freqM})) #{signal} (.pclk(#{align_signal(@clock,q_mark=false)}),.prst_n(#{align_signal(@reset,q_mark=false)}));\n"
        end
    end

    # def port_length
    #     ("video_native_inf." + @port.to_s + " ").length
    # end

    def inst_port

        # if @port
        #     ("video_native_inf." + @port.to_s + " " + " "*sub_len + @name.to_s)
        # end
        if @port.to_s =~ /compact/
            str = @port.to_s
        elsif @port.to_s.downcase.eql? "master"
            str = "compact_out"
        elsif @port.to_s.downcase.eql? "slaver"
            str = "compact_in"
        else
            str = @port.to_s
        end

        return ["video_native_inf." + str,@name.to_s,array_inst]
    end

    # def left_port_length
    #     ("/*  video_native_inf." + @port.to_s + " */ ").length
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
    #         ("/*  video_native_inf." + @port.to_s + " "*sub_left_len + "*/ " + "."+@name.to_s + " "*sub_right_len)
    #     end
    # end

    def draw
        super
        return ''   if @correlation_proc.empty?
        head_str = "\n//-------->>>> #{signal} <<<<----------------\n"
        end_str  = "\n//========<<<< #{signal} >>>>================\n"
        return head_str+@correlation_proc+end_str
    end

    def copy(name:@name.to_s,dsize:@dsize,clock:@clock,reset:@reset,freqM:nil)
        append_name = name_copy(name)
        _freqM = use_which_freq_when_copy(clock,freqM)
        new_obj = VideoInf.new(name:append_name,dsize:dsize,clock:clock,reset:reset,freqM:_freqM)
    end


    # def self.inst
    #     GlobalParam.CurrTdlModule.BindEleClassVars.VideoInf.inst_stack.map { |e| e.call }.join("")
    # end
    #
    # def self.draw
    #     str = ""
    #     GlobalParam.CurrTdlModule.BindEleClassVars.VideoInf.draw_stack.each do |e|
    #         str += e.call
    #     end
    #     return str
    # end

    # def self.clear
    #     @@id = 1
    #     @@inst_stack = []
    #     @@ports = []
    #     # @@draw_stack = [NC.method(:draw).to_proc]
    #     @@draw_stack = []
    #     # NC.instance_variable_set("@correlation_proc","")
    #     @@nc = self.new(name:"implicit")
    #     BaseElm.recfg_nc(@@nc)
    # end

    # NC = self.new(name:"implicit")
    # NC.instance_variable_set("@_id",0)
    #
    # def NC.signal
    #     id = NC.instance_variable_get("@_id")
    #     NC.instance_variable_set("@_id",id+1).to_s
    # end

    # def self.NC
    #     GlobalParam.CurrTdlModule.BindEleClassVars.VideoInf.nc
    # end
    #
    # def self.nc_create
    #     self.new(name:"implicit")
    # end

    ## signal ref

    def vsync
        signal+".vsync"
    end

    def hsync
        signal+".hsync"
    end

    def de
        signal+".de"
    end

    def data
        signal+".data"
    end

### parse text for autogen method and constant ###

Synth_REP = Regexp.union(/\(\*\s+videoinf\s*=\s*"true"\s+\*\)/, /\(\*\s+video_native_inf\s*=\s*"true"\s+\*\)/)

    def self.parse_ports(port_array=nil)
        rep = /(?<up_down>\(\*\s+(?<ud_name>video_up|video_down)\s*=\s*"true"\s+\*\))?\s*(video_native_inf\.)(?<modport>compact_out|compact_in)\s+(?<name>\w+)\s*(?<vector>\[.*?\])?/m
        up_stream_rep = /video_up/

        InfElm.parse_ports(port_array,rep,"video_native_inf",up_stream_rep) do |h|
            h[:type] = VideoInf
            yield h
        end
    end

end

class VideoInf ## signals in interface

    def __inf_signal__(name)
        raise TdlError.new("\nARRAY Don't have '#{name}'\n") unless @dimension.empty?
        # puts "--------------"
        # puts $new_m.instance_variable_get("@port_axisinfs")
        # puts "============="
        NqString.new(signal.concat ".#{name}")
        # signal.concat ".#{name}"
    end

    array_signals = %W{pclk prst_n vsync hsync de DSIZE}

    array_signals.each do |item|
        define_method(item) do
            __inf_signal__(item)
        end
    end


    def data(h=nil,l=nil)
        raise TdlError.new("\nARRAY Don't have 'data'") unless @dimension.empty?

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
        NqString.new(signal.concat(".data").concat(sqr))
    end
end
