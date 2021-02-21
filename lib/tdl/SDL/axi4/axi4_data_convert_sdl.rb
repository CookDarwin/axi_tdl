
# add_to_all_file_paths('axi4_data_convert','/home/CookDarwin/work/fpga/axi/AXI4/width_convert/axi4_data_convert.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/width_convert/axi4_data_convert.sv'
TdlBuild.axi4_data_convert do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/width_convert/axi4_data_convert.sv'
self.path = File.expand_path(__FILE__)
port.axi_inf.slaver - 'axi_in' 
port.axi_inf.master - 'axi_out' 
end
