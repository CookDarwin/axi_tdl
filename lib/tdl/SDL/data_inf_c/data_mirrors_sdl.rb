
# add_to_all_file_paths('data_mirrors','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_mirrors.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_mirrors.sv'
TdlBuild.data_mirrors do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_mirrors.sv'
self.path = File.expand_path(__FILE__)
parameter.H   0
parameter.L   0
parameter.NUM   8
parameter.MODE   "CDS_MODE"
input[( param.H+1- param.L)] - 'condition_data' 
port.data_inf_c.slaver - 'data_in' 
port.data_inf_c.master[ param.NUM] - 'data_mirror' 
end
