
# add_to_all_file_paths('axi_stream_interconnect_M2S','/home/CookDarwin/work/fpga/axi/AXI_stream/axi_stream_interconnect_M2S.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axi_stream_interconnect_M2S.sv'
TdlBuild.axi_stream_interconnect_M2S do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axi_stream_interconnect_M2S.sv'
self.path = File.expand_path(__FILE__)
parameter.NUM   8
parameter.NSIZE   "NUM <= 2? 1 :"
input[ param.NSIZE] - 'addr' 
port.axi_stream_inf.slaver[ param.NUM] - 's00' 
port.axi_stream_inf.master - 'm00' 
end
