
# add_to_all_file_paths('trigger_data_inf_c_A1','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/trigger_data_inf_c_A1.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/trigger_data_inf_c_A1.sv'
TdlBuild.trigger_data_inf_c_A1 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/trigger_data_inf_c_A1.sv'
self.path = File.expand_path(__FILE__)
parameter.DSIZE   32
input - 'trigger' 
input[ param.DSIZE] - 'data' 
port.data_inf_c.master - 'trigger_inf' 
end
