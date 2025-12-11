
# add_to_all_file_paths('axis_direct_A1','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_direct_A1.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_direct_A1.sv'
TdlBuild.axis_direct_A1 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_direct_A1.sv'
self.path = File.expand_path(__FILE__)
parameter.IDSIZE   8
parameter.ODSIZE   8
port.axi_stream_inf.slaver - 'slaver' 
port.axi_stream_inf.master - 'master' 
end
