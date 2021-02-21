
# add_to_all_file_paths('odata_pool_axi4','/home/CookDarwin/work/fpga/axi/AXI4/odata_pool_axi4.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/odata_pool_axi4.sv'
TdlBuild.odata_pool_axi4 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/odata_pool_axi4.sv'
self.path = File.expand_path(__FILE__)
parameter.DSIZE   8
input - 'rd_clk' 
input - 'rd_rst_n' 
output[ param.DSIZE] - 'data' 
output - 'empty' 
input - 'rd_en' 
input[32] - 'source_addr' 
input[32] - 'size' 
input - 'valid' 
output - 'ready' 
output - 'last_drop' 
port.axi_inf.master_rd - 'axi_master' 
end
