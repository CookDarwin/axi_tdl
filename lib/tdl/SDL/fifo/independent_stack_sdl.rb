
# add_to_all_file_paths('independent_stack','/home/CookDarwin/work/fpga/axi/common_fifo/independent_stack.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/common_fifo/independent_stack.sv'
TdlBuild.independent_stack do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/common_fifo/independent_stack.sv'
self.path = File.expand_path(__FILE__)
parameter.DEPTH   1024
input - 'wr_clk' 
input - 'wr_rst_n' 
input - 'rd_clk' 
input - 'rd_rst_n' 
input - 'push' 
input - 'pop' 
output - 'wr_side_empty' 
output['$clog2(DEPTH)-1:0'] - 'wr_side_addr' 
output - 'rd_side_empty' 
output['$clog2(DEPTH)-1:0'] - 'rd_side_addr' 
end
