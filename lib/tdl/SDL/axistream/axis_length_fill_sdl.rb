
# add_to_all_file_paths('axis_length_fill','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_length_fill.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_length_fill.sv'
TdlBuild.axis_length_fill do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_length_fill.sv'
self.path = File.expand_path(__FILE__)
input[16] - 'length' 
port.axi_stream_inf.slaver - 'axis_in' 
port.axi_stream_inf.master - 'axis_out' 
end
