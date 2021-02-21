
# add_to_all_file_paths('axi4_long_to_axi4_wide_track','/home/CookDarwin/work/fpga/axi/AXI4/axi4_long_to_axi4_wide_track.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_long_to_axi4_wide_track.sv'
TdlBuild.axi4_long_to_axi4_wide_track do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_long_to_axi4_wide_track.sv'
self.path = File.expand_path(__FILE__)
port.axi_inf.slaver - 'slaver' 
port.axi_inf.master - 'master' 
end
