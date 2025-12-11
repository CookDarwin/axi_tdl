
# add_to_all_file_paths('axis_slaver_vector_empty','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_slaver_vector_empty.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_slaver_vector_empty.sv'
TdlBuild.axis_slaver_vector_empty do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_slaver_vector_empty.sv'
self.path = File.expand_path(__FILE__)
parameter.NUM   4
port.axi_stream_inf.slaver[ param.NUM] - 'slaver' 
end
