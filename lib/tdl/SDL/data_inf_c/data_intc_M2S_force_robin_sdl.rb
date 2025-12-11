
# add_to_all_file_paths('data_intc_M2S_force_robin','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_intc_M2S_force_robin.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_intc_M2S_force_robin.sv'
TdlBuild.data_intc_M2S_force_robin do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_intc_M2S_force_robin.sv'
self.path = File.expand_path(__FILE__)
parameter.NUM   8
port.data_inf_c.slaver[ param.NUM] - 's00' 
port.data_inf_c.master - 'm00' 
end
