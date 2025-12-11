
# add_to_all_file_paths('data_connect_pipe','/home/CookDarwin/work/fpga/axi/data_interface/data_connect_pipe.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_connect_pipe.sv'
TdlBuild.data_connect_pipe do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_connect_pipe.sv'
self.path = File.expand_path(__FILE__)
parameter.DSIZE   8
input - 'clock' 
input - 'rst_n' 
input - 'clk_en' 
input - 'from_up_vld' 
input[ param.DSIZE] - 'from_up_data' 
output - 'to_up_ready' 
input - 'from_down_ready' 
output - 'to_down_vld' 
output[ param.DSIZE] - 'to_down_data' 
end
