
# add_to_all_file_paths('check_stream_crc','/home/CookDarwin/work/fpga/axi/AXI_stream/check_stream_crc.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/check_stream_crc.sv'
TdlBuild.check_stream_crc do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/check_stream_crc.sv'
self.path = File.expand_path(__FILE__)
port.axi_stream_inf.mirror - 'axis_in' 
end
