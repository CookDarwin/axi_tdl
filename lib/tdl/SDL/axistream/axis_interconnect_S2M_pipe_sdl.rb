
# add_to_all_file_paths('axis_interconnect_S2M_pipe','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_interconnect_S2M_pipe.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_interconnect_S2M_pipe.sv'
TdlBuild.axis_interconnect_S2M_pipe do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_interconnect_S2M_pipe.sv'
self.path = File.expand_path(__FILE__)
parameter.NUM   8
parameter.DEPTH   4
parameter.NSIZE   NqString.new('$clog2(NUM) ')
input - 'addr_vld' 
output - 'addr_rdy' 
input[ param.NSIZE] - 'addr' 
port.axi_stream_inf.slaver - 's00' 
port.axi_stream_inf.master[ param.NUM] - 'm00' 
end
