
# add_to_all_file_paths('data_c_pipe_intc_M2S_verc','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_pipe_intc_M2S_verc.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_pipe_intc_M2S_verc.sv'
TdlBuild.data_c_pipe_intc_M2S_verc do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_pipe_intc_M2S_verc.sv'
self.path = File.expand_path(__FILE__)
parameter.PRIO   "BEST_LAST"
parameter.NUM   8
parameter.NSIZE   "NUM <= 2? 1 :"
input[ param.NUM] - 'last' 
port.data_inf_c.slaver[ param.NUM] - 's00' 
port.data_inf_c.master - 'm00' 
end
