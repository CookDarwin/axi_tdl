
# add_to_all_file_paths('axi4_wr_auxiliary_gen_without_resp','/home/CookDarwin/work/fpga/axi/AXI4/axi4_wr_auxiliary_gen_without_resp.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_wr_auxiliary_gen_without_resp.sv'
TdlBuild.axi4_wr_auxiliary_gen_without_resp do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_wr_auxiliary_gen_without_resp.sv'
self.path = File.expand_path(__FILE__)
output - 'stream_en' 
port.axi_stream_inf.slaver - 'id_add_len_in' 
port.axi_inf.master_wr_aux_no_resp - 'axi_wr_aux' 
end
