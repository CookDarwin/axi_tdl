
# add_to_all_file_paths('axi4_partition_rd_OD','/home/CookDarwin/work/fpga/axi/AXI4/packet_partition/axi4_partition_rd_OD.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/packet_partition/axi4_partition_rd_OD.sv'
TdlBuild.axi4_partition_rd_OD do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/packet_partition/axi4_partition_rd_OD.sv'
self.path = File.expand_path(__FILE__)
parameter.PSIZE   128 
port.axi_inf.slaver_rd - 'slaver' 
port.axi_inf.master_rd - 'master' 
end
