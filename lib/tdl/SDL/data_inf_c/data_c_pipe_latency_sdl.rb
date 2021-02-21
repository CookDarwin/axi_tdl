
# add_to_all_file_paths('data_c_pipe_latency','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_pipe_latency.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_pipe_latency.sv'
TdlBuild.data_c_pipe_latency do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_pipe_latency.sv'
self.path = File.expand_path(__FILE__)
parameter.LAT   4
port.data_inf_c.slaver - 'slaver' 
port.data_inf_c.master - 'master' 
end
