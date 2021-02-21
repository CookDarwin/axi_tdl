
# add_to_all_file_paths('axi_stream_interconnect_S2M','/home/CookDarwin/work/fpga/axi/AXI_stream/axi_stream_interconnect_S2M.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axi_stream_interconnect_S2M.sv'
TdlBuild.axi_stream_interconnect_S2M do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axi_stream_interconnect_S2M.sv'
self.path = File.expand_path(__FILE__)
parameter.NUM   8
parameter.NSIZE   "NUM <= 2? 1 :"
input[ param.NSIZE] - 'addr' 
port.axi_stream_inf.slaver - 's00' 
port.axi_stream_inf.master[ param.NUM] - 'm00' 
end
