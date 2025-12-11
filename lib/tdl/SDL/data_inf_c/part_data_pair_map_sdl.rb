
# add_to_all_file_paths('part_data_pair_map','/home/CookDarwin/work/fpga/axi/data_interface/part_data_pair_map.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/part_data_pair_map.sv'
TdlBuild.part_data_pair_map do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/part_data_pair_map.sv'
self.path = File.expand_path(__FILE__)
parameter.NUM   8
parameter.ISIZE   8
parameter.OSIZE   8
port.data_inf_c.slaver - 'write_inf' 
port.data_inf_c.slaver - 'ipart_inf' 
port.data_inf_c.slaver - 'opart_inf' 
port.data_inf_c.slaver - 'idel_inf' 
port.data_inf_c.slaver - 'odel_inf' 
port.data_inf_c.master - 'Oipart_inf' 
port.data_inf_c.master - 'Oopart_inf' 
port.data_inf_c.master - 'ierr_inf' 
port.data_inf_c.master - 'oerr_inf' 
end
