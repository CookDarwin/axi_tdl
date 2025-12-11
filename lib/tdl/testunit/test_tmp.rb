require_relative '../tdl.rb'
sm = SdlModule.new(name: "test_new_sdl_tmp",out_sv_path: File.join(__dir__,"tmp"))
Tdl.PutsEnable = true
sm.instance_exec(self) do |ts|
    DataInf_C().slaver   :ainf,dimension:[8,6,5]
    Def().logic(name:"tmp",dsize:1,dimension:[ 2,3,4])
    
    ##  定义logic
    logic[9,2,1] - 'tmp0'
    logic - 'tmp1'
    ## 定义 data_inf_c 
    data_inf_c(clock: "dclk",reset: "drstn",dsize:8,freqM: 101) - 'a_inf'
    data_inf_c.-('b_inf',clock:"dclk",reset:"drstn",dsize:8,freqM:101 )
    data_inf_c(clock: "dclk",reset: "drstn",dsize:8,freqM: 101)[3,7,8] - 'c_inf'
    ## 定义 data_inf 
    data_inf(dsize: 6) - "d_inf"
    data_inf(dsize: 3)[9,8] - "e_inf"
    ## 定义 axi_stream 
    axi_stream_inf(dsize: 8,clock: "aclk",reset: "aresetn",freqM: 102) - "f_inf"
    axi_stream_inf(dsize: 8,clock: "aclk",reset: "aresetn",freqM: 102)[2,2] - "g_inf"
    ## 定义 axilite 
    axi_lite_inf(dsize: 32,asize: 32,mode: AxiLite::BOTH,freqM: 103,clock: "axi_aclk",reset: "axi_aresetn") - "h_inf"
    # axi_lite_inf(dsize: 32,asize: 32,mode: AxiLite::BOTH,freqM: 103,clock: "axi_aclk",reset: "axi_aresetn")[32] - "h_inf"
    ## 定义 axi4 
    axi_inf(
        idsize: 3,
        lsize: 10,
        dsize: 32,
        asize: 32,
        addr_step: 4082,
        mode: AxiLite::BOTH,
        freqM: 103,clock: "axi_aclk",
        reset: "axi_aresetn") - "i_inf"

    axi_inf(
        idsize: 3,
        lsize: 10,
        dsize: 32,
        asize: 32,
        addr_step: 4082,
        mode: AxiLite::BOTH,
        freqM: 103,clock: "axi_aclk",
        reset: "axi_aresetn")[9][5][3] - "j_inf"

end

sm.gen_sv_module