
# add_to_all_file_paths('data_streams_scaler','/home/CookDarwin/work/fpga/axi/data_interface/data_streams_scaler.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_streams_scaler.sv'
TdlBuild.data_streams_scaler do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_streams_scaler.sv'
self.path = File.expand_path(__FILE__)
parameter.MODE   "BOTH"
parameter.DSIZE   8
input - 'clock' 
input - 'rst_n' 
input - 'clk_en' 
input - 'head_last' 
input - 'body_last' 
input - 'end_last' 
port.data_inf.slaver - 'head_inf' 
port.data_inf.slaver - 'body_inf' 
port.data_inf.slaver - 'end_inf' 
port.data_inf.master - 'm00' 
end
