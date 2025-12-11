# require_relative "./tdlerror"
# require_relative "./basefunc"
class Clock < SignalElm
    include BaseModule
    attr_reader :name
    attr_accessor :id,:ghost,:port,:dsize,:freqM,:jitter

    def initialize(name:"system_clock",freqM:100.0,port:false,dsize:1,jitter: 0.01, belong_to_module: nil)
        name_legal?(name)
        # @id = GlobalParam.CurrTdlModule.BindEleClassVars.Clock.id
        @name = name
        @freqM = freqM
        @port = port
        @dsize = dsize
        @jitter = jitter
        @belong_to_module = belong_to_module
        unless @belong_to_module 
            raise TdlError.new("Clock<#{name}> dnot have belong_to_module")
        end
    end

    # def port_length
    #     (@port.to_s + " ").length
    # end

    def inst_port(align_len = 7)
        # if align_len >=  port_length
        #     sub_len = align_len - port_length
        # else
        #     sub_len = 0
        # end
        #
        # if @port
        #     (@port.to_s + " " + " "*sub_len + @name.to_s)
        # end

        if dsize.eql? 1
            n = ""
        else
            n = "[#{(@dsize-1)}:0]"
        end

        return [@port.to_s+n, @name.to_s,""]
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
    #         "/*  input" +
    #         " "*sub_left_len +
    #         "*/ " +
    #         "." +
    #         @name.to_s +
    #         " "*sub_right_len
    #     end
    # end

    # def signal
    #     if @port
    #         @name.to_s
    #     else
    #         "clk_#{@name}_id#{@id}_#{@freqM.to_i}M"
    #     end
    # end

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
    #     GlobalParam.CurrTdlModule.BindEleClassVars.Clock.inst_stack.map{|e| e.call }.join("")
    # end

    # def self.clear
    #     @@id = 1
    #     @@inst_stack = []
    #     @@ports = []
    #     @@nc = Clock.new(name:"nc_clk",freqM:0.0)
    #     BaseElm.recfg_nc(@@nc)
    # end

    # NC = Clock.new(name:"nc_clk",freqM:0.0)
    # NC.instance_variable_set("@_id",0)
    #
    # def NC.signal
    #     id = NC.instance_variable_get("@_id")
    #     NC.instance_variable_set("@_id",id+1).to_s
    # end

    # def self.NC
    #     GlobalParam.CurrTdlModule.BindEleClassVars.Clock.nc
    # end
    #
    # def self.nc_create
    #     Clock.new(name:"nc_clk",freqM:0.0)
    # end

### parse text for autogen method and constant ###
    def self.parse_ports(port_str)
        rh = super.parse_ports(port_str)
        rh[:type]   = Clock
        return rh
    end

end


class Clock

    def self.same_clock(blm,*clks)
        blm.Clock_draw << "//-------- CLOCKs Total #{clks.size} ----------------------"
        clks[1,clks.size].each do |c|
            self.checkpclock(clks[0],c,blm)
        end
        blm.Clock_draw << "//======== CLOCKs Total #{clks.size} ======================"
    end

    def self.checkpclock(aclk,bclk,blm)
        blm.Clock_draw << self.checkpclockdraw(aclk,bclk,blm)
    end

    def self.checkpclockdraw(aclk,bclk,blm)
        @@_cpc_id ||= 0
        cc_done = "cc_done_#{@@_cpc_id}"
        cc_same = "cc_same_#{@@_cpc_id}"
        cc_afreq = "cc_afreq_#{@@_cpc_id}"
        cc_bfreq = "cc_bfreq_#{@@_cpc_id}"
        str =
"//--->> CheckClock <<----------------
logic #{cc_done},#{cc_same};
integer #{cc_afreq},#{cc_bfreq};
ClockSameDomain CheckPClock_inst_#{@@_cpc_id}(
/*  input         */      .aclk     (#{align_signal(aclk,q_mark=false)}),
/*  input         */      .bclk     (#{align_signal(bclk,q_mark=false)}),
/*  output logic  */      .done     (#{cc_done}),
/*  output logic  */      .same     (#{cc_same}),
/*  output integer */     .aFreqK   (#{cc_afreq}),
/*  output integer */     .bFreqK   (#{cc_bfreq})
);

initial begin
    wait(#{cc_done});
    assert(#{cc_same})
    else begin
        $error(\"--- Error : `#{blm.module_name}` clock is not same, #{aclk}< %0f M> != #{bclk}<%0f M>\",1000000.0/#{cc_afreq}, 1000000.0/#{cc_bfreq});
        repeat(10)begin 
            @(posedge #{aclk});
        end
        $stop;
    end
end
//---<< CheckClock >>----------------
"
        @@_cpc_id += 1
        str
    end
end
