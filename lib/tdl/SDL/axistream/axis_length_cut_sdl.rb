
# add_to_all_file_paths('axis_length_cut','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_length_cut.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_length_cut.sv'
TdlBuild.axis_length_cut do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_length_cut.sv'
self.path = File.expand_path(__FILE__)
input[32] - 'length' 
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_stream_inf.master - 'axis_out' 
end
