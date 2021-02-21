
# add_to_all_file_paths('data_inf_cross_clk','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_cross_clk.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_cross_clk.sv'
TdlBuild.data_inf_cross_clk do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_cross_clk.sv'
self.path = File.expand_path(__FILE__)
port.data_inf_c.slaver - 'slaver' 
port.data_inf_c.master - 'master' 
end
