
# add_to_all_file_paths('axi4_partition_rd','/home/CookDarwin/work/fpga/axi/AXI4/packet_partition/axi4_partition_rd.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/packet_partition/axi4_partition_rd.sv'
TdlBuild.axi4_partition_rd do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/packet_partition/axi4_partition_rd.sv'
self.path = File.expand_path(__FILE__)
parameter.PSIZE   128
parameter.ADDR_STEP   1
port.axi_inf.slaver_rd - 'axi_in' 
port.axi_inf.master_rd - 'axi_out' 
end
