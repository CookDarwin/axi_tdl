
# add_to_all_file_paths('axis_append','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_append.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_append.sv'
TdlBuild.axis_append do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_append.sv'
self.path = File.expand_path(__FILE__)
parameter.MODE   "BOTH"
parameter.DSIZE   8
parameter.HEAD_FIELD_LEN   16*8
parameter.HEAD_FIELD_NAME   "HEAD Filed"
parameter.END_FIELD_LEN   16*8
parameter.END_FIELD_NAME   "END Filed"
input[ param.HEAD_FIELD_LEN* param.DSIZE] - 'head_value' 
input[ param.END_FIELD_LEN* param.DSIZE] - 'end_value' 
port.axi_stream_inf.slaver - 'origin_in' 
port.axi_stream_inf.master - 'append_out' 
end
