
# add_to_all_file_paths('axis_length_split','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_length_split.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_length_split.sv'
TdlBuild.axis_length_split do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_length_split.sv'
self.path = File.expand_path(__FILE__)
input[32] - 'length' 
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_stream_inf.master - 'axis_out' 
end
