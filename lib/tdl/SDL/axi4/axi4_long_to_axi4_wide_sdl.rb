
# add_to_all_file_paths('axi4_long_to_axi4_wide','/home/CookDarwin/work/fpga/axi/AXI4/axi4_long_to_axi4_wide.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_long_to_axi4_wide.sv'
TdlBuild.axi4_long_to_axi4_wide do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_long_to_axi4_wide.sv'
self.path = File.expand_path(__FILE__)
port.axi_inf.slaver - 'slaver' 
port.axi_inf.master - 'master' 
end
