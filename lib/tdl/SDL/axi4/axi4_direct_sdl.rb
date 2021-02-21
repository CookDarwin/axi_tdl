
# add_to_all_file_paths('axi4_direct','/home/CookDarwin/work/fpga/axi/AXI4/axi4_direct.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_direct.sv'
TdlBuild.axi4_direct do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_direct.sv'
self.path = File.expand_path(__FILE__)
parameter.MODE   "BOTH_to_BOTH"
parameter.IGNORE_IDSIZE   "FALSE"
parameter.IGNORE_DSIZE   "FALSE"
parameter.IGNORE_ASIZE   "FALSE"
parameter.IGNORE_LSIZE   "FALSE"
port.axi_inf.slaver - 'slaver' 
port.axi_inf.master - 'master' 
end
