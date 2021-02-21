
# add_to_all_file_paths('data_inf_c_intc_S2M','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_inf_c_intc_S2M.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_inf_c_intc_S2M.sv'
TdlBuild.data_inf_c_intc_S2M do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_inf_c_intc_S2M.sv'
self.path = File.expand_path(__FILE__)
parameter.NUM   8
parameter.NSIZE   NqString.new('$clog2(NUM)')
input[ param.NSIZE] - 'addr' 
port.data_inf_c.master[ param.NUM] - 'm00' 
port.data_inf_c.slaver - 's00' 
end
