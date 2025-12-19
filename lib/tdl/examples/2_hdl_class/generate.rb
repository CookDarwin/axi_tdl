require_relative '../../tdl.rb'
# require_relative '/home/CookDarwin/work/FPGA/new_tdl_1211/tdl/prj_lib.rb'
## 这个测试已经过时
TdlBuild.text_generate(File.join(__dir__,"tmp")) do 
    Parameter(:NUM,8)
    Parameter(:BOARD_TOTAL,4)
    parameter.WW "OFF"

    input[32,NUM()] - 'ip_s_addr'
    input[32,NUM()] - 'ip_d_addr'
    input[48,NUM()] - 'mac_s_addr'
    input[48,NUM()] - 'mac_d_addr'
    input[16]       - 'fpga_udp_ctrl_port'
    input[16]       - 'fpga_udp_data_port'
    input[16]       - 'fpga_udp_dire_port'
    port.axis.slaver(dsize:64)    - 'g10_axis_rx'
    port.axis.master(dsize:64)    - 'g10_axis_tx'
    port.axis.slaver(dsize:8)[2]   - 'txs_udp_8bit'
    port.axis.master(dsize:8)[BOARD_TOTAL()]   - 'rx_udp_data_8bit'
    port.axis.master(dsize:8)[BOARD_TOTAL()]   - 'rx_udp_dire_8bit'

    Assign do 
        mac_s_addr[0][0] <= mac_d_addr[0][0]
    end

    # generate(32) do  |kk|
    #     # puts param.WW.method("==").source_location
    #     IF param.WW == "ON" do 

    #     end

    # end


    generate(param.NUM,7,6) do |k0,k1,k2|
        # puts ClassHDL::AssignDefOpertor.curr_assign_block_stack
        IF(k0==2) do 
            Assign do 
                # mac_s_addr[k0][k1] <= mac_d_addr[k1][k0]
                # ip_s_addr[9,0]  <= 0.A
                # puts rx_udp_data_8bit.method('[]').source_location
                rx_udp_data_8bit[8*1,1*2] <= "90909"
            end
        end
        # ELSE do 
        #     Assign do 
        #         mac_s_addr[k0][k1] <= mac_d_addr[k1][k0]
        #     end 
        # end

        # axi_stream_cache.axi_stream_cache_inst do |h|
        #     h.axis_in   txs_udp_8bit[k0]
        #     h.axis_out  rx_udp_dire_8bit[k1]
        # end

        # axi_stream_cache.axi_stream_cache_inst0 do |h|
        #     h.axis_in   txs_udp_8bit[k1]
        #     h.axis_out  rx_udp_dire_8bit[k0]
        # end
    end

end