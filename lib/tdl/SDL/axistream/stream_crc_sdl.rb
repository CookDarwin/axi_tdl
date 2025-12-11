
# add_to_all_file_paths('stream_crc','/home/CookDarwin/work/fpga/axi/AXI_stream/stream_crc.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/stream_crc.sv'
TdlBuild.stream_crc do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/stream_crc.sv'
self.path = File.expand_path(__FILE__)
output[32] - 'crc' 
port.axi_stream_inf.mirror - 'axis_in' 
end
