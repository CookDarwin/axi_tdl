
# add_to_all_file_paths('axi4_data_convert_A1','/home/CookDarwin/work/fpga/axi/AXI4/width_convert/axi4_data_convert_A1.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/width_convert/axi4_data_convert_A1.sv'
TdlBuild.axi4_data_convert_A1 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/width_convert/axi4_data_convert_A1.sv'
self.path = File.expand_path(__FILE__)
port.axi_inf.slaver - 'axi_in' 
port.axi_inf.master - 'axi_out' 
end
