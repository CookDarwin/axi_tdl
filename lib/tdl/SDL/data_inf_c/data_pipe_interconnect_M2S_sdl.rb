
# add_to_all_file_paths('data_pipe_interconnect_M2S','/home/CookDarwin/work/fpga/axi/data_interface/data_pipe_interconnect_M2S.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_pipe_interconnect_M2S.sv'
TdlBuild.data_pipe_interconnect_M2S do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_pipe_interconnect_M2S.sv'
self.path = File.expand_path(__FILE__)
parameter.NUM   8
parameter.NSIZE   "NUM <= 2? 1 :"
input - 'clock' 
input - 'rst_n' 
input - 'clk_en' 
input - 'vld_sw' 
input[ param.NSIZE] - 'sw' 
output[ param.NSIZE] - 'curr_path' 
port.data_inf.slaver[ param.NUM] - 's00' 
port.data_inf.master - 'm00' 
end
