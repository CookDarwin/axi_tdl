
# add_to_all_file_paths('data_inf_c_pipe_condition','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_inf_c_pipe_condition.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_inf_c_pipe_condition.sv'
TdlBuild.data_inf_c_pipe_condition do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_inf_c_pipe_condition.sv'
self.path = File.expand_path(__FILE__)
input - 'and_condition' 
port.data_inf_c.slaver - 'indata' 
port.data_inf_c.master - 'outdata' 
end
