
# add_to_all_file_paths('data_condition_mirror','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_condition_mirror.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_condition_mirror.sv'
TdlBuild.data_condition_mirror do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_condition_mirror.sv'
self.path = File.expand_path(__FILE__)
parameter.H   0
parameter.L   0
input[( param.H+1- param.L)] - 'condition_data' 
port.data_inf_c.slaver - 'data_in' 
port.data_inf_c.master - 'data_out' 
port.data_inf_c.master - 'data_mirror' 
end
