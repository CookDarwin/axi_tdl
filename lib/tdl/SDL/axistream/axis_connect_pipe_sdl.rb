
# add_to_all_file_paths('axis_connect_pipe','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_connect_pipe.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_connect_pipe.sv'
TdlBuild.axis_connect_pipe do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_connect_pipe.sv'
self.path = File.expand_path(__FILE__)
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_stream_inf.master - 'axis_out' 
end
