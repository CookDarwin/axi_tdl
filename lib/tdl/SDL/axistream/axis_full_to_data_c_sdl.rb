
# add_to_all_file_paths('axis_full_to_data_c','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_full_to_data_c.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_full_to_data_c.sv'
TdlBuild.axis_full_to_data_c do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_full_to_data_c.sv'
self.path = File.expand_path(__FILE__)
port.axi_stream_inf.slaver - 'axis_in' 
port.data_inf_c.master - 'data_out_inf' 
end
