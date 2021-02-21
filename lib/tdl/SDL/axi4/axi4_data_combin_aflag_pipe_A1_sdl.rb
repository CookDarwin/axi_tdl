
# add_to_all_file_paths('axi4_data_combin_aflag_pipe_A1','/home/CookDarwin/work/fpga/axi/AXI4/width_convert/axi4_data_combin_aflag_pipe_A1.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/width_convert/axi4_data_combin_aflag_pipe_A1.sv'
TdlBuild.axi4_data_combin_aflag_pipe_A1 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/width_convert/axi4_data_combin_aflag_pipe_A1.sv'
self.path = File.expand_path(__FILE__)
parameter.MODE   "WRITE"
parameter.IDSIZE   2
parameter.ASIZE   8
parameter.ILSIZE   8
parameter.OLSIZE   8
parameter.ISIZE   8
parameter.OSIZE   24
input - 'clock' 
input - 'rst_n' 
input[ param.IDSIZE] - 'in_a_id' 
input[ param.ASIZE] - 'in_a_addr' 
input[ param.ILSIZE] - 'in_a_len' 
input[3] - 'in_a_size' 
input[2] - 'in_a_burst' 
input[1] - 'in_a_lock' 
input[4] - 'in_a_cache' 
input[3] - 'in_a_prot' 
input[4] - 'in_a_qos' 
input - 'in_a_valid' 
output - 'in_a_ready' 
output[ param.IDSIZE] - 'out_a_id' 
output[ param.ASIZE] - 'out_a_addr' 
output[ param.OLSIZE] - 'out_a_len' 
output[3] - 'out_a_size' 
output[2] - 'out_a_burst' 
output[1] - 'out_a_lock' 
output[4] - 'out_a_cache' 
output[3] - 'out_a_prot' 
output[4] - 'out_a_qos' 
output - 'out_a_valid' 
input - 'out_a_ready' 
end
