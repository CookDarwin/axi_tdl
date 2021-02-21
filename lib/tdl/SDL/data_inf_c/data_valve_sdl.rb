
# add_to_all_file_paths('data_valve','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_valve.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_valve.sv'
TdlBuild.data_valve do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_valve.sv'
self.path = File.expand_path(__FILE__)
input - 'button' 
port.data_inf_c.slaver - 'data_in' 
port.data_inf_c.master - 'data_out' 
end
