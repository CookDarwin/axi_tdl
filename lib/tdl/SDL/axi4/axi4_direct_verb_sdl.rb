
# add_to_all_file_paths('axi4_direct_verb','/home/CookDarwin/work/fpga/axi/AXI4/axi4_direct_verb.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_direct_verb.sv'
TdlBuild.axi4_direct_verb do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_direct_verb.sv'
self.path = File.expand_path(__FILE__)
port.axi_inf.slaver - 'slaver' 
port.axi_inf.master - 'master' 
end
