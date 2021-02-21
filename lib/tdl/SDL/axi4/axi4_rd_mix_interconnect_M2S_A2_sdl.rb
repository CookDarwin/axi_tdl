
# add_to_all_file_paths('axi4_rd_mix_interconnect_M2S_A2','/home/CookDarwin/work/fpga/axi/AXI4/interconnect/axi4_rd_mix_interconnect_M2S_A2.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/interconnect/axi4_rd_mix_interconnect_M2S_A2.sv'
TdlBuild.axi4_rd_mix_interconnect_M2S_A2 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/interconnect/axi4_rd_mix_interconnect_M2S_A2.sv'
self.path = File.expand_path(__FILE__)
parameter.NUM   8
port.axi_inf.slaver_rd[ param.NUM] - 'slaver' 
port.axi_inf.master_rd - 'master' 
end
