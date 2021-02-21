
# add_to_all_file_paths('odata_pool_axi4_A1','/home/CookDarwin/work/fpga/axi/AXI4/odata_pool_axi4_A1.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/odata_pool_axi4_A1.sv'
TdlBuild.odata_pool_axi4_A1 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/odata_pool_axi4_A1.sv'
self.path = File.expand_path(__FILE__)
input[32] - 'source_addr' 
input[32] - 'size' 
input - 'valid' 
output - 'ready' 
port.axi_stream_inf.master - 'out_axis' 
port.axi_inf.master_rd - 'axi_master' 
end
