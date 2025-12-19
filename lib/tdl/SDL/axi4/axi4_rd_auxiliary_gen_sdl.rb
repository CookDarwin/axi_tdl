
# add_to_all_file_paths('axi4_rd_auxiliary_gen','/home/CookDarwin/work/fpga/axi/AXI4/axi4_rd_auxiliary_gen.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_rd_auxiliary_gen.sv'
TdlBuild.axi4_rd_auxiliary_gen do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_rd_auxiliary_gen.sv'
self.path = File.expand_path(__FILE__)
port.axi_stream_inf.slaver - 'id_add_len_in' 
port.axi_inf.master_rd_aux - 'axi_rd_aux' 
end
