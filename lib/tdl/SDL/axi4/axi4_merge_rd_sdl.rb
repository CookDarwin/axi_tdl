
# add_to_all_file_paths('axi4_merge_rd','/home/CookDarwin/work/fpga/axi/AXI4/packet_merge/axi4_merge_rd.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/packet_merge/axi4_merge_rd.sv'
TdlBuild.axi4_merge_rd do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/packet_merge/axi4_merge_rd.sv'
self.path = File.expand_path(__FILE__)
parameter.MAX   8                   
port.axi_inf.slaver_rd - 'slaver' 
port.axi_inf.master_rd - 'master' 
end
