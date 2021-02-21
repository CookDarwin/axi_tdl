
# add_to_all_file_paths('data_c_pipe_force_vld_bind_data','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_pipe_force_vld_bind_data.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_pipe_force_vld_bind_data.sv'
TdlBuild.data_c_pipe_force_vld_bind_data do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_pipe_force_vld_bind_data.sv'
self.path = File.expand_path(__FILE__)
parameter.DSIZE   32
parameter.HEAD_MODE   "ON"
parameter.SYNC   "master"
input[ param.DSIZE] - 'data' 
port.data_inf_c.slaver - 'slaver' 
port.data_inf_c.master - 'master' 
end
