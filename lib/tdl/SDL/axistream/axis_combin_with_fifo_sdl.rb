
# add_to_all_file_paths('axis_combin_with_fifo','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_combin_with_fifo.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_combin_with_fifo.sv'
TdlBuild.axis_combin_with_fifo do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_combin_with_fifo.sv'
self.path = File.expand_path(__FILE__)
parameter.MODE   "BOTH"
parameter.CUT_OR_COMBIN_BODY   "ON"
input[16] - 'new_body_len' 
port.axi_stream_inf.slaver - 'head_inf' 
port.axi_stream_inf.slaver - 'body_inf' 
port.axi_stream_inf.slaver - 'end_inf' 
port.axi_stream_inf.master - 'm00' 
end
