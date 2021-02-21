
# add_to_all_file_paths('axis_direct','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_direct.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_direct.sv'
TdlBuild.axis_direct do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_direct.sv'
self.path = File.expand_path(__FILE__)
port.axi_stream_inf.slaver - 'slaver' 
port.axi_stream_inf.master - 'master' 
end
