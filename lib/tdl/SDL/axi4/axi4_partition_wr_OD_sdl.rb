
# add_to_all_file_paths('axi4_partition_wr_OD','/home/CookDarwin/work/fpga/axi/AXI4/packet_partition/axi4_partition_wr_OD.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/packet_partition/axi4_partition_wr_OD.sv'
TdlBuild.axi4_partition_wr_OD do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/packet_partition/axi4_partition_wr_OD.sv'
self.path = File.expand_path(__FILE__)
parameter.PSIZE   128
port.axi_inf.slaver_wr - 'axi_in' 
port.axi_inf.master_wr - 'axi_out' 
end
