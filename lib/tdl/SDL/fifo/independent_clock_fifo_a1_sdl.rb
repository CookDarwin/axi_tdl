
# add_to_all_file_paths('independent_clock_fifo_a1','/home/CookDarwin/work/fpga/axi/common_fifo/independent_clock_fifo_a1.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/common_fifo/independent_clock_fifo_a1.sv'
TdlBuild.independent_clock_fifo_a1 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/common_fifo/independent_clock_fifo_a1.sv'
self.path = File.expand_path(__FILE__)
parameter.DEPTH   4
parameter.DSIZE   8
parameter.INIT_VALUE   0
parameter.PSIZE   NqString.new('$clog2(DEPTH)')
input - 'wr_clk' 
input - 'wr_rst_n' 
input - 'rd_clk' 
input - 'rd_rst_n' 
input[ param.DSIZE] - 'wdata' 
input - 'wr_en' 
output[ param.DSIZE] - 'rdata' 
input - 'rd_en' 
output - 'empty' 
output - 'full' 
end
