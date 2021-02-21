
# add_to_all_file_paths('idata_pool_axi4','/home/CookDarwin/work/fpga/axi/AXI4/idata_pool_axi4.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/idata_pool_axi4.sv'
TdlBuild.idata_pool_axi4 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/idata_pool_axi4.sv'
self.path = File.expand_path(__FILE__)
parameter.DSIZE   8
input[32] - 'source_addr' 
input[32] - 'size' 
input - 'valid' 
output - 'ready' 
output - 'last_drop' 
input[ param.DSIZE] - 'data' 
output - 'empty' 
input - 'wr_en' 
input - 'sewage_valve' 
port.axi_inf.master_wr - 'axi_master' 
end
