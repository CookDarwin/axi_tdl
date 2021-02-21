
# add_to_all_file_paths('data_inf_c_M2S_with_addr_and_id','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_inf_c_M2S_with_addr_and_id.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_inf_c_M2S_with_addr_and_id.sv'
TdlBuild.data_inf_c_M2S_with_addr_and_id do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_inf_c_M2S_with_addr_and_id.sv'
self.path = File.expand_path(__FILE__)
parameter.NUM   8
parameter.IDSIZE   4
parameter.NSIZE   NqString.new('$clog2(NUM)')
input[ param.NSIZE] - 'addr' 
input - 'addr_vld' 
output[ param.NSIZE] - 'curr_addr' 
input[ param.NUM][ param.IDSIZE] - 'sid' 
output[ param.IDSIZE] - 'mid' 
port.data_inf_c.slaver[ param.NUM] - 's00' 
port.data_inf_c.master - 'm00' 
end
