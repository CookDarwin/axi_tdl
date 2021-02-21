
# add_to_all_file_paths('axi_stream_long_cache','/home/CookDarwin/work/fpga/axi/AXI_stream/stream_cache/axi_stream_long_cache.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/stream_cache/axi_stream_long_cache.sv'
TdlBuild.axi_stream_long_cache do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/stream_cache/axi_stream_long_cache.sv'
self.path = File.expand_path(__FILE__)
parameter.DEPTH   8192
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_stream_inf.master - 'axis_out' 
end
