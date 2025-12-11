
# add_to_all_file_paths('data_c_to_axis_full','/home/CookDarwin/work/fpga/axi/AXI_stream/data_c_to_axis_full.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/data_c_to_axis_full.sv'
TdlBuild.data_c_to_axis_full do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/data_c_to_axis_full.sv'
self.path = File.expand_path(__FILE__)
port.axi_stream_inf.master - 'axis_out' 
port.data_inf_c.slaver - 'data_in_inf' 
end
