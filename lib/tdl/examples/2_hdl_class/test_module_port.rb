require_relative '../../tdl.rb'

TdlBuild.test_module_port_sub do 

    # port.data_inf.slaver                    - 'test_data_inf'
    # port.data_inf_c.slaver                  - 'test_data_inf_c'

    # port.data_inf.mirror                    - 'test_mirror_data_inf'
    # port.data_inf_c.mirror                  - 'test_mirror_data_inf_c'
    port.axi4.master                        - 'test_axi4'
end

TdlBuild.test_module_port(File.join(__dir__,"tmp")) do 
    ## 定义 Port
    port.axis.slaver(dsize: 8)              - 'from_ethernet_udp_stream'
    port.axi_stream_inf.master                        - 'to_ethernet_udp_stream'
    port.axi4.master(dsize: 128,idsize: 5)  - 'ddr_dma_inf'
    # puts port.data_inf.method(:slaver).source_location
    port.data_inf.slaver                    - 'test_data_inf'
    port.data_inf_c.slaver                  - 'test_data_inf_c'

    test_data_inf_c.inherited(name: "inherited_inf")

    # output.logic                            - 'valid'

    # input[4][32]    - 'test_input'

    
    # port.axis.slaver(dsize: 8)              - 'from_ethernet_udp_stream'

    ### ------------------------------------ ##
    # port.data_inf
    ## 返回 TdlSpace::DefPortEleBaseArrayChain

    # port.data_inf.slaver
    ## 调用 TdlSpace::DefPortEleBaseArrayChain method_missing

    test_module_port_sub.test_module_port_sub_inst do |h|
        # puts h.port.data_inf.slaver.test_data_inf.
        # h.port.data_inf.slaver.test_data_inf            test_data_inf
        # h.port.data_inf_c.slaver.test_data_inf_c        test_data_inf_c
        # h.port.data_inf.mirror.test_mirror_data_inf     test_data_inf
        # h.port.data_inf_c.mirror.test_mirror_data_inf_c test_data_inf_c
        h.port.axi4.master.test_axi4                    ddr_dma_inf
    end

end