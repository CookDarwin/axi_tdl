
# add_to_all_file_paths('axis_width_destruct_A1','/home/CookDarwin/work/fpga/axi/AXI_stream/data_width/axis_width_destruct_A1.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/data_width/axis_width_destruct_A1.sv'
TdlBuild.axis_width_destruct_A1 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/data_width/axis_width_destruct_A1.sv'
self.path = File.expand_path(__FILE__)
port.axi_stream_inf.slaver - 'wide_axis' 
port.axi_stream_inf.master - 'slim_axis' 
end
