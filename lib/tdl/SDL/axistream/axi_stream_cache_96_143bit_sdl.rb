
# add_to_all_file_paths('axi_stream_cache_96_143bit','/home/CookDarwin/work/fpga/axi/AXI_stream/stream_cache/axi_stream_cache_96_143bit.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/stream_cache/axi_stream_cache_96_143bit.sv'
TdlBuild.axi_stream_cache_96_143bit do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/stream_cache/axi_stream_cache_96_143bit.sv'
self.path = File.expand_path(__FILE__)
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_stream_inf.master - 'axis_out' 
end
