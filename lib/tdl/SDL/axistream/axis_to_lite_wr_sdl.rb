
# add_to_all_file_paths('axis_to_lite_wr','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_to_lite_wr.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_to_lite_wr.sv'
TdlBuild.axis_to_lite_wr do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_to_lite_wr.sv'
self.path = File.expand_path(__FILE__)
parameter.DUMMY   8
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_lite_inf.master_wr - 'lite' 
end
