
# add_to_all_file_paths('axis_valve_with_pipe','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_valve_with_pipe.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_valve_with_pipe.sv'
TdlBuild.axis_valve_with_pipe do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_valve_with_pipe.sv'
self.path = File.expand_path(__FILE__)
parameter.MODE   "BOTH"
input - 'button' 
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_stream_inf.master - 'axis_out' 
end
