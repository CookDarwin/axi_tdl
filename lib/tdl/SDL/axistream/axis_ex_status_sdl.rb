
# add_to_all_file_paths('axis_ex_status','/home/CookDarwin/work/fpga/axi/AXI_stream/ex_status/axis_ex_status.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/ex_status/axis_ex_status.sv'
TdlBuild.axis_ex_status do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/ex_status/axis_ex_status.sv'
self.path = File.expand_path(__FILE__)
parameter.ESIZE   1
input[ param.ESIZE] - 'origin_status' 
output[ param.ESIZE] - 'binding_status' 
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_stream_inf.master - 'axis_out' 
end
