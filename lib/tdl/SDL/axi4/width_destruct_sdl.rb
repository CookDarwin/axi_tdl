
# add_to_all_file_paths('width_destruct','/home/CookDarwin/work/fpga/axi/AXI4/width_convert/width_destruct.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/width_convert/width_destruct.sv'
TdlBuild.width_destruct do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/width_convert/width_destruct.sv'
self.path = File.expand_path(__FILE__)
parameter.DSIZE   1
parameter.NSIZE   8
input - 'clock' 
input - 'rst_n' 
input[ param.DSIZE* param.NSIZE] - 'wr_data' 
input - 'wr_vld' 
output - 'wr_ready' 
input - 'wr_last' 
output[ param.DSIZE] - 'rd_data' 
output - 'rd_vld' 
output - 'rd_last' 
input - 'rd_ready' 
end
