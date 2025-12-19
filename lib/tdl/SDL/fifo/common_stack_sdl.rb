
# add_to_all_file_paths('common_stack','/home/CookDarwin/work/fpga/axi/common_fifo/common_stack.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/common_fifo/common_stack.sv'
TdlBuild.common_stack do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/common_fifo/common_stack.sv'
self.path = File.expand_path(__FILE__)
parameter.DEPTH   1024
input - 'clock' 
input - 'rst_n' 
input - 'push' 
input - 'pop' 
output - 'empty' 
output['$clog2(DEPTH)-1:0'] - 'addr' 
end
