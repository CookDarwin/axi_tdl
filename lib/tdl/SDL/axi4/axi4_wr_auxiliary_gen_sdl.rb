
# add_to_all_file_paths('axi4_wr_auxiliary_gen','/home/CookDarwin/work/fpga/axi/AXI4/axi4_wr_auxiliary_gen.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_wr_auxiliary_gen.sv'
TdlBuild.axi4_wr_auxiliary_gen do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_wr_auxiliary_gen.sv'
self.path = File.expand_path(__FILE__)
output - 'stream_en' 
port.axi_stream_inf.slaver - 'id_add_len_in' 
port.axi_inf.master_wr_aux - 'axi_wr_aux' 
end
