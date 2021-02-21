
# add_to_all_file_paths('trigger_ready_ctrl','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/trigger_ready_ctrl.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/trigger_ready_ctrl.sv'
TdlBuild.trigger_ready_ctrl do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/trigger_ready_ctrl.sv'
self.path = File.expand_path(__FILE__)
input - 'clock' 
input - 'rst_n' 
input - 'trigger_set_high' 
input - 'trigger_set_low' 
output - 'ready' 
end
