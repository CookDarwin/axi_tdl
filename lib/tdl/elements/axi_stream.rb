# require_relative "./tdlerror"
# require_relative "./clock"
# require_relative "./Reset"
# require_relative "./logic"
# require_relative "./basefunc"
# require_relative "./axi_stream/axi_stream_lib"

class AxiStream < CLKInfElm
    extend BaseFunc
    include BaseModule

    attr_accessor :id,:name,:dsize,:ghost
    attr_accessor :port
    def initialize(name:"test_axis",clock:nil,reset:nil,dsize:nil,port:false,dimension:[],freqM:nil)
        name_legal?(name)
        super(dimension:dimension,clock:clock,reset:reset,freqM:freqM)
        @name = name.to_s
        # @id = GlobalParam.CurrTdlModule.BindEleClassVars.AxiStream.id

        @port = port
        # raise TdlError.new("AXI STREAM CLOCK ERROR >>#{clock.class}<<") unless clock.is_a? Clock
        # raise TdlError.new("AXI STREAM RESET ERROR") unless reset.is_a? Reset
        # raise TdlError.new("AXI STREAM DATA ERROR")  unless dsize.is_a? Fixnum

        @dsize = dsize

        unless port
            @dsize = dsize
            @clock = clock
            @reset = reset
        else
            if dimension.empty?
                @dsize = "#{name.to_s}.DSIZE".to_nq unless dsize
                @clock = "#{name.to_s}.aclk".to_nq  unless clock
                @reset = "#{name.to_s}.aresetn".to_nq unless reset
            else
                @dsize = "#{name.to_s}[0].DSIZE".to_nq unless dsize
                @clock = "#{name.to_s}[0].aclk".to_nq unless clock
                @reset = "#{name.to_s}[0].aresetn".to_nq unless reset
            end
        end
        # add_dsize_func
        # @correlation_proc = ""
        # @up_streams = []
        # if @port
        #     GlobalParam.CurrTdlModule.BindEleClassVars.AxiStream.ports << self
        # else
        #     GlobalParam.CurrTdlModule.BindEleClassVars.AxiStream.inst_stack << method(:inst).to_proc
        # end
        # @interconnect_up_streams = []

        # GlobalParam.CurrTdlModule.BindEleClassVars.AxiStream.draw_stack << method(:draw).to_proc
    end

    # def signal(index=nil)
    #     square_str = super(index)
    #     if @port
    #         String.new(@name.to_s).concat  square_str
    #     else
    #         unless @nc
    #             String.new("axis_#{@name}_id#{@id}#{square_str}")
    #         else
    #             String.new("nc_axis_#{@name}_id#{@id}#{square_str}")
    #         end
    #     end
    # end

    def inst
        return "" if @ghost
        if @reset.is_a? SignalElm
            if @reset.active.casecmp("LOW") == 0
                "axi_stream_inf #(.DSIZE(#{dsize}),.FreqM(#{intf_def_freqM}))  #{signal}#{array_inst} (.aclk(#{compact_signal(@clock)}),.aresetn(#{@reset.signal}),.aclken(1'b1));"
            else
                "axi_stream_inf #(.DSIZE(#{dsize}),.FreqM(#{intf_def_freqM}))  #{signal}#{array_inst} (.aclk(#{compact_signal(@clock)}),.aresetn(!#{@reset.signal}),.aclken(1'b1));"
            end
        else
            "axi_stream_inf #(.DSIZE(#{dsize}),.FreqM(#{intf_def_freqM}))  #{signal}#{array_inst} (.aclk(#{compact_signal(@clock)}),.aresetn(#{compact_signal(@reset)}),.aclken(1'b1));"
        end
    end

    def port_length
        ("axi_stream_inf." + @port.to_s + " ").length
    end

    def inst_port

        # if @port
        #     ("axi_stream_inf." + @port.to_s + " " + " "*sub_len + @name.to_s + array_inst)
        # end

        return ["axi_stream_inf." + @port.to_s,@name.to_s,array_inst]
    end


    # def copy(name:@name,clock:"#{signal(0)}.aclk",reset:"#{signal(0)}.aresetn",dsize:"#{signal(0)}.DSIZE")
    def copy(name:@name.to_s,clock:@clock,reset:@reset,dsize:@dsize,freqM:nil,dimension:[])
        append_name = name_copy(name)
        _freqM = use_which_freq_when_copy(clock,freqM)
        a = belong_to_module.Def.axi_stream(name:append_name,clock:clock,reset:reset,dsize:dsize,freqM:_freqM,dimension:dimension)
        a
    end

    def inherited(name:@name.to_s,clock: nil,reset: nil,dsize: nil,freqM: nil,dimension:[])
        a = nil 
        ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
            append_name = name_copy(name)
            _freqM = use_which_freq_when_copy(clock,freqM)
            a = belong_to_module.Def.axi_stream(
                name:append_name,
                clock: clock || self.aclk,
                reset: reset || self.aresetn,
                dsize: dsize || self.DSIZE,
                freqM: _freqM,
                dimension: dimension)
        end
        a
    end

    def branch(name:@name,clock:@clock,reset:@reset,dsize:@dsize,freqM:nil)
        a =  copy(name:name,clock:clock,reset:reset,dsize:dsize,freqM:freqM)
        self << a
        return a
    end

    def self.string_copy_inf(strs,belong_to_module)
        @@_str_cp_id ||= 0
        a = belong_to_module.Def.axi_stream(name:"string_copy_axis_#{@@_str_cp_id}",clock:"#{strs}.aclk",reset:"#{strs}.aresetn",dsize:"#{strs}.dsize")
        @@_str_cp_id += 1
        a
    end

    def gen_origin_draw
""
    end

    def self.master_empty(*ms)
        ms.each do |e|
            # puts e
            self.axis_master_empty(master:e)
        end
    end

    def self.slaver_empty(*ss)
        ss.each do |e|
            self.axis_slaver_empty(slaver:e)
        end
    end

    ## ---- new --------------

    def self.leave_slaver_empty(*ms)
        ms.each do |e|
            # puts e
            self.axis_master_empty(master:e)
        end
    end

    def self.leave_master_empty(*ss)
        ss.each do |e|
            self.axis_slaver_empty(slaver:e)
        end
    end
    ## =======================
    def self.leave_empty(curr_type: :master,dsize:8,clock:"",reset:"",belong_to_module:nil)
        nc = belong_to_module.Def.axi_stream(name:"empty_#{belong_to_module.AxiStream_NC.signal}",dsize:dsize,clock:clock,reset:reset)
        # puts belong_to_module.module_name
        if curr_type.to_sym == :slaver
            self.axis_master_empty(master:nc)
        elsif curr_type.to_sym == :master
            self.axis_slaver_empty(slaver:nc)
        else
            raise TdlError.new("\n\n Axi Stream don't has this type << #{type} >> \n\n")
        end

        return nc
    end


### parse text for autogen method and constant ###

Synth_REP = /\(\*\s+axi_stream\s*=\s*"true"\s+\*\)/

    def self.parse_ports(port_array=nil)
        rep = /(?<up_down>\(\*\s+(?<ud_name>axis_up|axis_down|up_stream|down_stream)\s*=\s*"true"\s+\*\))?\s*(axi_stream_inf\.)(?<modport>master|slaver|mirror|out_mirror)\s+(?<name>\w+)\s*(?<vector>\[.*?\])?/m
        up_stream_rep = Regexp.union(/axis_up/,/up_stream/)

        super(port_array,rep,"axi_stream_inf",up_stream_rep) do |h|
            h[:type]   = AxiStream
            # puts h
            yield h
        end
    end

    ## ----- Design Ref -------------------------

    def last(latency:0)
        lat = %Q{
//----->> #{signal} LAST DELAY <<------------------
logic       #{signal}_last_Q;

latency #(
    .LAT    (#{latency}),
    .DSIZE  (1)
)#{signal}_last_lat(
    #{signal}.aclk,
    #{signal}.aresetn,
    (#{signal}.axis_tvalid && #{signal}.axis_tready && #{signal}.axis_tlast),
    #{signal}_last_Q
);
//-----<< #{signal} LAST DELAY >>------------------
}

        if latency > 0
            # GlobalParam.CurrTdlModule.BindEleClassVars.AxiStream.pre_inst << lambda { lat }
            belong_to_module.AxiStream_draw << lat
            return "#{signal}_last_Q"
        else
            return "(#{signal}.axis_tvalid && #{signal}.axis_tready && #{signal}.axis_tlast)"
        end
    end
end


class AxiStream     # add []


    def seq(start,lr)  #lr must larger than zero, START : START+lr-1
        RedefOpertor.with_old_operators do
            @__seq_start_ ||= 1024
            @__seq_end_ ||= 0
            @__seq_start_ = start if @__seq_start_ > start
            @__seq_end_ = (start+lr) if (@__seq_end_ < (start+lr))

            unless @_sub_sel_value
                ## dsize < 0 [0:X-1]
                if @dsize.is_a? Numeric
                    @_sub_sel_value = belong_to_module.Def.logic(name:"#{signal(square:false)}_seq_value",dsize: -@dsize*(@__seq_end_-@__seq_start_),msb_high:false,port: :origin)
                    @_full_sub_sel_value = belong_to_module.Def.logic(name:"#{signal(square:false)}_full_seq_value",dsize: -@dsize*(@__seq_end_-0),msb_high:false,port: :origin)
                else
                    @_sub_sel_value = belong_to_module.Def.logic(name:"#{signal(square:false)}_seq_value",dsize: "#{@dsize}*#{(@__seq_end_-@__seq_start_)}",msb_high:false,port: :origin)
                    @_full_sub_sel_value = belong_to_module.Def.logic(name:"#{signal(square:false)}_full_seq_value",dsize: "#{@dsize}*#{(@__seq_end_-0)}",msb_high:false,port: :origin)
                    @_sub_sel_value.force_nege_index(true)
                    @_full_sub_sel_value.force_nege_index(true)
                end
            else
                if @dsize.is_a? Numeric
                    @_sub_sel_value.dsize = -@dsize*(@__seq_end_-@__seq_start_)
                    @_full_sub_sel_value.dsize = -@dsize*(@__seq_end_-0)
                else
                    @_sub_sel_value.dsize = "#{@dsize}*#{(@__seq_end_-@__seq_start_)}"
                    @_full_sub_sel_value.dsize = "#{@dsize}*#{(@__seq_end_-0)}"
                end
            end

            belong_to_module.AxiStream_pre_inst_stack << Proc.new do
                if @dsize.is_a? Numeric
                    belong_to_module.Assign do
                        @_full_sub_sel_value[@__seq_start_*@dsize,@__seq_end_*@dsize-1] <= @_sub_sel_value
                    end
                else
                    belong_to_module.Assign do
                        "#{@_full_sub_sel_value.signal(square:false)}[#{@__seq_start_}*#{self.DSIZE}:#{@__seq_end_}*#{self.DSIZE}-1]".to_nq <= @_sub_sel_value
                    end
                end
                ""
            end

            @_sub_sel_out_vld ||= belong_to_module.Def.logic(name:"#{signal(square:false)}_seq_vld",dsize:1,port: :origin)

            # unless seq_vld()
                self.define_singleton_method(:seq_vld) do
                    @_sub_sel_out_vld
                end
            # end

            unless @_seq_call_
                @_p_cm_tb_m = copy(name:"cm_tb_m_#{@name}")

                self.define_singleton_method(:seq_tail_stream) do
                    @_called_seq_tail_stream = true
                    @_p_cm_tb_m
                end

                self.define_singleton_method(:seq_vld_rdy_last) do
                    @_p_cm_tb_m.vld_rdy_last
                end
                @_vcs_self_cpt_ = self.vcs_comptable(origin: 'slaver',to: 'mirror')
                @_seq_call_ = lambda {

                    if @__seq_start_ == 0
                        enable = "1'b1"
                    else
                        enable = "(#{signal}.axis_tcnt >= #{@__seq_start_})"
                    end

                    AxiStream.parse_big_field_table_a2(
                        dsize:  @dsize,
                        field_len:@__seq_end_ - @__seq_start_ ,
                        try_parse:"OFF",
                        enable:enable,
                        value:@_sub_sel_value.signal(square:false),
                        out_valid:@_sub_sel_out_vld,
                        cm_tb_s:self,
                        cm_tb_m:@_p_cm_tb_m,
                        cm_mirror: @_vcs_self_cpt_,
                        belong_to_module:belong_to_module
                    )
                    AxiStream.slaver_empty(@_p_cm_tb_m) unless @_called_seq_tail_stream
                }
                belong_to_module.AxiStream_pre_inst_stack << @_seq_call_
            end

        end
        if @dsize.is_a? Numeric
            return @_full_sub_sel_value[start*@dsize,(start+lr)*@dsize-1]
        else
            return "#{@_full_sub_sel_value.signal(square:false)}[#{start}*#{self.DSIZE}:#{(start+lr)}*#{self.DSIZE}-1]".to_nq
        end
    end

    def mirror_seq(start,lr) #lr must larger than zero, START : START+lr-1
        RedefOpertor.with_old_operators do
            @__mirror_seq_start_ ||= 1024
            @__mirror_seq_end_ ||= 0
            @__mirror_seq_start_ = start if @__mirror_seq_start_ > start
            @__mirror_seq_end_ = (start+lr) if (@__mirror_seq_end_ < (start+lr))

            unless @_sub_mirror_seq_value
                @_sub_mirror_seq_value = belong_to_module.Def.logic(name:"#{signal(square:false)}_seq_value",dsize: -@dsize*(@__mirror_seq_end_-@__mirror_seq_start_),msb_high:false,port: :origin)
            end

            @_sub_mirror_seq_value.dsize = -@dsize*(@__mirror_seq_end_-@__mirror_seq_start_)

            if @__mirror_seq_start_ > 0
                # @_sub_mirror_seq_value.send(:define_singleton_method,:inst) do
                @_sub_mirror_seq_value.instance_variable_set("@__mirror_seq_start_",@__mirror_seq_start_*@dsize)
                @_sub_mirror_seq_value.instance_variable_set("@__signal_name_",signal(square:false)+"_seq_value")
                @_sub_mirror_seq_value.define_singleton_method(:inst) do
                    # puts @__mirror_seq_start_,@dsize
                    "logic [#{@__mirror_seq_start_}:#{(@dsize.abs-1)+@__mirror_seq_start_}] #{@__signal_name_};\n"
                end
            end

            unless @_sub_mirror_seq_out_vld
                @_sub_mirror_seq_out_vld = belong_to_module.Def.logic(name:"#{signal(square:false)}_seq_vld",dsize:1,port: :origin)
            end

            unless @_mirror_seq_call_
                @_mirror_seq_call_ = lambda {

                    if @__mirror_seq_start_ == 0
                        enable = "1'b1"
                    else
                        enable = "(#{signal}.axis_tcnt >= #{@__mirror_seq_start_})"
                    end

                    @_mirror_p_cm_tb_m = copy(name:"cm_tb_m")

                    AxiStream.parse_big_field_table_a2(
                        dsize:  @dsize,
                        field_len:@__mirror_seq_end_ - @__mirror_seq_start_ ,
                        try_parse:"ON",
                        enable:enable,
                        value:@_sub_mirror_seq_value.signal(square:false),
                        out_valid:@_sub_mirror_seq_out_vld,
                        cm_tb_s:self,
                        cm_tb_m:@_mirror_p_cm_tb_m,
                        cm_mirror:self)
                }
                # Tdl.module_stack << @_mirror_seq_call_
                belong_to_module.AxiStream_pre_inst_stack << @_mirror_seq_call_
            end

        end

        return "#{@_sub_mirror_seq_value[start*@dsize,(start+lr)*@dsize-1]}"
    end

    private
        def square_inst
            # value = Logic.new(name:"value",dsize:@dsize*@_p_cut)
            # out_valid = Logic.new(name:"out_valid",dsize:1)
            # puts @@inst_stack.length.to_s+"pre"
            # cm_tb_s = copy(name:"cm_tb_s")
            # cm_tb_s = AxiStream.new(name:"-----",dsize:8,clock:Clock::NC,reset:Reset::NC)
            # puts cm_tb_s.inst
            # puts cm_tb_m.inst
            # puts @@inst_stack.length.to_s+"post"
            if @_p_min == 0
                enable = "1'b1"
            else
                enable = "(#{signal}.axis_tcnt >= #{@_p_min})"
            end
            # cm_mirror = self.copy()
            AxiStream.parse_big_field_table(field_len:@_p_cut,try_parse:@_p_try_parse,enable:enable,value:@_sub_sel_value.signal(square:false),out_valid:@_sub_sel_out_vld,cm_tb_s:self,cm_tb_m:@_p_cm_tb_m,cm_mirror:self)
            @_p_square.map { |e| e.call }.join("\n") + "\n"
        end

    public

        def mirror_to(axis)
            a = "\n//--->> #{signal} MIRROR <<-----------------------\n"
            a +="assign #{axis.signal}.axis_tvalid  = #{signal}.axis_tvalid;\n"
            a +="assign #{axis.signal}.axis_tdata   = #{signal}.axis_tdata ;\n"
            a +="assign #{axis.signal}.axis_tlast   = #{signal}.axis_tlast ;\n"
            a +="assign #{axis.signal}.axis_tready  = #{signal}.axis_tready;\n"

            a +="assign #{axis.signal}.axis_tuser   = #{signal}.axis_tuser;\n"
            a +="assign #{axis.signal}.axis_tkeep   = #{signal}.axis_tkeep;\n"
            a += "//---<< #{signal} MIRROR >>-----------------------\n"

            # GlobalParam.CurrTdlModule.BindEleClassVars.AxiStream.draw_stack << lambda{ a }
            belong_to_module.AxiStream_draw << a
            ""
        end

end

class AxiStream # + * / =

    def +(other_stream)
        raise TdlError.new("#{other_stream} is not a AxiStream") unless other_stream.is_a? AxiStream
        master_stream = self.copy(name:"#{name}_scaler_m00")
        # AxiStream.axi_streams_scaler(mode:"HEAD",cut_or_combin_body:"OFF",dsize:@dsize,new_body_len:"16'hFFFF",head_inf:self,body_inf:other_stream,end_inf:self.copy(name:"tmp"),m00:master_stream)
        AxiStream.axi_streams_scaler_a1(mode:"HEAD",cut_or_combin_body:"OFF",new_body_len:"16'hFFFF",head_inf:self,body_inf:other_stream,end_inf:self.copy(name:"tmp"),m00:master_stream)
        return master_stream
    end

    def *(num)
        raise TdlError.new("#{num} is not a Integer") unless num.is_a? Integer
        div_mul(num,"*")
    end

    def /(num)
        raise TdlError.new("#{num} is not a Integer") unless num.is_a? Integer
        div_mul(num,"/")
    end

    def |(down_stream) # pipe
        raise TdlError.new("#{down_stream} is not a AxiStream") unless down_stream.is_a? AxiStream
        raise TdlError.new("PIPE '|' axi stream dsize dont eql !!! \n") if down_stream.dsize != @dsize
        AxiStream.axis_connect_pipe(dsize:@dsize,up_stream:self,down_stream:down_stream)
        return down_stream
    end

    def %(plength)
        raise TdlError.new("#{plength} is not a Integer") unless plength.is_a? Integer

        down_stream = self.copy(name:"partition")
        AxiStream.axi_stream_partition(valve:"1'b1",partition_len:plength,req_new_len:"",up_stream:self,down_stream:down_stream)

        return down_stream
    end

    # def _=(up_stream)
    #     raise TdlError.new("#{up_stream} is not a AxiStream") unless up_stream.is_a? AxiStream
    #
    #     AxiStream.axis_direct(up_stream:up_stream,down_stream:self)
    #
    #     return self
    # end



    private

    def div_mul(num,m="*")
        # raise TdlError.new("#{num} is not a Fixnum") unless num.is_a? Integer

        stream = self.copy(name:"width_convert",dsize:(m=="*"? @dsize*num : @dsize/num) )

        str = %Q{
width_convert #(
    .ISIZE      (#{@dsize}),
    .OSIZE      (#{@dsize}#{m}#{num}  )
)#{signal}_width_convert_inst(
/*  input                   */  .clock          (#{signal}.aclk            ),
/*  input                   */  .rst_n          (#{signal}.aresetn         ),
/*  input [ISIZE-1:0]       */  .wr_data        (#{signal}.axis_tdata      ),
/*  input                   */  .wr_vld         (#{signal}.axis_tvalid     ),
/*  output logic            */  .wr_ready       (#{signal}.axis_tready     ),
/*  input                   */  .wr_last        (#{signal}.axis_tlast      ),
/*  input                   */  .wr_align_last  (1'b0 ),      //can be leave 1'b0
/*  output logic[OSIZE-1:0] */  .rd_data        (#{stream}.axis_tdata  ),
/*  output logic            */  .rd_vld         (#{stream}.axis_tvalid ),
/*  input                   */  .rd_ready       (#{stream}.axis_tready ),
/*  output                  */  .rd_last        (#{stream}.axis_tlast  )
);
        }

        # GlobalParam.CurrTdlModule.BindEleClassVars.AxiStream.pre_inst  << lambda { str }
        belong_to_module.AxiStream_draw << str

        return stream
    end

end

class AxiStream
    # alias_method :direct,:axis_direct
    # @@pre_inst << lambda {
    #     alias_method :direct,:axis_direct
    #     return ""
    # }

    def direct(slaver:"slaver",master:"master",up_stream:nil,down_stream:nil)
        axis_direct(slaver:slaver,master:master,up_stream:up_stream,down_stream:down_stream)
    end

    def self.direct(slaver:"slaver",master:"master",up_stream:nil,down_stream:nil,belong_to_module:nil)
        self.axis_direct(slaver:slaver,master:master,up_stream:up_stream,down_stream:down_stream,belong_to_module:belong_to_module)
    end

end

class AxiStream ## signals in interface

    def __inf_signal__(name)
        raise TdlError.new("\nARRAY Don't have '#{name}'\n") unless @dimension.empty?
        # puts "--------------"
        # puts $new_m.instance_variable_get("@port_axisinfs")
        # puts "============="
        NqString.new(signal.concat ".#{name}")
        # signal.concat ".#{name}"
    end

    array_signals = %W{axis_tvalid axis_tready axis_tlast axis_tcnt axis_tuser axis_tkeep DSIZE KSIZE}

    def aclk(n=0)
        if @clock.is_a? Clock
            @clock
        else
            if dimension.empty?
                NqString.new(signal.concat ".aclk")
            else
                NqString.new(signal(n).concat ".aclk")
            end
        end
    end

    def aresetn(n=0)
        if @reset.is_a? Reset
            @reset
        else
            if dimension.empty?
                NqString.new(signal.concat ".aresetn")
            else
                NqString.new(signal(n).concat ".aresetn")
            end
        end
    end

    array_signals.each do |item|
        define_method(item) do
            __inf_signal__(item)
        end
    end

    def vld_rdy
        axis_tvalid.concat(" && ").concat(axis_tready)
    end

    def vld_rdy_last
        axis_tvalid.concat(" && ").concat(axis_tready).concat(" && ").concat(axis_tlast)
    end

    def axis_tdata(h=nil,l=nil)
        raise TdlError.new("\nARRAY Don't have 'axis_tdata'") unless @dimension.empty?

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
        NqString.new(signal.concat(".axis_tdata").concat(sqr))
    end
end

class AxiStream

    def self.aclk(obj)
        if(obj.is_a? AxiStream)
            obj.aclk
        elsif obj.is_a? String
            NqString.new(obj.concat ".aclk")
        end
    end

    def self.aresetn(obj)
        if(obj.is_a? AxiStream)
            obj.aresetn
        elsif obj.is_a? String
            NqString.new(obj.concat ".aresetn")
        end
    end

    class << self
        array_signals = %W{ axis_tvalid axis_tready axis_tlast axis_tcnt axis_tuser axis_tkeep DSIZE KSIZE FreqM}
        array_signals.each do |item|
            define_method(item) do |obj|
                if(obj.is_a? AxiStream)
                    obj.send(item)
                elsif obj.is_a? String
                    NqString.new(obj.concat ".#{item}")
                end
            end
        end
    end

    def self.copy(obj)
        if obj.is_a? AxiStream
            obj.copy
        elsif obj.is_a? String
            AxiStream.new(name:"copy_#{obj}",clock:AxiStream.aclk(obj),reset:AxiStream.aresetn(obj),dsize:AxiStream.DSIZE(obj))
        end
    end

end

## 添加 兼容 VCS 的 方法

class AxiStream

    def vcs_comptable(origin: 'master',to: 'slaver')

        if belong_to_module.respond_to? "#{@name}_#{origin}_to_#{to}"
            return belong_to_module.send("#{@name}_#{origin}_to_#{to}").name.to_nq
        end
        ''' 返回字符串'''
        # idm = belong_to_module.instance_variable_get("@_include_define_macro_")
        # unless idm
        #     unless belong_to_module.ex_up_code
        #         belong_to_module.ex_up_code = '`include "define_macro.sv"'+"\n"
        #     else 
        #         belong_to_module.ex_up_code += "`include \"define_macro.sv\"\n"
        #     end 
        #     belong_to_module.instance_variable_set("@_include_define_macro_",true)
        # end

        # str  = "\n`VCS_AXIS_CPT(#{@name},#{origin},#{to})\n"
        # belong_to_module.AxiStream_draw << str
        # @_vcs_cpt_ =  "`#{@name}_vcs_cpt".to_nq
        # return @_vcs_cpt_
        belong_to_module.instance_exec(self,origin,to) do |origin_inf,origin_modport,to_modport|
            Instance(:vcs_axis_comptable,"vcs_axis_comptable_#{origin_inf.name}_#{origin_modport}_#{to_modport}_inst") do |h|
                h[:ORIGIN]  = origin_modport
                h[:TO]      = to_modport
                h[:origin]  = origin_inf
                h[:to]      = origin_inf.copy(name: "#{origin_inf.name}_#{origin_modport}_to_#{to_modport}")
            end
        end

        return belong_to_module.send("#{@name}_#{origin}_to_#{to}").name.to_nq
    end
end

## add clock_reset_taps
class AxiStream 

    def clock_reset_taps(def_clock_name,def_reset_name)

        super(def_clock_name,def_reset_name,self.aclk,self.aresetn)
    end

end
