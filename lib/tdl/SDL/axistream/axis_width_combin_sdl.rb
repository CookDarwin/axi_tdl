
# add_to_all_file_paths('axis_width_combin','/home/CookDarwin/work/fpga/axi/AXI_stream/data_width/axis_width_combin.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/data_width/axis_width_combin.sv'
TdlBuild.axis_width_combin do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/data_width/axis_width_combin.sv'
self.path = File.expand_path(__FILE__)
port.axi_stream_inf.slaver - 'slim_axis' 
port.axi_stream_inf.master - 'wide_axis' 
end
