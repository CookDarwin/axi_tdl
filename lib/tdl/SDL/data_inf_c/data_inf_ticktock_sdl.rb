
# add_to_all_file_paths('data_inf_ticktack','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_ticktock.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_ticktock.sv'
TdlBuild.data_inf_ticktack do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_ticktock.sv'
self.path = File.expand_path(__FILE__)
parameter.DSIZE   8
parameter.SUB_HBIT   NqString.new('DSIZE-1')
parameter.SUB_LBIT   0
parameter.MODE   "COMPARE:<"
parameter.ISIZE   32        
input - 'clock' 
input - 'rst_n' 
input[ param.DSIZE] - 'compare_data' 
input[ param.ISIZE] - 'index_data' 
port.data_inf.slaver - 'slaver' 
port.data_inf.master - 'master' 
end
