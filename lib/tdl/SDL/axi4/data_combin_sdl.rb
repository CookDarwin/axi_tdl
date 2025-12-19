
# add_to_all_file_paths('data_combin_0','/home/CookDarwin/work/fpga/axi/AXI4/width_convert/data_combin.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/width_convert/data_combin.sv'
TdlBuild.data_combin_0 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/width_convert/data_combin.sv'
self.path = File.expand_path(__FILE__)
parameter.IDSIZE   24
parameter.ODSIZE   256
input - 'clock' 
input - 'rst_n' 
input[32] - 'cut_old_len' 
input[ param.IDSIZE] - 'indata' 
input - 'invalid' 
output - 'inready' 
input - 'inlast' 
output[ param.ODSIZE] - 'outdata' 
output - 'outvalid' 
input - 'outready' 
output - 'outlast' 
end
