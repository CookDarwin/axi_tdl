
class CommCfgReg < BaseElm
    GENERAL = :general
    ONLY_READ = :only_read
    INCLUDE_RESET  = :include_reset

    # ONLY_JTAG = :only_jtag
    # PORT_AND_JTAG = :port_and_jtag
    # ONLY_PORT = :only_port
    @@id = 0
    @@inst_stack = []

    def self.clear
        @@id = 0
        @@inst_stack = []
    end

    def initialize(axil=nil)
        raise TdlError.new("\nCOMMON CFG REG AXI LITE Can't be nil \n") unless axil
        @axil = axil
        @id = @@id
        @@id += 1
        @addr_list = []
        @proc_params = []
        @reg_inst_stack = []
        @index = 0

        @@inst_stack << method(:inst)

    end


    # attr_reader :addr,:default,:reset,:type
    def Reg(addr:0,default:0,reset:nil,type: GENERAL,signal:nil,name:nil)
        raise TdlError.new("\n COMMON CFG REG ADDR[#{@addr_list.to_s}] already has ADD[#{addr}]\n") if @addr_list.include? addr

        @addr_list << addr


        unless signal
            unless name
                ccr = Logic.new(name:"commCfgReg",dsize:32)
            else
                ccr = Logic.new(name:name,dsize:32)
            end
        else
            ccr = signal
        end

        @proc_params << {index:@index,addr:addr,default:default,reset:reset,type: type,signal:ccr}
        @index += 1
        return ccr
    end

    def WideReg(addr:0,default:0,reset:nil,type: GENERAL,signal:nil,name:nil,dsize:64)
        if dsize <= 32
            Reg(addr:addr,default:default,reset:reset,type: type,signal:signal,name:name)
        else
            wide = Logic.new(name:"commCfgReg_wide",dsize:dsize)
            default_logic = Logic.new(name:"commCfgReg_default",dsize:dsize)

            if signal
                signal_logic = Logic.new(name:"commCfgReg_signal",dsize:dsize)
            end

            Assign do
                default_logic   <= default
                if signal
                    signal_logic <= signal
                end
            end

            aa = []

            ((dsize)/32.0).ceil.times do |i|
                if signal
                    sstr = signal_logic.signal(h:i*32+32-1,l:i*32)
                else
                    sstr = nil
                end
                aa << Reg(addr:addr+i,default:default_logic.signal(h:i*32+32-1,l:i*32),reset:reset,type: type,signal:sstr,name:name)
            end

            Assign do
                wide <= "{#{aa.reverse.map{|e| e.signal }.join(',')}}"
            end
            return wide
        end
    end

    undef :signal


    def inst
        page(tag:"common_configure_reg_interface",body:head_inst + reg_inst)
    end

    def self.inst
        @@inst_stack.map{|e| e.call }.join("")
    end

    Tdl.after_dynamict_inst_stack << method(:inst)

    def head_inst
        with_new_align(0) do
"
common_configure_reg_interface #(
    .ASIZE  (#{align_signal(@axil,q_mark=false)}.ASIZE ),
    .DSIZE  (#{align_signal(@axil,q_mark=false)}.DSIZE )
)cfg_inf_#{@id} [#{@addr_list.size}-1:0] ();

axi_lite_configure #(
    .TOTAL_NUM      (#{@addr_list.size})
)axi_lite_configure_inst_#{@id}(
/*    axi_lite_inf.slaver                    */ .axil           (#{align_signal(@axil,q_mark=false)}),
/*    common_configure_reg_interface.master  */ .cfg_inf        (cfg_inf_#{@id})//[TOTAL_NUM-1:0]
);
"       end
    end

    def reg_inst
        with_new_align(0) do
            @proc_params.map do |pp|
                case pp[:type]
                when GENERAL
                    "general_reg REG_cfg_inf_#{@id}_#{pp[:index]}  (cfg_inf_#{@id}[#{pp[:index]}],#{align_signal(pp[:addr],q_mark=false)},#{align_signal(pp[:signal],q_mark=false)},#{align_signal(pp[:default],q_mark=false)});"
                when ONLY_READ
                    "general_only_read_reg REG_cfg_inf_#{@id}_#{pp[:index]}  (cfg_inf_#{@id}[#{pp[:index]}],#{align_signal(pp[:addr],q_mark=false)},#{align_signal(pp[:signal],q_mark=false)});"
                when INCLUDE_RESET
                    "CFG_REG REG_cfg_inf_#{@id}_#{pp[:index]} (cfg_inf_#{@id}[#{pp[:index]}],#{align_signal(pp[:addr],q_mark=false)},#{align_signal(pp[:signal],q_mark=false)},#{align_signal(pp[:default],q_mark=false)},#{align_signal(pp[:signal],q_mark=false)},#{align_signal(pp[:reset],q_mark=false)});"
                else
                    "general_reg REG_cfg_inf_#{@id}_#{pp[:index]}  (cfg_inf_#{@id}[#{pp[:index]}],#{align_signal(pp[:addr],q_mark=false)},#{align_signal(pp[:signal],q_mark=false)},#{align_signal(pp[:default],q_mark=false)});"
                end
            end.join("\n")
        end
    end


end
