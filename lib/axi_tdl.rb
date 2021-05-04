require "axi_tdl/version"
require "tdl/tdl.rb"

module AxiTdl
    AXI_PATH = File.expand_path(File.join(__dir__,"axi"))
    TDL_PATH = File.expand_path(File.join(__dir__,"tdl"))
    PUBLIC_ATOM_PATH = File.expand_path(File.join(__dir__,"tdl"))
end


add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/AXI_stream"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/AXI_stream/data_width"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/AXI_stream/stream_cache"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/AXI_stream/packet_fifo"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/AXI4"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/AXI4/axi4_pipe"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/AXI4/interconnect"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/AXI4/width_convert"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/AXI4/packet_fifo"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/AXI4/packet_partition"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/axi4_to_xilinx_ddr_native"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/common_fifo"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/common"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/data_interface")) 
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/data_interface/data_inf_c"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/techbench"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/platform_ip"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "public_atom_module"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "public_atom_module/sim"))
## base require 
require_hdl 'axis_master_empty.sv'
require_hdl 'axis_slaver_empty.sv'

## contain common HDL 
TopModule.contain_hdl("CheckPClock.sv","edge_generator.v","ClockSameDomain.sv","broaden_and_cross_clk.v","broaden.v","cross_clk_sync.v","latency.v","latency_long.v",'pipe_vld.sv')

### 这里引入可能不合适
TopModule.contain_hdl('axis_full_to_data_c.sv','data_c_pipe_inf.sv','data_c_to_axis_full.sv')
TopModule.contain_hdl('axi_stream_interconnect_M2S_A1.sv', 'data_c_pipe_intc_M2S_best_last.sv',"data_pipe_interconnect_S2M_verb.sv","data_valve.sv")
TopModule.contain_hdl('axis_direct_A1.sv',"axis_direct.sv")
TopModule.contain_hdl 'axi_stream_interconnect_M2S.sv','data_pipe_interconnect_M2S_verb.sv'
# TopModule.contain_hdl('simple_data_pipe.sv')
TopModule.contain_hdl('long_fifo_verb.sv',"long_fifo_4bit.sv","long_fifo_4bit_SL8192.sv","long_fifo_4bit_8192.sv","wide_fifo.sv","wide_fifo_7series.sv")

TopModule.contain_hdl 'width_combin.sv'

TopModule.contain_hdl "data_inf_A2B.sv","data_inf_B2A.sv","data_c_direct.sv"

### 兼容性引入 
require_hdl 'odata_pool_axi4_A3.sv'
require_hdl 'axis_append_A1.sv'
odata_pool_axi4_A3.contain_hdl('axi4_rd_auxiliary_gen_A1.sv',"xilinx_fifo_verb.sv","xilinx_fifo_A1.sv","fifo_36bit.sv","fifo_wr_rd_mark.sv")
axis_append_A1.contain_hdl('axi_streams_combin_A1.sv','data_c_scaler_A1.sv')

require_hdl 'axis_head_cut.sv'
axis_head_cut.contain_hdl("axis_filter.sv")


