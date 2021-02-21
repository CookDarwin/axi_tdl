
# add_to_all_file_paths('width_convert_verb','/home/CookDarwin/work/fpga/axi/AXI4/width_convert/width_convert_verb.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/width_convert/width_convert_verb.sv'
TdlBuild.width_convert_verb do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/width_convert/width_convert_verb.sv'
self.path = File.expand_path(__FILE__)
parameter.ISIZE   8
parameter.OSIZE   8
input - 'clock' 
input - 'rst_n' 
input[ param.ISIZE] - 'wr_data' 
input - 'wr_vld' 
output - 'wr_ready' 
input - 'wr_last' 
input - 'wr_align_last' 
output[ param.OSIZE] - 'rd_data' 
output - 'rd_vld' 
input - 'rd_ready' 
output - 'rd_last' 
end
