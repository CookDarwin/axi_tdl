
# add_to_all_file_paths('axi_stream_cache_mirror','/home/CookDarwin/work/fpga/axi/AXI_stream/stream_cache/axi_stream_cache_mirror.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/stream_cache/axi_stream_cache_mirror.sv'
TdlBuild.axi_stream_cache_mirror do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/stream_cache/axi_stream_cache_mirror.sv'
self.path = File.expand_path(__FILE__)
port.axi_stream_inf.mirror - 'axis_in' 
port.axi_stream_inf.out_mirror - 'axis_out' 
end
