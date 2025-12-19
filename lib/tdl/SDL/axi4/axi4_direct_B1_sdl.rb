
# add_to_all_file_paths('axi4_direct_B1','/home/CookDarwin/work/fpga/axi/AXI4/axi4_direct_B1.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_direct_B1.sv'
TdlBuild.axi4_direct_B1 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_direct_B1.sv'
self.path = File.expand_path(__FILE__)
port.axi_inf.slaver - 'slaver' 
port.axi_inf.master - 'master' 
end
