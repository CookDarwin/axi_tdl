
# add_to_all_file_paths('axi4_long_to_axi4_wide_A1','/home/CookDarwin/work/fpga/axi/AXI4/axi4_long_to_axi4_wide_A1.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_long_to_axi4_wide_A1.sv'
TdlBuild.axi4_long_to_axi4_wide_A1 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_long_to_axi4_wide_A1.sv'
self.path = File.expand_path(__FILE__)
parameter.PARTITION   "ON"
port.axi_inf.slaver - 'slaver' 
port.axi_inf.master - 'master' 
end
