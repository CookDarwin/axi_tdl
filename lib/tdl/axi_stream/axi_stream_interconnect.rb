
class AxiStream

    attr_accessor :m2s_interconnect_addr
    attr_accessor :branch_total
    # def interconnect_addr(addr=nil)
    #     @interconnect_addr = addr
    # end
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
            # next unless e.is_a? AxiStream
            if e.is_a? AxiStream
                raise TdlError.new("AxiStream << [sub..] sub.dimension must 1") unless dimension_num(e).eql?(1)
                @interconnect_up_streams << e
                check_branch_num
            end 

            if e.is_a? TdlSpace::ArrayChain
                if e.obj.is_a? AxiStream
                    @interconnect_up_streams << e
                    check_branch_num
                end 
            end
        end
    end

    def >>(down_stream)
        down_stream.<< self
    end

    private

    def check_branch_num
        return if m2s_interconnect_addr
        @_branch_num_stack_index ||= 0
        if branch_total.is_a? Integer
            if @interconnect_up_streams.length > branch_total
                _up_stream = []
                branch_total.times do
                    _up_stream << @interconnect_up_streams.shift
                end

                new_branch = self.copy
                new_branch_cache = self.copy(name:"#{new_branch.name}_cache")
                # new_branch.instance_variable_set('@interconnect_up_streams',_up_stream)
                new_branch.<<(*_up_stream)

                # new_branch.axis_connect_pipe(down_stream:new_branch_cache)
                belong_to_module.Instance(:axis_connect_pipe,"axis_connect_pipe_inst_#{new_branch_cache.name}") do |h|
                    h.axis_in       new_branch
                    h.axis_out      new_branch_cache
                end

                @interconnect_up_streams << new_branch_cache

            end
        end
    end

    def push_to_stack
        unless @_record_inter_
            belong_to_module.ExOther_pre_inst_stack << method(:sub_inst)
            belong_to_module.ExOther_pre_inst_stack << method(:interconnect_draw)
            @_record_inter_ = true
        end
    end

    def sub_inst
        return '' if @interconnect_up_streams.empty?
        belong_to_module.Logic_inst << (
"
axi_stream_inf #(.DSIZE(#{name}.DSIZE))  sub_#{(name)}[#{@interconnect_up_streams.length}-1:0](.aclk(#{name}.aclk),.aresetn(#{name}.aresetn),.aclken(1'b1));\n
" + sub_direct)
    end

    def interconnect_draw
        if @interconnect_up_streams.length == 1
            belong_to_module.ExOther_draw << (
"\naxis_direct  axis_direct_#{name}_instMM (
/*  axi_stream_inf.slaver*/ .slaver (sub_#{(name)}[0]),
/*  axi_stream_inf.master*/ .master (#{name})
);\n")
        elsif @m2s_interconnect_addr
            belong_to_module.ExOther_draw << addr_interconnect_draw()
        else
            belong_to_module.ExOther_draw << noaddr_interconnect_draw()
        end
    end

    def sub_direct
        str = ""
        for i in 0...(@interconnect_up_streams.length)
            if @interconnect_up_streams[i].is_a? TdlSpace::ArrayChain
                slaver_name = @interconnect_up_streams[i]
            else  
                slaver_name = @interconnect_up_streams[i].name
            end
            str +=
"\naxis_direct  axis_direct_#{name}_inst#{i} (
/*  axi_stream_inf.slaver*/ .slaver (#{slaver_name}),
/*  axi_stream_inf.master*/ .master (sub_#{(name)}[#{i}])
);\n"
        end
        return str
    end

    def noaddr_interconnect_draw
"
axi_stream_interconnect_M2S_A1 #(
//axi_stream_interconnect_M2S_noaddr #(
    .NUM        (#{@interconnect_up_streams.length})
 //   .DSIZE      (#{dsize})
)#{name}_M2S_noaddr_inst(
/*  axi_stream_inf.slaver */ .s00      (sub_#{(name)} ), //[NUM-1:0],
/*  axi_stream_inf.master */ .m00      (#{name}) //
);
"
    end

    def addr_interconnect_draw
"
axi_stream_interconnect_M2S #(
    .NUM        (#{@interconnect_up_streams.length})
)#{name}_M2S_inst(
/*  input [NSIZE-1:0]     */ .addr     (#{align_signal(@m2s_interconnect_addr)}),
/*  axi_stream_inf.slaver */ .s00      (sub_#{(name)} ), //[NUM-1:0],
/*  axi_stream_inf.master */ .m00      (#{name}) //
);
"
    end

end

class AxiStream

    def collect_vector(axis_vector)
        num = dimension_num(axis_vector)
        if num.eql?(1)
            return self.axis_direct(up_stream:axis_vector)
        end
        belong_to_module.ExOther_inst << collect_vector_draw(num,axis_vector)
    end

    def self.collect_vector(main:nil,vector:nil)
        raise TdlError.new("AxiStream collect_vector `VECTOR` must be AxiStream Class") unless vector.is_a? AxiStream

        if main
            raise TdlError.new("AxiStream collect_vector `MAIN` must be AxiStream Class") unless main.is_a? AxiStream
        end

        main = vector.copy(dimension:[]) if main.nil?

        main.collect_vector(vector)

        return main

    end

    private

    def collect_vector_draw(num,axis_vector)
        large_name_len(
            name,
            axis_vector.name
        )
"
axi_stream_interconnect_M2S_A1 #(
//axi_stream_interconnect_M2S_noaddr #(
    .NUM        (#{num})
)#{name}_M2S_noaddr_inst(
/*  axi_stream_inf.slaver */ .s00      (#{align_signal(axis_vector)}), //[NUM-1:0],
/*  axi_stream_inf.master */ .m00      (#{name}) //
);
"
    end
end


class TdlTest

    def self.test_axi_streams_interconnect
        c0 = Clock.new(name:"clk",freqM:148.5)
        r0 = Reset.new(name:"rst_n",active:"low")
        addr = Logic.new(name:'new_body_len')

        head_inf = AxiStream.new(name:"head_inf",clock:c0,reset:r0)
        body_inf = AxiStream.new(name:"body_inf",clock:c0,reset:r0)
        end_inf = AxiStream.new(name:"end_inf",clock:c0,reset:r0)

        m00 = AxiStream.new(name:"m00",clock:c0,reset:r0)
        m00.m2s_interconnect_addr = addr
        m00.<< head_inf,body_inf,end_inf

        puts_sv Tdl.inst,Tdl.draw
    end

end

# Test.test_axi_streams_interconnect
