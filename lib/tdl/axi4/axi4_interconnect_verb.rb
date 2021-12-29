# require_relative ".././axi4"

class Parameter

    def real_data
        @value
    end
end

class Integer
    def real_data
        self
    end
end

class String

    def low_signal
        self
    end

    def high_signal
        self
    end
end

class Axi4
    # attr_accessor :freeze_min_params

    # def freeze_min_params(key)
    #     @freeze_min_params_hash ||= Hash.new
    #     @freeze_min_params_hash[key]
    # end
    #
    # def freeze_min_params=(key,value)
    #     @freeze_min_params_hash ||= Hash.new
    #     @freeze_min_params_hash[key] = value
    # end

    def interconnect_pipe=(a=false)
        @interconnect_pipe=a
    end

    def band_params_from(has)
        array_list = [:clock,:reset,:dsize,:idsize,:asize,:lsize]
        array_list.each do |e|
            if method(e).call.nil?
                self.send("#{e.to_s}=",has.send(e))
            end
        end
    end

    # def idsize=(n)
    #     @idsize = n
    #     # cal_idsize_asize
    # end

    def >>(down_stream)
        down_stream.<< self
    end

    def <<(*up_streams)
        require_shdl 'axi4_direct_algin_addr_step'
        up_streams.each do |up_stream|
            ## e is a Vector 
            if up_stream.is_a? Axi4
                if up_stream.dimension && up_stream.dimension[0].is_a?(Integer) && up_stream.dimension[0] > 1
                    self.belong_to_module.instance_exec(self,up_stream) do |curr_axi4_inst,up_stream|
                        up_stream.copy(
                            name: "#{up_stream.inst_name}_algin_addr",
                            addr_step: curr_axi4_inst.addr_step*up_stream.dsize/curr_axi4_inst.dsize,
                            dimension:up_stream.dimension)

                        generate(up_stream.dimension[0]) do |kk|   
                            Instance(:axi4_direct_algin_addr_step,"algin_addr_#{up_stream.inst_name}_#{curr_axi4_inst.name}") do |h| #(
                                h.param.SLAVER_ADDR_STEP    up_stream.addr_step
                                h.param.TERMENAL_ADDR_STEP  curr_axi4_inst.addr_step
                                h.param.TERMENAL_DSIZE      curr_axi4_inst.dsize
                                h.param.MODE            "#{up_stream.mode}_to_#{up_stream.mode}"    #//ONLY_READ to BOTH,ONLY_WRITE to BOTH,BOTH to BOTH,BOTH to ONLY_READ,BOTH to ONLY_WRITE
                                h.param.SLAVER_MODE     up_stream.mode    
                                h.param.MASTER_MODE     up_stream.mode    
                                h.port.axi_inf.slaver.slaver_inf     up_stream[kk]
                                h.port.axi_inf.master.master_inf     curr_axi4_inst.belong_to_module.signal("#{up_stream.inst_name}_algin_addr")[kk]
                            end
                        end
                        curr_axi4_inst.old_append( signal("#{up_stream.inst_name}_algin_addr") )
                    end
                else  
                    curr_axi4_inst = self
                    up_stream.copy(
                        name: "#{up_stream.inst_name}_algin_addr",
                        addr_step: curr_axi4_inst.addr_step*up_stream.dsize/curr_axi4_inst.dsize)

                    self.belong_to_module.Instance(:axi4_direct_algin_addr_step,"algin_addr_#{up_stream.inst_name}_#{name}_#{belong_to_module._auto_name_incr_index_}") do |h| #(
                        h.param.SLAVER_ADDR_STEP    up_stream.addr_step
                        h.param.TERMENAL_ADDR_STEP  curr_axi4_inst.addr_step
                        h.param.TERMENAL_DSIZE      curr_axi4_inst.dsize
                        h.param.MODE            "#{up_stream.mode}_to_#{up_stream.mode}"    #//ONLY_READ to BOTH,ONLY_WRITE to BOTH,BOTH to BOTH,BOTH to ONLY_READ,BOTH to ONLY_WRITE
                        h.param.SLAVER_MODE     up_stream.mode    
                        h.param.MASTER_MODE     up_stream.mode    
                        h.port.axi_inf.slaver.slaver_inf     up_stream
                        h.port.axi_inf.master.master_inf      self.belong_to_module.signal("#{up_stream.inst_name}_algin_addr")
                    
                    end
                    curr_axi4_inst.old_append(  self.belong_to_module.signal("#{up_stream.inst_name}_algin_addr") )
                end
            else 
                self.old_append(up_stream)
            end
        end

    end

    def old_append(*up_streams)
        @interconnect_up_streams ||= []
        push_to_stack
        up_streams.each do |e|
            # next unless e.is_a? Axi4
            if e.is_a? Axi4
                e.band_params_from(self)
                
                ## e is a Vector 
                if e.dimension && e.dimension[0].is_a?(Integer) && e.dimension[0] > 1
                    # require_hdl 'axi4_direct_B1.sv'
                    require_hdl 'axi4_direct_verc.sv'

                    e.dimension[0].times do |xi|
                        _ne = e.copy(name: "#{e.inst_name}_toM_#{xi}")
                        # _ne << e[xi]
                        # belong_to_module.Instance('axi4_direct_B1',"axi4_direc_#{e.inst_name}_toM_#{xi}") do |h|
                        #     # h.param.MODE    mode_str    #//ONLY_READ to BOTH,ONLY_WRITE to BOTH,BOTH to BOTH,BOTH to ONLY_READ,BOTH to ONLY_WRITE
                        #     h.slaver_inf        e[xi]
                        #     h.master_inf        _ne
                        # end

                        belong_to_module.Instance('axi4_direct_verc',"axi4_direc_#{e.inst_name}_toM_#{xi}") do |h|
                            h.param.MODE            "#{_ne.mode}_to_#{_ne.mode}"    # //ONLY_READ to BOTH,ONLY_WRITE to BOTH,BOTH to BOTH,BOTH to ONLY_READ,BOTH to ONLY_WRITE
                            h.param.SLAVER_MODE     _ne.mode    #    //
                            h.param.MASTER_MODE     _ne.mode    #    //
                            h.slaver_inf        e[xi]
                            h.master_inf        _ne
                        end
                
                        @interconnect_up_streams << _ne 
                    end    
                else
                    @interconnect_up_streams << e
                end
            else
                raise TdlError.new("When use `<<` for axi4's M2S ,argvs must be axi4 too.\nOtherwise use `naxi4_mix_interconnect_M2S` directly")
            end
        end
        cal_idsize_asize
        cal_addr_step
    end

    private

    def push_to_stack
        unless @_record_inter_
            belong_to_module.ExOther_pre_inst_stack << method(:cal_idsize_asize)
            belong_to_module.ExOther_pre_inst_stack << method(:cal_addr_step)
            belong_to_module.ExOther_pre_inst_stack << method(:long_slim_to_wide)
            belong_to_module.ExOther_pre_inst_stack << method(:combin_wr_rd_slaver_and_sub_list)
            belong_to_module.ExOther_pre_inst_stack << method(:sub_inst)
            belong_to_module.ExOther_pre_inst_stack << method(:interconnect_draw)
            @_record_inter_ = true
        end
    end


    def cal_idsize_asize
        root_idsize = self.idsize.real_data
        root_quanti_len  = self.dsize.real_data * (2**self.lsize.real_data)

        last_num = @interconnect_up_streams.size - [@interconnect_up_streams.select{ |e| e.mode == Axi4::ONLY_WRITE }.size,@interconnect_up_streams.select{ |e| e.mode == Axi4::ONLY_READ }.size].min
        # if(@interconnect_up_streams.size > 1)
        if(last_num > 1)
            # inter_on_lvl = 3
            inter_on_lvl = last_num.clog2
        else
            inter_on_lvl = 0
        end
        asizes = []
        hopes = @interconnect_up_streams.map do |ae|
            asizes << ae.asize.real_data
            curr_quanti_len = ae.dsize.real_data * (2**ae.lsize.real_data)
            if(curr_quanti_len > root_quanti_len )
                hope_root_idsize = ae.idsize.real_data + inter_on_lvl + 4       ## just when use partition
            else
                hope_root_idsize = ae.idsize.real_data + inter_on_lvl
            end
        end

        # if hopes.min < 2
        #     ni = hopes.min
        #     hopes = hopes.map {|e| e + (2-ni) }
        # end
        self.idsize = (hopes << self.idsize).max
        self.asize  = (asizes << self.asize).max
        @interconnect_up_streams.map do |ae|
            ae.asize = self.asize
            curr_quanti_len = ae.dsize.real_data * (2**ae.lsize.real_data)
            if(curr_quanti_len > root_quanti_len )
                ae.idsize = self.idsize - inter_on_lvl - 4  ## just when use partition
            else
                ae.idsize = self.idsize - inter_on_lvl - 0
            end
        end
    end

    def cal_addr_step
        root_step = self.addr_step
        @interconnect_up_streams.map do |ae|
            if ae.dsize.is_a?(Numeric) && root_step.is_a?(Numeric) && self.dsize.is_a?(Numeric)
                ae.addr_step = ae.dsize*root_step/self.dsize
            else
                ae.addr_step = "#{ae.dsize}*#{self.ADDR_STEP}/#{self.dsize}".to_nq
            end
        end
    end

    def long_slim_to_wide
        @_long_slim_to_wide ||=[]
        root_quanti_len  = self.dsize.real_data * (2**self.lsize.real_data)
        index = 0
        @interconnect_up_streams.each do |e|
            curr_quanti_len = e.dsize.real_data * (2**e.lsize.real_data)
            if(curr_quanti_len > root_quanti_len )
            # if(true )
                new_master = self.copy(mode:e.mode,idsize:e.idsize+4)
                new_master.mode =  e.mode

                require_hdl 'axi4_long_to_axi4_wide_B1.sv'

                TopModule.contain_hdl 'axi4_packet_fifo_verb.sv'
                TopModule.contain_hdl 'axi4_data_convert_verb.sv'
                TopModule.contain_hdl 'data_c_pipe_force_vld.sv'

                belong_to_module.Instance(:axi4_long_to_axi4_wide_B1,"axi4_long_to_axi4_wide_B1_#{index}_inst") do |h|
                    h[:PARTITION]   = "ON"
                    h[:PIPE]        = (@interconnect_pipe ? "ON" : "OFF")
                    h[:MODE]        = "#{e.mode}_TO_#{new_master.mode}"
                    h[:SLAVER_MODE] = e.mode 
                    h[:MASTER_MODE] = new_master.mode
                    h[:slaver_inf]      = e
                    h[:master_inf]      = new_master
                end
                @_long_slim_to_wide << new_master
            else
                if !(e.dsize.eql? self.dsize)
                    require_hdl 'axi4_long_to_axi4_wide_B1.sv'
                    TopModule.contain_hdl 'axi4_direct_verc.sv'
                    TopModule.contain_hdl 'axi4_packet_fifo_verb.sv'
                    TopModule.contain_hdl 'axi4_data_convert_verb.sv'
                    TopModule.contain_hdl 'data_c_pipe_force_vld.sv'
                    # puts "#{e.dsize} == #{self.dsize} #{e.dsize != self.dsize} #{e.dsize.class}"
                    new_master = self.copy(name: "#{e.name}_renew_dir",mode:e.mode,idsize:e.idsize)
                    # new_master.axi4_data_convert(up_stream: e)
                    # @_long_slim_to_wide << Axi4.axi4_pipe(up_stream:new_master)

                    # Axi4.axi4_long_to_axi4_wide_verb(slaver:e,master:new_master,partition:"OFF",pipe:(@interconnect_pipe ? "ON" : "OFF"))
                    belong_to_module.Instance(:axi4_long_to_axi4_wide_B1,"axi4_long_to_axi4_wide_B1_#{index}_inst") do |h|
                        h[:PARTITION]   = "OFF"
                        h[:PIPE]        = (@interconnect_pipe ? "ON" : "OFF")
                        h[:MODE]        = "#{e.mode}_to_#{new_master.mode}"
                        h[:SLAVER_MODE] = e.mode 
                        h[:MASTER_MODE] = new_master.mode
                        h[:slaver_inf]      = e
                        h[:master_inf]      = new_master
                    end
                    @_long_slim_to_wide << new_master

                else
                    @_long_slim_to_wide << e
                end
            end
            index += 1
        end
    end

    def combin_wr_rd_slaver_and_sub_list
        index = 0
        sub_name = "sub_axi_#{name}_inf"
        only_rd = []
        only_wr = []
        long_only = []
        short_only = []
        sub_stream = []
        @_long_slim_to_wide.each do |e|
            if(e.mode == Axi4::ONLY_READ)
                only_rd << e
            elsif e.mode == Axi4::ONLY_WRITE
                only_wr << e
            end
        end

        if only_rd.size > only_wr.size
            long_only = only_rd
            short_only = only_wr
            wr_lg = false
        else
            long_only = only_wr
            short_only = only_rd
            wr_lg = true
        end

        long_only.each do |lo|
            @_long_slim_to_wide.delete lo
            if short_only.empty?
                if wr_lg
                    mode_str = "ONLY_WRITE_to_BOTH"
                else
                    mode_str = "ONLY_READ_to_BOTH"
                end
                
                require_hdl 'axi4_direct_verc.sv'
                belong_to_module.Instance('axi4_direct_verc',"axi4_direct_a1_long_to_wide_#{sub_name}_#{belong_to_module._auto_name_incr_index_}") do |h|
                    h.param.MODE            mode_str    # //ONLY_READ to BOTH,ONLY_WRITE to BOTH,BOTH to BOTH,BOTH to ONLY_READ,BOTH to ONLY_WRITE
                    h.param.SLAVER_MODE     (wr_lg ? "ONLY_WRITE" : "ONLY_READ")    #    //
                    h.param.MASTER_MODE     "BOTH"    #    //
                    h.slaver_inf        (lo.respond_to?(:dimension) && (lo.dimension.nil? || lo.dimension[0]==1) && lo[0])  || lo
                    h.master_inf        "#{sub_name}[#{index}]".to_nq
                end

            else
                los = short_only.pop
                @_long_slim_to_wide.delete los
                require_hdl 'axi4_combin_wr_rd_batch.sv'
                if wr_lg
                    # Axi4.axi4_combin_wr_rd_batch(wr_slaver:lo,rd_slaver:los,master:"#{sub_name}[#{index}]",belong_to_module:belong_to_module)
                    belong_to_module.Instance(:axi4_combin_wr_rd_batch,"axi4_combin_wr_rd_batch_inst_#{sub_name}_#{belong_to_module._auto_name_incr_index_}") do |h|
                        h.wr_slaver         lo
                        h.rd_slaver         los
                        h.master            "#{sub_name}[#{index}]".to_nq
                    end 
                else
                    # Axi4.axi4_combin_wr_rd_batch(wr_slaver:los,rd_slaver:lo,master:"#{sub_name}[#{index}]",belong_to_module:belong_to_module)
                    belong_to_module.Instance(:axi4_combin_wr_rd_batch,"axi4_combin_wr_rd_batch_inst_#{sub_name}_#{belong_to_module._auto_name_incr_index_}") do |h|
                        h.wr_slaver         los
                        h.rd_slaver         lo
                        h.master            "#{sub_name}[#{index}]".to_nq
                    end 
                end
            end
            index += 1
        end

        @_long_slim_to_wide.each do |e|
            mode_str = e.mode + "_to_BOTH"
            # Axi4.axi4_direct_a1(mode:mode_str,slaver:e,master:"#{sub_name}[#{index}]",belong_to_module:belong_to_module)
            require_hdl 'axi4_direct_B1.sv'
            belong_to_module.Instance('axi4_direct_B1',"axi4_direct_a1_inst_long_to_wide_#{sub_name}") do |h|
                # h.param.MODE    mode_str    #//ONLY_READ to BOTH,ONLY_WRITE to BOTH,BOTH to BOTH,BOTH to ONLY_READ,BOTH to ONLY_WRITE
                h.slaver_inf        e
                h.master_inf        "#{sub_name}[#{index}]".to_nq
            end
            index = index + 1
        end
        @sub_num = index
    end

    def sub_inst
        return '' if @interconnect_up_streams.empty?
        # @sub_num = @interconnect_up_streams.size
        str =
"\naxi_inf #(
    .IDSIZE    (#{align_signal(idsize-(Math.log2(@sub_num).ceil))}),
    .ASIZE     (#{align_signal(asize)}),
    .LSIZE     (#{align_signal(lsize)}),
    .DSIZE     (#{align_signal(dsize)}),
    .MODE      (#{align_signal(mode)}),
    .ADDR_STEP (#{align_signal(self.ADDR_STEP)}),
    .FreqM     (#{align_signal(self.FreqM)})
)sub_axi_#{name}_inf[#{@sub_num}-1:0](
    .axi_aclk      (#{self.axi_aclk}),
    .axi_aresetn    (#{self.axi_aresetn})
);\n"

    # belong_to_module.ExOther_collect << str
    str.define_singleton_method("_inner_inst") do 
        str 
    end

    ec = belong_to_module.instance_variable_get("@__element_collect__") || []
    ec << str 
    belong_to_module.instance_variable_set("@__element_collect__",ec)
    str
    end

    def interconnect_draw

        if @sub_num > 1
            str =
"\naxi4_mix_interconnect_M2S #(
    .NUM    (#{@sub_num})
)interconnect_#{name}_inst(
/*  axi_inf.slaver */   .slaver     (sub_axi_#{name}_inf),    //[NUM-1:0],
/*  axi_inf.master */   .master     (#{name})
);\n"
        else
            if self.mode == BOTH
                _str = 'BOTH_to_BOTH'
            else
                _str = 'ONLY_WRITE_TO_ONLY_WRITE'
            end

            str =
"\naxi4_direct_B1 /* #(
    .MODE       (\"#{_str}\")    //ONLY_READ to BOTH,ONLY_WRITE to BOTH,BOTH to BOTH,BOTH to ONLY_READ,BOTH to ONLY_WRITE
)*/ iterconnect_direct_A1_#{name}_instMM(
/* axi_inf.slaver */  .slaver_inf   (sub_axi_#{name}_inf[0]),
/* axi_inf.master */  .master_inf   (#{name})
);\n"
        end

        belong_to_module.ExOther_inst << str

        str

    end

end
