
# add_to_all_file_paths('feed_check','/home/CookDarwin/work/fpga/axi/AXI4/width_convert/feed_check.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/width_convert/feed_check.sv'
TdlBuild.feed_check do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/width_convert/feed_check.sv'
self.path = File.expand_path(__FILE__)
parameter.ASIZE   128
parameter.BSIZE   192
parameter.LIST   "OFF"
input - 'aclock' 
input[ param.ASIZE] - 'adata' 
input - 'amark' 
input - 'avld' 
input - 'bclock' 
input[ param.BSIZE] - 'bdata' 
input - 'bmark' 
input - 'bvld' 
end
