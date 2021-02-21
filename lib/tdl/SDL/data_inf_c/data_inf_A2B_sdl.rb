
# add_to_all_file_paths('data_inf_A2B','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_A2B.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_A2B.sv'
TdlBuild.data_inf_A2B do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_A2B.sv'
self.path = File.expand_path(__FILE__)
port.data_inf.slaver - 'slaver' 
port.data_inf_c.master - 'master' 
end
