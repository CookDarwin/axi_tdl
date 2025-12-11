
# add_to_all_file_paths('data_c_tmp_cache','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_tmp_cache.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_tmp_cache.sv'
TdlBuild.data_c_tmp_cache do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_tmp_cache.sv'
self.path = File.expand_path(__FILE__)
port.data_inf_c.slaver - 'slaver' 
port.data_inf_c.master - 'master' 
end
