
# add_to_all_file_paths('axi4_combin_wr_rd_batch','/home/CookDarwin/work/fpga/axi/AXI4/axi4_combin_wr_rd_batch.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_combin_wr_rd_batch.sv'
TdlBuild.axi4_combin_wr_rd_batch do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_combin_wr_rd_batch.sv'
self.path = File.expand_path(__FILE__)
port.axi_inf.slaver_wr - 'wr_slaver' 
port.axi_inf.slaver_rd - 'rd_slaver' 
port.axi_inf.master - 'master' 
end
