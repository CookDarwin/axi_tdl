
# add_to_all_file_paths('width_combin','/home/CookDarwin/work/fpga/axi/AXI4/width_convert/width_combin.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/width_convert/width_combin.sv'
TdlBuild.width_combin do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/width_convert/width_combin.sv'
self.path = File.expand_path(__FILE__)
parameter.DSIZE   1
parameter.NSIZE   8
input - 'clock' 
input - 'rst_n' 
input[ param.DSIZE] - 'wr_data' 
input - 'wr_vld' 
output - 'wr_ready' 
input - 'wr_last' 
input - 'wr_align_last' 
output[ param.DSIZE* param.NSIZE] - 'rd_data' 
output - 'rd_vld' 
input - 'rd_ready' 
output - 'rd_last' 
end
