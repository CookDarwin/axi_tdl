
# add_to_all_file_paths('data_inf_c_intc_S2M_with_lazy','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_inf_c_intc_S2M_with_lazy.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_inf_c_intc_S2M_with_lazy.sv'
TdlBuild.data_inf_c_intc_S2M_with_lazy do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_inf_c_intc_S2M_with_lazy.sv'
self.path = File.expand_path(__FILE__)
parameter.NUM   8
parameter.NSIZE   NqString.new('$clog2(NUM)')
parameter.LAZISE   1
input[ param.NSIZE] - 'addr' 
output[ param.NUM][ param.LAZISE] - 'm00_lazy_data' 
input[ param.LAZISE] - 's00_lazy_data' 
port.data_inf_c.master[ param.NUM] - 'm00' 
port.data_inf_c.slaver - 's00' 
end
