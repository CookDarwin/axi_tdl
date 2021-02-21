
# add_to_all_file_paths('data_c_pipe_inf_A1','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_pipe_inf_A1.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_pipe_inf_A1.sv'
TdlBuild.data_c_pipe_inf_A1 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_pipe_inf_A1.sv'
self.path = File.expand_path(__FILE__)
output - 'empty' 
port.data_inf_c.slaver - 'slaver' 
port.data_inf_c.master - 'master' 
end
