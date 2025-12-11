
# add_to_all_file_paths('data_streams_combin','/home/CookDarwin/work/fpga/axi/data_interface/data_streams_combin.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_streams_combin.sv'
TdlBuild.data_streams_combin do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_streams_combin.sv'
self.path = File.expand_path(__FILE__)
parameter.MODE   "BOTH"
parameter.DSIZE   8
input - 'clock' 
input - 'rst_n' 
input - 'clk_en' 
input - 'trigger_signal' 
input - 'head_last' 
input - 'body_last' 
input - 'end_last' 
port.data_inf.slaver - 'head_inf' 
port.data_inf.slaver - 'body_inf' 
port.data_inf.slaver - 'end_inf' 
port.data_inf.master - 'm00' 
end
