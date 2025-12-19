
# add_to_all_file_paths('data_c_pipe_intc_M2S_verc_with_addr','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_pipe_intc_M2S_verc_with_addr.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_pipe_intc_M2S_verc_with_addr.sv'
TdlBuild.data_c_pipe_intc_M2S_verc_with_addr do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_pipe_intc_M2S_verc_with_addr.sv'
self.path = File.expand_path(__FILE__)
parameter.NUM   8
parameter.NSIZE   "NUM <= 2? 1 :"
input[ param.NUM] - 'last' 
port.data_inf_c.slaver - 'addr_inf' 
port.data_inf_c.slaver[ param.NUM] - 's00' 
port.data_inf_c.master - 'm00' 
end
