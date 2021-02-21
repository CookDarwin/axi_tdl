
# add_to_all_file_paths('axi4_merge','/home/CookDarwin/work/fpga/axi/AXI4/packet_merge/axi4_merge.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/packet_merge/axi4_merge.sv'
TdlBuild.axi4_merge do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/packet_merge/axi4_merge.sv'
self.path = File.expand_path(__FILE__)
parameter.MAX   8
port.axi_inf.slaver - 'slaver' 
port.axi_inf.master - 'master' 
end
