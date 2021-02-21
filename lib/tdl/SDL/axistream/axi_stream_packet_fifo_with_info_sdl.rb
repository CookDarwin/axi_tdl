
# add_to_all_file_paths('axi_stream_packet_fifo_with_info','/home/CookDarwin/work/fpga/axi/AXI_stream/packet_fifo/axi_stream_packet_fifo_with_info.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/packet_fifo/axi_stream_packet_fifo_with_info.sv'
TdlBuild.axi_stream_packet_fifo_with_info do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/packet_fifo/axi_stream_packet_fifo_with_info.sv'
self.path = File.expand_path(__FILE__)
parameter.DEPTH   2
parameter.ESIZE   8
input[ param.ESIZE] - 'info_in' 
output[ param.ESIZE] - 'info_out' 
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_stream_inf.master - 'axis_out' 
end
