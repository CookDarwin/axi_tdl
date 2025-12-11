
# add_to_all_file_paths('data_c_pipe_intc_M2S_C1','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_pipe_intc_M2S_C1.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_pipe_intc_M2S_C1.sv'
TdlBuild.data_c_pipe_intc_M2S_C1 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_c_pipe_intc_M2S_C1.sv'
self.path = File.expand_path(__FILE__)
parameter.PRIO   "BEST_ROBIN"
parameter.NUM   8
parameter.NSIZE   "NUM <= 2? 1 :"
input[ param.NUM] - 'last' 
input[ param.NUM] - 's00_enable' 
port.data_inf_c.slaver[ param.NUM] - 's00' 
port.data_inf_c.master - 'm00' 
end
