
# add_to_all_file_paths('full_axi4_to_axis','/home/CookDarwin/work/fpga/axi/AXI4/full_axi4_to_axis.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/full_axi4_to_axis.sv'
TdlBuild.full_axi4_to_axis do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/full_axi4_to_axis.sv'
self.path = File.expand_path(__FILE__)
port.axi_stream_inf.master - 'axis_inf' 
port.axi_stream_inf.slaver - 'axis_rd_inf' 
port.axi_inf.slaver - 'xaxi4_inf' 
end
