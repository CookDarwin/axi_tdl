
# add_to_all_file_paths('simple_data_pipe_slaver','/home/CookDarwin/work/fpga/axi/AXI4/width_convert/simple_data_pipe_slaver.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/width_convert/simple_data_pipe_slaver.sv'
TdlBuild.simple_data_pipe_slaver do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/width_convert/simple_data_pipe_slaver.sv'
self.path = File.expand_path(__FILE__)
parameter.DSIZE   24
input - 'clock' 
input - 'rst_n' 
input[ param.DSIZE] - 'indata' 
input - 'invalid' 
input - 'inready' 
output[ param.DSIZE] - 'outdata' 
input - 'outvalid' 
input - 'outready' 
end
