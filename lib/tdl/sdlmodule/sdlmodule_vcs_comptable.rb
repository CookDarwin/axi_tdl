module VCSCompatable

    def self.auto_vcs_cpt_connect(inst_modport,cn_modport)
        sdlmodule = cn_modport.belong_to_module
        common_modport_pair_check(inst_modport,cn_modport)
        # puts inst_modport.class
        # case inst_modport.class
        if inst_modport.is_a? Axi4 
            # puts "Match AXI4"
            axi4_instance(sdlmodule,inst_modport,cn_modport)
        elsif inst_modport.is_a? AxiStream
            # puts "Match AXIS"
            axis_instance(sdlmodule,inst_modport,cn_modport)
        elsif inst_modport.is_a?  DataInf_C
            # puts "Match DataInf_C"
            data_inf_c_instance(sdlmodule,inst_modport,cn_modport)
        else 
            cn_modport
        end

    end

    ## ??? 并不是什么类型的都能兼容连接， ......

    #分class类型 给端口排序
    # def self.common_reorder(list,ainf_modport,binf_modport,error_flag)
    #     ''' return Switch,reorder_list'''
    #     order_list = []
    #     index  = 0
    #     list.each do |le|
    #         le.each do |e|
    #             order_list << [e,index]
    #         end
    #         index += 1
    #     end

    #     ## 从 order list 中选出
    #     sel_list = order_list.select { |e| e[0]==ainf_modport.port || e[0]==binf_modport.port }
    #     ## 如果 级别一样就报错
    #     if sel_list[0][1] == sel_list[1][1]
    #         raise TdlError.new("#{error_flag} modport assign ERROR [#{ainf_modport}] <=> [#{binf_modport}]")
    #     end

    #     if sel_list[0][1] == ainf_modport
    #         return false,[ainf_modport,binf_modport]
    #     else 
    #         return false,[binf_modport,ainf_modport]
    #     end
    # end

    # def self.axi4_reorder(ainf_modport,binf_modport)
    #     ''' return Switch,reorder_list'''
    #     list = [
    #         ['master','slaver','lite_master','lite_slaver'],
    #         ['master_wr','master_rd','slaver_wr','slaver_rd'],
    #         ['master_wr_aux','master_rd_aux'],
    #         ['master_wr_aux_no_resp'],
    #         ['mirror'],
    #         ['mirror_wr','mirror_rd']
    #     ]

    #     common_reorder(list,ainf_modport,binf_modport,'AXI4')
    # end

    # def self.axis_reorder(ainf_modport,binf_modport)
    #     ''' return Switch,reorder_list'''
    #     list = [
    #         ['master','slaver'],
    #         ['mirror','out_mirror']
    #     ]
    #     common_reorder(list,ainf_modport,binf_modport,'AXIS')
    # end

    # def self.datac_reorder(ainf_modport,binf_modport)
    #     ''' return Switch,reorder_list'''
    #     list = [
    #         ['master','slaver'],
    #         ['mirror','out_mirror']
    #     ]
    #     common_reorder(list,ainf_modport,binf_modport,'DATA_INF_C')
    # end

    def self.common_instance(sdlmodule,inst_name,inst_modport,cn_modport)
        vcs_cpt_inf = cn_modport.inherited(name: "#{cn_modport.name}_vcs_cp_#{globle_random_name_flag()}")
        if vcs_cpt_inf.is_a? Axi4 
            # vcs_cpt_inf.origin_freqM   = cn_modport.FreqM
            vcs_cpt_inf.addr_step = cn_modport.ADDR_STEP 
            vcs_cpt_inf.mode = cn_modport.MODE 
        end
    
        if inst_modport.modport_type.to_s =~ /master/ || inst_modport.modport_type.to_s == "out_mirror"
            # puts "+++++++ Match Master ModPort ++++++ #{sdlmodule.module_name}"
            sdlmodule.Instance(inst_name,"#{inst_name}_#{inst_modport.name}_#{globle_random_name_flag()}_#{cn_modport.name}_inst") do |h|
                h[:ORIGIN]  = "#{inst_modport.modport_type}"
                h[:TO]      = "#{cn_modport.modport_type}" 
                h[:origin]  = vcs_cpt_inf
                h[:to]      = cn_modport
            end
        elsif inst_modport.modport_type.to_s =~ /slaver/ || inst_modport.modport_type.to_s =~ /mirror/
            # puts "+++++++ Match Slaver ModPort ++++++"
            sdlmodule.Instance(inst_name,"#{inst_name}_#{inst_modport.name}_#{globle_random_name_flag()}_#{cn_modport.name}_inst") do |h|
                h[:TO]      = "#{inst_modport.modport_type}"
                h[:ORIGIN]  = "#{cn_modport.modport_type}" 
                h[:to]      = vcs_cpt_inf
                h[:origin]  = cn_modport
            end
        else 
            # puts "+++++++ Dont Match ModPort ++++++"
            return cn_modport
        end

        return vcs_cpt_inf
    end

    def self.axi4_instance(sdlmodule,inst_modport,cn_modport)
        common_instance(sdlmodule,"vcs_axi4_comptable",inst_modport,cn_modport)
    end

    def self.axis_instance(sdlmodule,inst_modport,cn_modport)
        common_instance(sdlmodule,"vcs_axis_comptable",inst_modport,cn_modport)
    end

    def self.data_inf_c_instance(sdlmodule,inst_modport,cn_modport)
        common_instance(sdlmodule,"vcs_data_c_comptable",inst_modport,cn_modport)
    end

    def self.common_modport_pair_check(inst_modport,cn_modport)
        if inst_modport.modport_type.to_s =~ /master/
            if cn_modport.modport_type.to_s !~ /master/ && cn_modport.modport_type.to_s !~ /mirror/
                raise TdlError.new("modport assign ERROR [#{inst_modport}] <=> [#{cn_modport}]")
            end 
        end 

        if inst_modport.modport_type.to_s =~ /slaver/
            if cn_modport.modport_type.to_s !~ /slaver/ && cn_modport.modport_type.to_s !~ /mirror/
                raise TdlError.new("modport assign ERROR [#{inst_modport}] <=> [#{cn_modport}]")
            end 
        end 
    end
end