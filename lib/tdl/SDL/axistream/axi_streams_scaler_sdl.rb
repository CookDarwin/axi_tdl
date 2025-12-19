
# add_to_all_file_paths('axi_streams_scaler','/home/CookDarwin/work/fpga/axi/AXI_stream/axi_streams_scaler.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axi_streams_scaler.sv'
TdlBuild.axi_streams_scaler do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axi_streams_scaler.sv'
self.path = File.expand_path(__FILE__)
parameter.MODE   "BOTH"
parameter.CUT_OR_COMBIN_BODY   "ON"
parameter.DSIZE   8
input[16] - 'new_body_len' 
port.axi_stream_inf.slaver - 'head_inf' 
port.axi_stream_inf.slaver - 'body_inf' 
port.axi_stream_inf.slaver - 'end_inf' 
port.axi_stream_inf.master - 'm00' 
end
