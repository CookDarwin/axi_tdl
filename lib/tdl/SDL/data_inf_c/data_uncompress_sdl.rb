
# add_to_all_file_paths('data_uncompress','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_uncompress.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_uncompress.sv'
TdlBuild.data_uncompress do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_uncompress.sv'
self.path = File.expand_path(__FILE__)
parameter.ASIZE   8
parameter.LSIZE   8
port.data_inf_c.slaver - 'data_zip' 
port.data_inf_c.master - 'data_unzip' 
end
