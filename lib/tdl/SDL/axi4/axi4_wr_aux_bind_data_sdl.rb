
# add_to_all_file_paths('axi4_wr_aux_bind_data','/home/CookDarwin/work/fpga/axi/AXI4/axi4_wr_aux_bind_data.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_wr_aux_bind_data.sv'
TdlBuild.axi4_wr_aux_bind_data do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_wr_aux_bind_data.sv'
self.path = File.expand_path(__FILE__)
port.axi_stream_inf.master - 'axis_inf' 
port.axi_inf.slaver_wr - 'caxi4_inf' 
end
