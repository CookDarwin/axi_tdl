
class Axi4

    def to_iillegal_bfm
        bfm = Axi4IllegalBFM.new(name:"#{@name}_bfm",clock:@clock,reset:@reset,dsize:@dsize,idsize:@idsize,asize:@asize,lsize:@lsize,mode:@mode,port:false,addr_step: @addr_step,dimension: @dimension)
        bfm.belong_to_module = belong_to_module
        bfm.belong_to_module.var_common(bfm)
        belong_to_module.Axi4_inst  << bfm.inst
        self << bfm
        return bfm
    end
end
$__AXI_ILL_BFM_IMPORT__ = nil
class Axi4IllegalBFM < Axi4

    private
    def import_axibfm_pkg
        unless $__AXI_ILL_BFM_IMPORT__
            import_str = "import AxiIllegalBfmPkg::*;\n"
            belong_to_module.ex_up_code = import_str.concat belong_to_module.ex_up_code.to_s
            $__AXI_ILL_BFM_IMPORT__ = true
        end
    end

    public
    def masterbfm(info:true,wdata_name:"wdata_queue",&block)
        import_axibfm_pkg
        @wdata_name = wdata_name
        @_init_tap_cnt_ ||= 1
        @_master_draw_exec_str_ ||= []
        @_init_master_draw_exec_str_ ||= []
        # define_singleton_method(:wdata_queue) do
        #     "wdata_queue"
        # end

        yield self

        if info
            info_str = "ON"
        else
            info_str = "OFF"
        end
        belong_to_module.Axi4_draw << masterbfm_draw(info:info_str)

        return self
    end

    # def self.MasterBFM()
    #
    # end

    def masterbfm_draw(info:"OFF")
        init_str = @_init_master_draw_exec_str_.join("")
        master_str = @_master_draw_exec_str_.join("")
    "
Axi4IllMasterBfm_c #(
    .IDSIZE    (#{@idsize}),
    .ASIZE     (#{@asize}),
    .LSIZE     (#{@lsize}),
    .DSIZE     (#{@dsize}),
    .MSG       (\"#{info}\"),
    .ADDR_STEP (#{@addr_step.to_i})
) MasterIllBfm_#{signal};

initial begin:#{signal}_MASTER_ILLEGAL_BLOCK
logic [#{@dsize}-1:0]     #{@wdata_name}     [$];
axi4_illegal_s            illegal_s;
    MasterIllBfm_#{signal} = new(#{signal});
    MasterIllBfm_#{signal}.init();
    #{init_str}
    wait(#{signal}.axi_aresetn);
    #{master_str}
end

    "
    end

    def exec(str=nil)
        if block_given?
            ystr = yield(self)
            str = str.to_s + ystr
        end
        @_master_draw_exec_str_ << init_tap_draw("#{str.to_s};\n")
    end

    def init_exec(str)
        @_init_master_draw_exec_str_ ||= []
        @_init_master_draw_exec_str_ << init_tap_draw("#{str.to_s};\n")
    end

    # def stream_exec(delay:"#(10us)",str:"")
    #     @_master_draw_exec_str_ << "#(100ns) wdata_queue = #{str.to_s};\n"
    # end

    def repeat(num=nil,&block)
        if num
            @_master_draw_exec_str_ << init_tap_draw("repeat(#{num}) begin\n")
        else
            @_master_draw_exec_str_ << init_tap_draw("forever begin\n")
        end
        @_init_tap_cnt_ += 1
        yield self
        @_init_tap_cnt_ -= 1
        @_master_draw_exec_str_ << init_tap_draw("end\n")
    end

    def wait(s,edge=nil)
        if edge.nil?
            @_master_draw_exec_str_ << init_tap_draw("wait(#{align_signal(s,q_mark=false)});\n")
        elsif edge.to_s.eql? "raising"
            @_master_draw_exec_str_ << init_tap_draw("@(posedge #{align_signal(s)});\n")
        elsif edge.to_s.eql? "falling"
            @_master_draw_exec_str_ << init_tap_draw("@(negedge #{align_signal(s)});\n")
        end
    end

    def write_burst(addr:0,len:0,rate:100,aw_off:false,last_off:false,ar_off:false,offset_len:0,data: :random)
        f_to_bit = Proc.new do |v|
            if v
                1
            else
                0
            end
        end

        if data == :random
            data_str = %Q{
    for(int i = 0;i<#{len};i++)begin
        #{@wdata_name}[i] = $urandom_range(0,#{len});
    end}
         elsif data == :range
             data_str = %Q{
     for(int i = 0;i<#{len};i++)begin
         #{@wdata_name}[i] = i;
     end}
          else
              data_str = %Q{
      for(int i = 0;i<#{len};i++)begin
          #{@wdata_name}[i] = #{data.to_s};
      end}
           end

        @_master_draw_exec_str_ << %Q{
    //--->> RESET STRICT <<--------------
        illegal_s.aw_off        = #{f_to_bit.call(aw_off)};
        illegal_s.ar_off        = #{f_to_bit.call(ar_off)};
        illegal_s.last_off      = #{f_to_bit.call(last_off)};
        illegal_s.offset_len    = #{offset_len};
    //---<< RESET STRICT >>--------------
    //--->> wdata data generate <<-------
    #{data_str}
    //---<< wdata data generate >>-------
    }
        @_master_draw_exec_str_ << init_tap_draw("MasterIllBfm_#{signal}.write_burst(illegal_s,#{addr},#{len},#{rate},#{@wdata_name});\n")
    end

    def read_burst(addr:0,len:0,rate:100,aw_off:false,last_off:false,ar_off:false,offset_len:0,data: :random)
        f_to_bit = Proc.new do |v|
            if v
                1
            else
                0
            end
        end

        if data == :random
            data_str = %Q{
    for(int i = 0;i<#{len};i++)begin
        #{@wdata_name}[i] = $urandom_range(0,#{len});
    end}
         elsif data == :range
             data_str = %Q{
     for(int i = 0;i<#{len};i++)begin
         #{@wdata_name}[i] = i;
     end}
          else
              data_str = %Q{
      for(int i = 0;i<#{len};i++)begin
          #{@wdata_name}[i] = #{data.to_s};
      end}
           end

        @_master_draw_exec_str_ << %Q{
    //--->> RESET STRICT <<--------------
        illegal_s.aw_off        = #{f_to_bit.call(aw_off)};
        illegal_s.ar_off        = #{f_to_bit.call(ar_off)};
        illegal_s.last_off      = #{f_to_bit.call(last_off)};
        illegal_s.offset_len    = #{offset_len};
    //---<< RESET STRICT >>--------------
    //--->> rdata data generate <<-------
    #{data_str}
    //---<< rdata data generate >>-------
    }
        @_master_draw_exec_str_ << init_tap_draw("MasterIllBfm_#{signal}.read_burst(#{addr},#{len},#{rate},#{@wdata_name});\n")
    end

    private

    def init_tap_draw(str)
        "#{"    "*@_init_tap_cnt_}#{str.to_s}"
    end

end
