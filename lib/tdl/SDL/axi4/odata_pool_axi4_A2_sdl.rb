
# add_to_all_file_paths('odata_pool_axi4_A2','/home/CookDarwin/work/fpga/axi/AXI4/odata_pool_axi4_A2.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/odata_pool_axi4_A2.sv'
TdlBuild.odata_pool_axi4_A2 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/odata_pool_axi4_A2.sv'
self.path = File.expand_path(__FILE__)
port.axi_stream_inf.master - 'out_axis' 
port.axi_inf.master_rd - 'axi_master' 
port.data_inf_c.slaver - 'addr_size_inf' 
end
