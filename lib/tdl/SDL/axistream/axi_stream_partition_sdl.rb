
# add_to_all_file_paths('axi_stream_partition','/home/CookDarwin/work/fpga/axi/AXI_stream/axi_stream_partition.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axi_stream_partition.sv'
TdlBuild.axi_stream_partition do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axi_stream_partition.sv'
self.path = File.expand_path(__FILE__)
input - 'valve' 
input[32] - 'partition_len' 
output - 'req_new_len' 
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_stream_inf.master - 'axis_out' 
end
