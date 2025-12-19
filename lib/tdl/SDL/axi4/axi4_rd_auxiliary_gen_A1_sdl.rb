
# add_to_all_file_paths('axi4_rd_auxiliary_gen_A1','/home/CookDarwin/work/fpga/axi/AXI4/axi4_rd_auxiliary_gen_A1.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_rd_auxiliary_gen_A1.sv'
TdlBuild.axi4_rd_auxiliary_gen_A1 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_rd_auxiliary_gen_A1.sv'
self.path = File.expand_path(__FILE__)
port.axi_stream_inf.slaver - 'id_add_len_in' 
port.axi_inf.master_rd_aux - 'axi_rd_aux' 
end
