
# add_to_all_file_paths('data_condition_valve','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_condition_valve.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_condition_valve.sv'
TdlBuild.data_condition_valve do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_condition_valve.sv'
self.path = File.expand_path(__FILE__)
parameter.H   0
parameter.L   0
input - 'condition_button' 
input[( param.H+1- param.L)] - 'condition_data' 
port.data_inf_c.slaver - 'data_in' 
port.data_inf_c.master - 'data_out' 
end
