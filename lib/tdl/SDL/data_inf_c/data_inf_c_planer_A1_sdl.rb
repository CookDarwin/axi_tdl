
# add_to_all_file_paths('data_inf_c_planer_A1','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_inf_c_planer_A1.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_inf_c_planer_A1.sv'
TdlBuild.data_inf_c_planer_A1 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_inf_c_planer_A1.sv'
self.path = File.expand_path(__FILE__)
parameter.LAT   3
parameter.DSIZE   8
parameter.HEAD   "FALSE"
input - 'reset' 
input[ param.DSIZE] - 'pack_data' 
port.data_inf_c.slaver - 'slaver' 
port.data_inf_c.master - 'master' 
end
