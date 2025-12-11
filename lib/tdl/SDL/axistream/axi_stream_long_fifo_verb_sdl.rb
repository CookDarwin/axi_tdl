
# add_to_all_file_paths('axi_stream_long_fifo_verb','/home/CookDarwin/work/fpga/axi/AXI_stream/packet_fifo/axi_stream_long_fifo_verb.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/packet_fifo/axi_stream_long_fifo_verb.sv'
TdlBuild.axi_stream_long_fifo_verb do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/packet_fifo/axi_stream_long_fifo_verb.sv'
self.path = File.expand_path(__FILE__)
parameter.DEPTH   2
parameter.BYTE_DEPTH   8192*2
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_stream_inf.master - 'axis_out' 
end
