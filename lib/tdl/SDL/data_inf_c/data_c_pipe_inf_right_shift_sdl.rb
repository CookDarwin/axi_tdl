
# add_to_all_file_paths('data_c_pipe_inf_right_shift','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_pipe_inf_right_shift.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_pipe_inf_right_shift.sv'
TdlBuild.data_c_pipe_inf_right_shift do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_pipe_inf_right_shift.sv'
self.path = File.expand_path(__FILE__)
parameter.SHIFT_BITS   1
parameter.EX_SIZE   1
input[ param.EX_SIZE] - 'ex_in' 
output[ param.EX_SIZE] - 'ex_out' 
port.data_inf_c.slaver - 'slaver' 
port.data_inf_c.master - 'master' 
end
