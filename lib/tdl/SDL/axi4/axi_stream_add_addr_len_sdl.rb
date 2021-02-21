
# add_to_all_file_paths('axi_stream_add_addr_len','/home/CookDarwin/work/fpga/axi/AXI4/axi_stream_add_addr_len.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi_stream_add_addr_len.sv'
TdlBuild.axi_stream_add_addr_len do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi_stream_add_addr_len.sv'
self.path = File.expand_path(__FILE__)
input[32] - 'addr' 
input[32] - 'length' 
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_stream_inf.master - 'axis_out' 
end
