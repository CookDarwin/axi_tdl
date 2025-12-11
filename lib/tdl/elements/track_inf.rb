

class TrackInf < CLKInfElm
    extend BaseFunc
    include BaseModule

    attr_accessor :name,:ghost,:id
    attr_accessor :dsize,:port,:enable,:tsize

    def initialize(name:"t_inf",dsize:24,tsize:1,clock:nil,reset:nil,enable:"1'b1".to_nq,port:false,dimension:[],freqM:nil)
        name_legal?(name)
        super(dimension:dimension,clock:clock,reset:reset,freqM:freqM)
        @name = name
        @dsize = dsize
        @port = port
        @tsize = tsize
        @enable = enable

    end

    def inst
        return "" if @ghost || @port
        with_new_align(0) do
            if @reset.is_a? SignalElm
                if @reset.active.casecmp("LOW") == 0
                    "track_inf #(.DSIZE(#{dsize}),.TSIZE(#{tsize}),.FreqM(#{intf_def_freqM}))  #{signal} #{array_inst}(.clock(#{align_signal(@clock,false)}),.rst_n(#{align_signal(@reset,false)}),.enable(#{align_signal(@enable,false)}));"
                else
                    "track_inf #(.DSIZE(#{dsize}),.TSIZE(#{tsize}),.FreqM(#{intf_def_freqM}))  #{signal} #{array_inst}(.clock(#{align_signal(@clock,false)}),.rst_n(!#{align_signal(@reset,false)}),.enable(#{align_signal(@enable,false)}));"
                end
            else
                "track_inf #(.DSIZE(#{dsize}),.TSIZE(#{tsize}),.FreqM(#{intf_def_freqM}))  #{signal} #{array_inst}(.clock(#{align_signal(@clock,false)}),.rst_n(#{align_signal(@reset,false)}),.enable(#{align_signal(@enable,false)}));"
            end
        end
    end

    def inst_port
        return ["track_inf." + @port.to_s,@name.to_s,array_inst]
    end

    ## SV FILE PORT PARSE

    def self.parse_ports(port_array=nil)
        rep = /(?<up_down>\(\*\s+(?<ud_name>stream_up|stream_down)\s*=\s*"true"\s+\*\))?\s*(track_inf\.)(?<modport>master|slaver)\s+(?<name>\w+)\s*(?<vector>\[.*?\])?/m
        up_stream_rep = /stream_up/

        InfElm.parse_ports(port_array,rep,"track_inf",up_stream_rep) do |h|
            h[:type] = TrackInf
            yield h
        end
    end

    ## SdlInst

    def self.sdlinst_t0(ele)
        if ele.class ==  TrackInf then
            "track_inf.#{ele.port}"
        else
            nil
        end
    end

end

class TrackInf ## signals in interface

    def __inf_signal__(name)
        raise TdlError.new("\nARRAY Don't have '#{name}'\n") unless @dimension.empty?
        # puts "--------------"
        # puts $new_m.instance_variable_get("@port_axisinfs")
        # puts "============="
        NqString.new(signal.concat ".#{name}")
        # signal.concat ".#{name}"
    end

    array_signals = %W{ clock rst_n enable DSIZE TSIZE }

    array_signals.each do |item|
        define_method(item) do
            __inf_signal__(item)
        end
    end


    def track_trigger(h=nil,l=nil)
        raise TdlError.new("\nARRAY Don't have 'track_trigger'") unless @dimension.empty?

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
        NqString.new(signal.concat(".track_trigger").concat(sqr))
    end

    def track_signals(h=nil,l=nil)
        raise TdlError.new("\nARRAY Don't have 'track_signals'") unless @dimension.empty?

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
        NqString.new(signal.concat(".track_signals").concat(sqr))
    end
end

class DefXp

    def track_inf(name:"t_inf",clock:nil,reset:nil,dsize:8,tsize:1.to_nq,enable:"1'b1".to_nq,dimension:[],&block)
        a = TrackInf.new(name:name,clock:clock,reset:reset,dsize:dsize,tsize:tsize,enable:enable,dimension:dimension)
        var_common(a,&block)
        add_method_to_itgt(name,a)
    end

end

class SdlModule

    def TrackInf
        unless @Def_TrackInf
            @Def_TrackInf = InfPort.new(self,TrackInf)
            class << @Def_TrackInf

                def Def_TrackInf_port_(name,dsize:8,tsize:1,enable:"1'b1".to_nq,port: :master,dimension:[])
                    port_name_chk(name)
                    a = TrackInf.new(name:name,dsize:dsize,tsize:tsize,enable:enable,port:port.to_s,dimension:dimension)
                    sdlmodule.add_to_new_module("@port_datainf_c_s",a)
                    if block_given?
                        yield(a)
                    end
                    StringBandItegration.add_method_to_itgt(name,a)
                    a
                end
            end
            [:master,:slaver].each do |ty|
                @Def_TrackInf.define_singleton_method(ty) do |name,dsize:8,tsize: 1,enable:"1'b1".to_nq,dimension:[]|
                    Def_TrackInf_port_(name,dsize:dsize,tsize: tsize,enable:enable,port:ty,dimension:dimension)
                end
            end
            @Def_TrackInf
        else
            @Def_TrackInf
        end
    end
end
