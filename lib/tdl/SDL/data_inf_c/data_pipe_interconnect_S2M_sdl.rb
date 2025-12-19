
# add_to_all_file_paths('data_pipe_interconnect_S2M','/home/CookDarwin/work/fpga/axi/data_interface/data_pipe_interconnect_S2M.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_pipe_interconnect_S2M.sv'
TdlBuild.data_pipe_interconnect_S2M do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_pipe_interconnect_S2M.sv'
self.path = File.expand_path(__FILE__)
parameter.DSIZE   8
parameter.NUM   8
parameter.NSIZE   "NUM <= 2? 1 :"
input - 'clock' 
input - 'rst_n' 
input - 'clk_en' 
input[ param.NSIZE] - 'addr' 
port.data_inf.master[ param.NUM] - 'm00' 
port.data_inf.slaver - 's00' 
end
