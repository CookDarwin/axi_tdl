
# add_to_all_file_paths('axi_stream_packet_fifo_B1','/home/CookDarwin/work/fpga/axi/AXI_stream/packet_fifo/axi_stream_packet_fifo_B1.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/packet_fifo/axi_stream_packet_fifo_B1.sv'
TdlBuild.axi_stream_packet_fifo_B1 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/packet_fifo/axi_stream_packet_fifo_B1.sv'
self.path = File.expand_path(__FILE__)
parameter.DEPTH   2
parameter.CSIZE   1
input[ param.CSIZE] - 'in_cdata' 
output[ param.CSIZE] - 'out_cdata' 
output[16] - 'empty_size' 
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_stream_inf.master - 'axis_out' 
end
