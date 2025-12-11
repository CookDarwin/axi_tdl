
# add_to_all_file_paths('data_pair_map_A2','/home/CookDarwin/work/fpga/axi/data_interface/data_pair_map_A2.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_pair_map_A2.sv'
TdlBuild.data_pair_map_A2 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_pair_map_A2.sv'
self.path = File.expand_path(__FILE__)
parameter.ISIZE   8
parameter.OSIZE   8
parameter.NUM   8
port.data_inf_c.slaver - 'write_inf' 
port.data_inf_c.slaver - 'iread_inf' 
port.data_inf_c.slaver - 'oread_inf' 
port.data_inf_c.slaver - 'idel_inf' 
port.data_inf_c.slaver - 'odel_inf' 
port.data_inf_c.master - 'Oiread_inf' 
port.data_inf_c.master - 'Ooread_inf' 
port.data_inf_c.master - 'ierr_inf' 
port.data_inf_c.master - 'oerr_inf' 
end
