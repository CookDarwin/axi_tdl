
# add_to_all_file_paths('data_c_direct_mirror','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_direct_mirror.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_direct_mirror.sv'
TdlBuild.data_c_direct_mirror do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_direct_mirror.sv'
self.path = File.expand_path(__FILE__)
port.data_inf_c.mirror - 'slaver' 
port.data_inf_c.out_mirror - 'master' 
end
