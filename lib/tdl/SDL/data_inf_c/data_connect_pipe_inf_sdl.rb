
# add_to_all_file_paths('data_connect_pipe_inf','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_connect_pipe_inf.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_connect_pipe_inf.sv'
TdlBuild.data_connect_pipe_inf do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_connect_pipe_inf.sv'
self.path = File.expand_path(__FILE__)
port.data_inf_c.slaver - 'indata' 
port.data_inf_c.master - 'outdata' 
end
