
# add_to_all_file_paths('axis_mirrors','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_mirrors.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_mirrors.sv'
TdlBuild.axis_mirrors do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_mirrors.sv'
self.path = File.expand_path(__FILE__)
parameter.H   0
parameter.L   0
parameter.NUM   8
parameter.MODE   "CDS_MODE"
input[( param.H+1- param.L)] - 'condition_data' 
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_stream_inf.master[ param.NUM] - 'axis_mirror' 
end
