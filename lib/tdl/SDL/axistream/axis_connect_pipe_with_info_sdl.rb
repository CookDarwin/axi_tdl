
# add_to_all_file_paths('axis_connect_pipe_with_info','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_connect_pipe_with_info.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_connect_pipe_with_info.sv'
TdlBuild.axis_connect_pipe_with_info do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_connect_pipe_with_info.sv'
self.path = File.expand_path(__FILE__)
parameter.IFSIZE   32
input[ param.IFSIZE] - 'info_in' 
output[ param.IFSIZE] - 'info_out' 
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_stream_inf.master - 'axis_out' 
end
