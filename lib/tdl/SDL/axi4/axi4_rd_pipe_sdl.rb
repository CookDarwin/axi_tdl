
# add_to_all_file_paths('axi4_rd_pipe','/home/CookDarwin/work/fpga/axi/AXI4/axi4_pipe/axi4_rd_pipe.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_pipe/axi4_rd_pipe.sv'
TdlBuild.axi4_rd_pipe do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_pipe/axi4_rd_pipe.sv'
self.path = File.expand_path(__FILE__)
port.axi_inf.slaver_rd - 'slaver' 
port.axi_inf.master_rd - 'master' 
end
