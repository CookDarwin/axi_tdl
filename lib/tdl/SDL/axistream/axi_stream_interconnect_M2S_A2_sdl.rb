
# add_to_all_file_paths('axi_stream_interconnect_M2S_A2','/home/CookDarwin/work/fpga/axi/AXI_stream/axi_stream_interconnect_M2S_A2.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axi_stream_interconnect_M2S_A2.sv'
TdlBuild.axi_stream_interconnect_M2S_A2 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axi_stream_interconnect_M2S_A2.sv'
self.path = File.expand_path(__FILE__)
parameter.NUM   8
parameter.DSIZE   8
parameter.KSIZE   "(DSIZE/8 > 0)? DSIZE/8 : 1"
parameter.NSIZE   "NUM <= 2? 1 :"
port.axi_stream_inf.slaver[ param.NUM] - 's00' 
port.axi_stream_inf.master - 'm00' 
end
