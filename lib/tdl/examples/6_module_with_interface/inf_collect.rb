require_relative '../../tdl.rb'

TdlBuild.inf_collect(__dir__) do 
    ## data_c interface
    port.data_inf_c.master          - 'dim'
    port.data_inf_c.slaver          - 'dis'
    port.data_inf_c.mirror          - 'dirr'
    ## axi stream interface
    port.axi_stream_inf.master[4]   - 'asim'
    port.axi_stream_inf.slaver      - 'asis'
    ## axi lite 
    port.axi_lite_inf.master        - 'alm'
    ## axi4 interface 
    port.axi_inf.master                - 'a4m'
    port.axi_inf.slaver[3]             - 'a4s'


    ##  data_inf_c 
    data_inf_c(clock: dim.clock,reset: dim.clock, dsize:8, freqM: 101)          - 'a_inf'
    data_inf_c(clock: dim.clock,reset: dim.clock, dsize:8, freqM: 101)[8]       - 'c_inf'
    ## axi_stream 
    axi_stream_inf(dsize: 8,clock: asis.aclk, reset: asis.aresetn )         - "f_inf"
    axi_stream_inf(dsize: 8,clock: asis.aclk, reset: asis.aresetn )         - "p_inf"
    axi_stream_inf(dsize: 8,clock: asis.aclk, reset: asis.aresetn )[2]      - "g_inf"
    ## axilite 
    axi_lite_inf(dsize: 32,asize: 32, freqM: 103,clock: alm.axi_aclk, reset: alm.axi_aresetn) - "h_inf"
    ## axi4 
    axi_inf(
        idsize: 3,
        lsize: 10,
        dsize: 32,
        asize: 32,
        addr_step: 4096,
        mode: Axi4::BOTH,
        freqM: 103,clock: a4m.axi_aclk,
        reset: a4m.axi_aresetn ) - "i_inf"

    axi_inf(
        idsize: 3,
        lsize: 12,
        dsize: 31,
        asize: 37,
        addr_step: 1024,
        mode: Axi4::BOTH,
        freqM: 103,clock: a4m.axi_aclk,
        reset: a4m.axi_aresetn)[9][5][3] - "j_inf"


    

    f_inf.collect_vector( g_inf )

    p_inf << asis
end