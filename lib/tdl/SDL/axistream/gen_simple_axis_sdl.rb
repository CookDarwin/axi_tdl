
# add_to_all_file_paths('gen_simple_axis','/home/CookDarwin/work/fpga/axi/AXI_stream/gen_simple_axis.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/gen_simple_axis.sv'
TdlBuild.gen_simple_axis do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/gen_simple_axis.sv'
self.path = File.expand_path(__FILE__)
parameter.MODE   "RANGE"
input - 'trigger' 
input - 'gen_en' 
input[16] - 'length' 
output - 'led' 
port.axi_stream_inf.master - 'axis_out' 
end
