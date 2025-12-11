
# add_to_all_file_paths('odd_width_convert_verb','/home/CookDarwin/work/fpga/axi/AXI4/width_convert/odd_width_convert_verb.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/width_convert/odd_width_convert_verb.sv'
TdlBuild.odd_width_convert_verb do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/width_convert/odd_width_convert_verb.sv'
self.path = File.expand_path(__FILE__)
parameter.ISIZE   12
parameter.OSIZE   16
input - 'clock' 
input - 'rst_n' 
input[ param.ISIZE] - 'wr_data' 
input - 'wr_vld' 
output - 'wr_ready' 
input - 'wr_last' 
output[ param.OSIZE] - 'rd_data' 
output - 'rd_vld' 
input - 'rd_ready' 
output - 'rd_last' 
end
