
# add_to_all_file_paths('axis_length_split_with_addr','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_length_split_with_addr.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_length_split_with_addr.sv'
TdlBuild.axis_length_split_with_addr do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_length_split_with_addr.sv'
self.path = File.expand_path(__FILE__)
parameter.ADDR_STEP   1024      
input[32] - 'origin_addr' 
input[32] - 'length' 
output[32] - 'band_addr' 
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_stream_inf.master - 'axis_out' 
end
