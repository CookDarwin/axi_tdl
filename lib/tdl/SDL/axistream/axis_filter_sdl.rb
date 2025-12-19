
# add_to_all_file_paths('axis_filter','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_filter.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_filter.sv'
TdlBuild.axis_filter do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_filter.sv'
self.path = File.expand_path(__FILE__)
input - 'button' 
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_stream_inf.master - 'axis_out' 
end
