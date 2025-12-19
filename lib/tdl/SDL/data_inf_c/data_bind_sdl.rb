
# add_to_all_file_paths('data_bind','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_bind.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_bind.sv'
TdlBuild.data_bind do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_bind.sv'
self.path = File.expand_path(__FILE__)
parameter.NUM   2
port.data_inf_c.slaver[ param.NUM] - 'data_in' 
port.data_inf_c.master - 'data_out' 
end
