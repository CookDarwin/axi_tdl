
# add_to_all_file_paths('axis_width_convert','/home/CookDarwin/work/fpga/axi/AXI_stream/data_width/axis_width_convert.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/data_width/axis_width_convert.sv'
TdlBuild.axis_width_convert do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/data_width/axis_width_convert.sv'
self.path = File.expand_path(__FILE__)
port.axi_stream_inf.slaver - 'in_axis' 
port.axi_stream_inf.master - 'out_axis' 
end
