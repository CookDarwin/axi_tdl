
# add_to_all_file_paths('data_pipe_interconnect_M2S_A1','/home/CookDarwin/work/fpga/axi/data_interface/data_pipe_interconnect_M2S_A1.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_pipe_interconnect_M2S_A1.sv'
TdlBuild.data_pipe_interconnect_M2S_A1 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_pipe_interconnect_M2S_A1.sv'
self.path = File.expand_path(__FILE__)
parameter.DSIZE   8
parameter.NUM   8
parameter.NSIZE   "NUM <= 2? 1 :"
input - 'clock' 
input - 'rst_n' 
input - 'clk_en' 
input - 'vld_sw' 
input[ param.NSIZE] - 'sw' 
output[ param.NSIZE] - 'curr_path' 
input[ param.NUM] - 'prio' 
port.data_inf.slaver[ param.NUM] - 's00' 
port.data_inf.master - 'm00' 
end
