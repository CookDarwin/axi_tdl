
# add_to_all_file_paths('axi4_partition_wr','/home/CookDarwin/work/fpga/axi/AXI4/packet_partition/axi4_partition_wr.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/packet_partition/axi4_partition_wr.sv'
TdlBuild.axi4_partition_wr do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/packet_partition/axi4_partition_wr.sv'
self.path = File.expand_path(__FILE__)
parameter.PSIZE   128
parameter.ADDR_STEP   1
port.axi_inf.slaver_wr - 'axi_in' 
port.axi_inf.master_wr - 'axi_out' 
end
