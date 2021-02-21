
# add_to_all_file_paths('data_to_axis_inf','/home/CookDarwin/work/fpga/axi/AXI_stream/data_to_axis_inf.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/data_to_axis_inf.sv'
TdlBuild.data_to_axis_inf do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/data_to_axis_inf.sv'
self.path = File.expand_path(__FILE__)
input - 'mark_curr_data' 
input - 'last_flag' 
port.axi_stream_inf.master - 'axis_master' 
port.data_inf_c.slaver - 'data_slaver' 
end
