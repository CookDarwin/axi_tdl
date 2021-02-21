
# add_to_all_file_paths('axis_to_data_inf','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_to_data_inf.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_to_data_inf.sv'
TdlBuild.axis_to_data_inf do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_to_data_inf.sv'
self.path = File.expand_path(__FILE__)
parameter.CONTAIN_LAST   "OFF"
port.axi_stream_inf.slaver - 'axis_in' 
port.data_inf_c.master - 'data_out_inf' 
end
