
# add_to_all_file_paths('axis_head_cut','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_head_cut.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_head_cut.sv'
TdlBuild.axis_head_cut do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_head_cut.sv'
self.path = File.expand_path(__FILE__)
parameter.LEN   1
port.axi_stream_inf.slaver - 'slaver' 
port.axi_stream_inf.master - 'master' 
end
