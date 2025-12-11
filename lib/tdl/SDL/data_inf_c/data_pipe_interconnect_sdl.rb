
# add_to_all_file_paths('data_pipe_interconnect','/home/CookDarwin/work/fpga/axi/data_interface/data_pipe_interconnect.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_pipe_interconnect.sv'
TdlBuild.data_pipe_interconnect do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_pipe_interconnect.sv'
self.path = File.expand_path(__FILE__)
parameter.DSIZE   8
input - 'clock' 
input - 'rst_n' 
input - 'clk_en' 
input - 'vld_sw' 
input[3] - 'sw' 
output[3] - 'curr_path' 
port.data_inf.slaver - 's00' 
port.data_inf.slaver - 's01' 
port.data_inf.slaver - 's02' 
port.data_inf.slaver - 's03' 
port.data_inf.slaver - 's04' 
port.data_inf.slaver - 's05' 
port.data_inf.slaver - 's06' 
port.data_inf.slaver - 's07' 
port.data_inf.master - 'm00' 
end
