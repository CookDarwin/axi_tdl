
# add_to_all_file_paths('axis_connect_pipe_right_shift','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_connect_pipe_right_shift.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_connect_pipe_right_shift.sv'
TdlBuild.axis_connect_pipe_right_shift do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_connect_pipe_right_shift.sv'
self.path = File.expand_path(__FILE__)
parameter.SHIFT_BITS   1
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_stream_inf.master - 'axis_out' 
end
