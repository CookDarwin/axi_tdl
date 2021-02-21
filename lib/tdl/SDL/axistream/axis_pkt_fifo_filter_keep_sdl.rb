
# add_to_all_file_paths('axis_pkt_fifo_filter_keep','/home/CookDarwin/work/fpga/axi/AXI_stream/packet_fifo/axis_pkt_fifo_filter_keep.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/packet_fifo/axis_pkt_fifo_filter_keep.sv'
TdlBuild.axis_pkt_fifo_filter_keep do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/packet_fifo/axis_pkt_fifo_filter_keep.sv'
self.path = File.expand_path(__FILE__)
parameter.DEPTH   2   
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_stream_inf.master - 'axis_out' 
end
