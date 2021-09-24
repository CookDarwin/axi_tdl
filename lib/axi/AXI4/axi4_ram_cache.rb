require_shdl 'axi4_dpram_cache'

TdlBuild.axi4_ram_cache(__dir__) do 
    parameter.INIT_FILE     ''
    port.axi4.slaver    - 'a_inf'

    axi4_dpram_cache.axi4_dpram_cache_inst do |h|
        h.parameter.INIT_FILE     param.INIT_FILE
        h.port.axi4.slaver.a_inf    a_inf
        h.port.axi4.slaver.b_inf    a_inf.copy(name: 'b_inf')
    end

    Assign do 
        b_inf.axi_awvalid   <= 1.b0 
        b_inf.axi_arvalid   <= 1.b0 

        b_inf.axi_wvalid    <= 1.b0 
        b_inf.axi_rready    <= 1.b1 

        b_inf.axi_bready    <= 1.b1 
    end

end