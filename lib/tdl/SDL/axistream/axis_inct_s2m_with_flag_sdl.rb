
# add_to_all_file_paths('axis_inct_s2m_with_flag','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_inct_s2m_with_flag.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_inct_s2m_with_flag.sv'
TdlBuild.axis_inct_s2m_with_flag do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_inct_s2m_with_flag.sv'
self.path = File.expand_path(__FILE__)
parameter.NUM   8
input[ param.NUM] - 'idle_flag' 
port.axi_stream_inf.slaver - 's00' 
port.axi_stream_inf.master[ param.NUM] - 'm00' 
end
