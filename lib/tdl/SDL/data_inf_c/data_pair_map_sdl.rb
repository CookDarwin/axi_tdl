
# add_to_all_file_paths('data_pair_map','/home/CookDarwin/work/fpga/axi/data_interface/data_pair_map.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_pair_map.sv'
TdlBuild.data_pair_map do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_pair_map.sv'
self.path = File.expand_path(__FILE__)
parameter.ISIZE   8
parameter.OSIZE   8
parameter.NUM   8
port.data_inf_c.slaver - 'write_inf' 
port.data_inf_c.slaver - 'read_inf' 
port.data_inf_c.master - 'out_inf' 
port.data_inf_c.master - 'err_inf' 
end
