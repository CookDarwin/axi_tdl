
# add_to_all_file_paths('axi4_partition','/home/CookDarwin/work/fpga/axi/AXI4/packet_partition/axi4_partition.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/packet_partition/axi4_partition.sv'
TdlBuild.axi4_partition do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/packet_partition/axi4_partition.sv'
self.path = File.expand_path(__FILE__)
parameter.PSIZE   128
parameter.ADDR_STEP   1
port.axi_inf.slaver - 'axi_in' 
port.axi_inf.master - 'axi_out' 
end
