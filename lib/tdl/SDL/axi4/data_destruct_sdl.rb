
# add_to_all_file_paths('data_destruct','/home/CookDarwin/work/fpga/axi/AXI4/width_convert/data_destruct.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/width_convert/data_destruct.sv'
TdlBuild.data_destruct do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/width_convert/data_destruct.sv'
self.path = File.expand_path(__FILE__)
parameter.IDSIZE   256
parameter.ODSIZE   24
input - 'clock' 
input - 'rst_n' 
input[ param.IDSIZE] - 'indata' 
input - 'invalid' 
output - 'inready' 
input - 'inlast' 
output[ param.ODSIZE] - 'outdata' 
output - 'outvalid' 
input - 'outready' 
output - 'outlast' 
end
