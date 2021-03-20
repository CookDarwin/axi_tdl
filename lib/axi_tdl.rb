require "axi_tdl/version"
require "tdl/tdl.rb"

module AxiTdl
    AXI_PATH = File.expand_path(File.join(__dir__,"axi"))
    TDL_PATH = File.expand_path(File.join(__dir__,"tdl"))
end


add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/AXI_stream"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/AXI_stream/data_width"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/AXI_stream/stream_cache"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/AXI_stream/packet_fifo"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/AXI4"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/AXI4/axi4_pipe"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/AXI4/interconnect"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/AXI4/width_convert"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/AXI4/packet_partition"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/common_fifo"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/common"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/data_interface")) 
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/data_interface/data_inf_c"))
add_to_tdl_paths    File.expand_path(File.join(__dir__, "axi/techbench"))

## base require 
require_hdl 'axis_master_empty.sv'
require_hdl 'axis_slaver_empty.sv'

