
# add_to_all_file_paths('data_inf_c_planer','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_inf_c_planer.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_inf_c_planer.sv'
TdlBuild.data_inf_c_planer do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_inf_c_planer.sv'
self.path = File.expand_path(__FILE__)
parameter.LAT   3
parameter.DSIZE   8
parameter.HEAD   "FALSE"
input[ param.DSIZE] - 'pack_data' 
port.data_inf_c.slaver - 'slaver' 
port.data_inf_c.master - 'master' 
end
