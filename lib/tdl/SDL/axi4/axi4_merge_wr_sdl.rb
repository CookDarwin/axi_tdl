
# add_to_all_file_paths('axi4_merge_wr','/home/CookDarwin/work/fpga/axi/AXI4/packet_merge/axi4_merge_wr.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/packet_merge/axi4_merge_wr.sv'
TdlBuild.axi4_merge_wr do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/packet_merge/axi4_merge_wr.sv'
self.path = File.expand_path(__FILE__)
parameter.MAX   8                   
port.axi_inf.slaver_wr - 'slaver' 
port.axi_inf.master_wr - 'master' 
end
