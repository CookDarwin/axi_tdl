
# add_to_all_file_paths('axi_stream_cache_35bit','/home/CookDarwin/work/fpga/axi/AXI_stream/stream_cache/axi_stream_cache_35bit.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/stream_cache/axi_stream_cache_35bit.sv'
TdlBuild.axi_stream_cache_35bit do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/stream_cache/axi_stream_cache_35bit.sv'
self.path = File.expand_path(__FILE__)
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_stream_inf.master - 'axis_out' 
end
