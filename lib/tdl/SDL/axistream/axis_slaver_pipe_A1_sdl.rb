
# add_to_all_file_paths('axis_slaver_pipe_A1','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_slaver_pipe_A1.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_slaver_pipe_A1.sv'
TdlBuild.axis_slaver_pipe_A1 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_slaver_pipe_A1.sv'
self.path = File.expand_path(__FILE__)
parameter.DEPTH   1
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_stream_inf.master - 'axis_out' 
end
