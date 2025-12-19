
# add_to_all_file_paths('data_c_scaler','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_scaler.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_scaler.sv'
TdlBuild.data_c_scaler do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_scaler.sv'
self.path = File.expand_path(__FILE__)
parameter.MODE   "BOTH"
input - 'head_last' 
input - 'body_last' 
input - 'end_last' 
port.data_inf_c.slaver - 'head_inf' 
port.data_inf_c.slaver - 'body_inf' 
port.data_inf_c.slaver - 'end_inf' 
port.data_inf_c.master - 'm00' 
end
