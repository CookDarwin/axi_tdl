
class DataInf_C

    attr_accessor :m2s_interconnect_addr
    private
    def dimension_num(e)
        if e.is_a? Array
            return e.size
        else
            if e.respond_to?(:dimension) && e.dimension && e.dimension.any?
                return e.dimension.last
            else
                return 1
            end
        end
    end
    public

    def <<(*up_streams)
        @interconnect_up_streams ||= []
        push_to_stack
        up_streams.each do |e|
            next unless e.is_a? DataInf_C
                raise TdlError.new("DataInf_C << [sub..] sub.dimension must 1") unless dimension_num(e).eql?(1)
                @interconnect_up_streams << e
        end
    end

    def >>(down_stream)
        down_stream.<< self
    end

    private

    def push_to_stack
        unless @_record_inter_
            belong_to_module.ExOther_pre_inst_stack << method(:sub_inst)
            belong_to_module.ExOther_pre_inst_stack << method(:interconnect_draw)
            @_record_inter_ = true
        end
    end

    def sub_inst
        return '' if @interconnect_up_streams.empty?
        belong_to_module.ExOther_inst << (
"
data_inf_c #(.DSIZE(#{name}.DSIZE))  sub_#{(name)}[#{@interconnect_up_streams.length}-1:0](.clock(#{name}.clock),.rst_n(#{name}.rst_n));\n
" + sub_direct)
    end

    def interconnect_draw
        if @interconnect_up_streams.length == 1
            belong_to_module.ExOther_draw << (
"
data_c_direct data_c_direct_#{name}_instMM(
/*  data_inf_c.slaver  */   .slaver (sub_#{(name)}[0]),
/*  data_inf_c.master  */   .master (#{name})
);
")
        elsif @m2s_interconnect_addr
            belong_to_module.ExOther_draw << addr_interconnect_draw()
        else
            belong_to_module.ExOther_draw << noaddr_interconnect_draw()
        end
    end

    def sub_direct
        str = ""
        for i in 0...(@interconnect_up_streams.length)
            str +=
"\data_c_direct  data_c_direct_#{name}_inst#{i} (
/*  data_inf_c.slaver  */ .slaver (#{@interconnect_up_streams[i].name}),
/*  data_inf_c.master  */ .master (sub_#{(name)}[#{i}])
);\n"
        end
        return str
    end

    def noaddr_interconnect_draw
"
//data_c_pipe_intc_M2S_verc #(
data_c_pipe_intc_M2S_best_last #(
//   .PRIO   (\"BEST_ROBIN\"),   //BEST_ROBIN BEST_LAST ROBIN LAST WAIT_IDLE FORCE_ROBIN
    .NUM    (#{@interconnect_up_streams.length})
)#{name}_M2S_noaddr_inst(
/*  input [NUM-1:0]    */         .last     ({(#{@interconnect_up_streams.length}){1'b1}}),             //ctrl prio
/*  data_inf_c.slaver  */         .s00      (sub_#{(name)}),//[NUM-1:0],
/*  data_inf_c.master  */         .m00      (#{name})
);
"
    end

    def addr_interconnect_draw
        raise TdlError.new("Don't define `addr_interconnect_draw` for DataInf_C yet")
    end

end
