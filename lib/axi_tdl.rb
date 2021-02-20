require "axi_tdl/version"
require "tdl/tdl.rb"

module AxiTdl
    AXI_PATH = File.expand_path(File.join(__dir__,"axi"))
    TDL_PATH = File.expand_path(File.join(__dir__,"tdl"))
end
