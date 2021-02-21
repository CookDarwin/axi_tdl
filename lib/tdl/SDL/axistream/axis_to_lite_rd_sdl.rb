
# add_to_all_file_paths('axis_to_lite_rd','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_to_lite_rd.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_to_lite_rd.sv'
TdlBuild.axis_to_lite_rd do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_to_lite_rd.sv'
self.path = File.expand_path(__FILE__)
parameter.DUMMY   8
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_stream_inf.master - 'rd_rel_axis' 
port.axi_lite_inf.master_rd - 'lite' 
end
