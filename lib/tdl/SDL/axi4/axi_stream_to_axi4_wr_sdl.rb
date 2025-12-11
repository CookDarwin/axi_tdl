
# add_to_all_file_paths('axi_stream_to_axi4_wr','/home/CookDarwin/work/fpga/axi/AXI4/axi_stream_to_axi4_wr.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi_stream_to_axi4_wr.sv'
TdlBuild.axi_stream_to_axi4_wr do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi_stream_to_axi4_wr.sv'
self.path = File.expand_path(__FILE__)
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_inf.master_wr - 'axi_wr_inf' 
end
