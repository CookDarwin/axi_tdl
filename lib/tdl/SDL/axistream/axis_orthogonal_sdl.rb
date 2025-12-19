
# add_to_all_file_paths('axis_orthogonal','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_orthogonal.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_orthogonal.sv'
TdlBuild.axis_orthogonal do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_orthogonal.sv'
self.path = File.expand_path(__FILE__)
parameter.NUM   8
port.axi_stream_inf.slaver[ param.NUM] - 's00' 
port.axi_stream_inf.master[ param.NUM] - 'm00' 
end
