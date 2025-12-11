
# add_to_all_file_paths('gen_origin_axis_A1','/home/CookDarwin/work/fpga/axi/AXI_stream/gen_origin_axis_A1.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/gen_origin_axis_A1.sv'
TdlBuild.gen_origin_axis_A1 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/gen_origin_axis_A1.sv'
self.path = File.expand_path(__FILE__)
parameter.MODE   "RANGE"
input - 'enable' 
output - 'ready' 
input[32] - 'length' 
input[32] - 'start' 
port.axi_stream_inf.master - 'axis_out' 
end
