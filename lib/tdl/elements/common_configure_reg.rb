
class CommonCFGReg < InfElm
    extend BaseFunc
    include BaseModule
    attr_accessor :name,:dsize,:asize,:id,:ghost,:port
    def initialize(name:"cfg_inf",dsize:8,asize:8,port:false,dimension:[])
        name_legal?(name)
        super(dimension:dimension)
        @port = port
        @dsize = dsize
        @name = name
        @asize = asize
    end

    def inst
        return "" if @ghost || @port
"common_configure_reg_interface #(
    .ASIZE  (#{asize}),
    .DSIZE  (#{dsize})
)#{signal} #{array_inst} ();"
    end

    def inst_port
        return ["common_configure_reg_interface." + @port.to_s,@name.to_s,array_inst]
    end

    ## SV FILE PORT PARSE

    def self.parse_ports(port_array=nil)
        rep = /(?<up_down>\(\*\s+(?<ud_name>stream_up|stream_down)\s*=\s*"true"\s+\*\))?\s*(common_configure_reg_interface\.)(?<modport>master|slaver)\s+(?<name>\w+)\s*(?<vector>\[.*?\])?/m
        up_stream_rep = /stream_up/

        InfElm.parse_ports(port_array,rep,"common_configure_reg_interface",up_stream_rep) do |h|
            h[:type] = CommonCFGReg
            yield h
        end
    end

    ## SdlInst

    def self.sdlinst_t0(ele)
        if ele.class ==  CommonCFGReg then
            "common_configure_reg_interface.#{ele.port}"
        else
            nil
        end
    end


end

class CommonCFGReg ## signals in interface

    def __inf_signal__(name,index=0)
        NqString.new(signal(index).concat ".#{name}")
        # signal.concat ".#{name}"
    end

    array_signals = %W{ rst interrupt_enable interrupt_trigger DSIZE ASIZE }

    array_signals.each do |item|
        define_method(item) do |index=0|
            __inf_signal__(item,index)
        end
    end

    array_signals_list = %W{wdata,rdata,addr,default_value}

    array_signals_list.each do |item|
        define_method(item) do |h=nil,l=nil,index=0|
            __inf_signal_list_(item,index,h,l)
        end
    end

    def __inf_signal_list_(lname,index=0,h=nil,l=nil)

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
        NqString.new(signal(index).concat(".#{lname}").concat(sqr))
    end

end


class DefXp

    def common_cfg_reg_inf(name:"cfg_inf",dsize:8,asize:8,dimension:[],&block)
        a = CommonCFGReg.new(name:name,dsize:dsize,asize:asize,dimension:dimension)
        var_common(a,&block)
        add_method_to_itgt(name,a)
    end

end

class SdlModule

    def CommonCFGReg
        unless @Def_CommonCFGReg
            @Def_CommonCFGReg = InfPort.new(self,CommonCFGReg)
            class << @Def_CommonCFGReg

                def Def_CommonCFGReg_port_(name,dsize:8,asize:8,port: :master,dimension:[])
                    port_name_chk(name)
                    a = CommonCFGReg.new(name:name,dsize:dsize,asize:asize,port:port.to_s,dimension:dimension)
                    sdlmodule.add_to_new_module("@port_datainf_c_s",a)
                    if block_given?
                        yield(a)
                    end
                    StringBandItegration.add_method_to_itgt(name,a)
                    a
                end
            end
            [:master,:slaver].each do |ty|
                @Def_CommonCFGReg.define_singleton_method(ty) do |name,dsize:8,asize: 8,dimension:[]|
                    Def_CommonCFGReg_port_(name,dsize:dsize,asize: asize,port:ty,dimension:dimension)
                end
            end
            @Def_CommonCFGReg
        else
            @Def_CommonCFGReg
        end
    end
end
