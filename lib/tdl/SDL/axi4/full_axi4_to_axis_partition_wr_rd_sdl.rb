
# add_to_all_file_paths('full_axi4_to_axis_partition_wr_rd','/home/CookDarwin/work/fpga/axi/AXI4/full_axi4_to_axis_partition_wr_rd.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/full_axi4_to_axis_partition_wr_rd.sv'
TdlBuild.full_axi4_to_axis_partition_wr_rd do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/full_axi4_to_axis_partition_wr_rd.sv'
self.path = File.expand_path(__FILE__)
port.axi_stream_inf.master - 'axis_wr_inf' 
port.axi_stream_inf.master - 'axis_rd_inf' 
port.axi_stream_inf.slaver - 'axis_rd_rel_inf' 
port.axi_inf.slaver - 'xaxi4_inf' 
end
