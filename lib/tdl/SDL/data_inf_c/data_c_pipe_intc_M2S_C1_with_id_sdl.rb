
# add_to_all_file_paths('data_c_pipe_intc_M2S_C1_with_id','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_pipe_intc_M2S_C1_with_id.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_pipe_intc_M2S_C1_with_id.sv'
TdlBuild.data_c_pipe_intc_M2S_C1_with_id do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_pipe_intc_M2S_C1_with_id.sv'
self.path = File.expand_path(__FILE__)
parameter.PRIO   "BEST_ROBIN"
parameter.NUM   8
parameter.IDSIZE   1
input[ param.NUM] - 'last' 
input[ param.NUM] - 's00_enable' 
input[ param.NUM][ param.IDSIZE] - 'sid' 
output[ param.IDSIZE] - 'mid' 
port.data_inf_c.slaver[ param.NUM] - 's00' 
port.data_inf_c.master - 'm00' 
end
