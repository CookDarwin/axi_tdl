
# add_to_all_file_paths('data_inf_B2A','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_B2A.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_B2A.sv'
TdlBuild.data_inf_B2A do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_B2A.sv'
self.path = File.expand_path(__FILE__)
port.data_inf.master - 'master' 
port.data_inf_c.slaver - 'slaver' 
end
