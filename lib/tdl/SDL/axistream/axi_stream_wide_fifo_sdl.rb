
# add_to_all_file_paths('axi_stream_wide_fifo','/home/CookDarwin/work/fpga/axi/AXI_stream/packet_fifo/axi_stream_wide_fifo.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/packet_fifo/axi_stream_wide_fifo.sv'
TdlBuild.axi_stream_wide_fifo do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/packet_fifo/axi_stream_wide_fifo.sv'
self.path = File.expand_path(__FILE__)
parameter.DEPTH   2
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_stream_inf.master - 'axis_out' 
end
