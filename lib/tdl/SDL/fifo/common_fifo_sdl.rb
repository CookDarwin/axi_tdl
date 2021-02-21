
# add_to_all_file_paths('common_fifo','/home/CookDarwin/work/fpga/axi/common_fifo/common_fifo.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/common_fifo/common_fifo.sv'
TdlBuild.common_fifo do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/common_fifo/common_fifo.sv'
self.path = File.expand_path(__FILE__)
parameter.DEPTH   4
parameter.DSIZE   8
parameter.PSIZE   NqString.new('$clog2(DEPTH)')
parameter.CSIZE   NqString.new('$clog2(DEPTH+1)')
input - 'clock' 
input - 'rst_n' 
input[ param.DSIZE] - 'wdata' 
input - 'wr_en' 
output[ param.DSIZE] - 'rdata' 
input - 'rd_en' 
output[ param.CSIZE] - 'count' 
output - 'empty' 
output - 'full' 
end
