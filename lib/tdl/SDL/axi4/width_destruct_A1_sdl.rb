
# add_to_all_file_paths('width_destruct_A1','/home/CookDarwin/work/fpga/axi/AXI4/width_convert/width_destruct_A1.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/width_convert/width_destruct_A1.sv'
TdlBuild.width_destruct_A1 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/width_convert/width_destruct_A1.sv'
self.path = File.expand_path(__FILE__)
parameter.DSIZE   1
parameter.NSIZE   8
parameter.USIZE   1
input - 'clock' 
input - 'rst_n' 
input[ param.DSIZE* param.NSIZE] - 'wr_data' 
input - 'wr_vld' 
output - 'wr_ready' 
input[ param.USIZE] - 'wr_user' 
input - 'wr_last' 
output[ param.DSIZE] - 'rd_data' 
output - 'rd_vld' 
output - 'rd_last' 
output[ param.USIZE] - 'rd_user' 
input - 'rd_ready' 
end
