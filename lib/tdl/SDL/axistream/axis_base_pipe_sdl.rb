
# add_to_all_file_paths('axis_base_pipe','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_base_pipe.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_base_pipe.sv'
TdlBuild.axis_base_pipe do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_base_pipe.sv'
self.path = File.expand_path(__FILE__)
output - 'empty' 
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_stream_inf.master - 'axis_out' 
end
