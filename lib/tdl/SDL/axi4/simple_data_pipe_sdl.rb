
# add_to_all_file_paths('simple_data_pipe','/home/CookDarwin/work/fpga/axi/AXI4/width_convert/simple_data_pipe.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/width_convert/simple_data_pipe.sv'
TdlBuild.simple_data_pipe do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/width_convert/simple_data_pipe.sv'
self.path = File.expand_path(__FILE__)
parameter.DSIZE   24
input - 'clock' 
input - 'rst_n' 
input[ param.DSIZE] - 'indata' 
input - 'invalid' 
output - 'inready' 
output[ param.DSIZE] - 'outdata' 
output - 'outvalid' 
input - 'outready' 
end
