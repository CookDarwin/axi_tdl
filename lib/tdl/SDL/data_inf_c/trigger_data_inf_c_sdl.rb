
# add_to_all_file_paths('trigger_data_inf_c','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/trigger_data_inf_c.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/trigger_data_inf_c.sv'
TdlBuild.trigger_data_inf_c do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/trigger_data_inf_c.sv'
self.path = File.expand_path(__FILE__)
parameter.DSIZE   32
input - 'trigger' 
input[ param.DSIZE] - 'data' 
port.data_inf_c.master - 'trigger_inf' 
end
