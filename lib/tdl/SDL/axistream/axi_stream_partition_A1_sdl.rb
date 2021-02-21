
# add_to_all_file_paths('axi_stream_partition_A1','/home/CookDarwin/work/fpga/axi/AXI_stream/axi_stream_partition_A1.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axi_stream_partition_A1.sv'
TdlBuild.axi_stream_partition_A1 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axi_stream_partition_A1.sv'
self.path = File.expand_path(__FILE__)
input - 'valve' 
input[32] - 'partition_len' 
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_stream_inf.master - 'axis_out' 
end
