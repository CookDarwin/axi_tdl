
# add_to_all_file_paths('gen_origin_axis','/home/CookDarwin/work/fpga/axi/AXI_stream/gen_origin_axis.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/gen_origin_axis.sv'
TdlBuild.gen_origin_axis do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/gen_origin_axis.sv'
self.path = File.expand_path(__FILE__)
parameter.MODE   "RANGE"
input - 'enable' 
output - 'ready' 
input[32] - 'length' 
port.axi_stream_inf.master - 'axis_out' 
end
