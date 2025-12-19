
# add_to_all_file_paths('axis_ram_buffer','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_ram_buffer.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_ram_buffer.sv'
TdlBuild.axis_ram_buffer do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_ram_buffer.sv'
self.path = File.expand_path(__FILE__)
parameter.LENGTH   4096
input - 'wr_en' 
input - 'gen_en' 
output - 'gen_ready' 
port.axi_stream_inf.slaver - 'axis_wr_inf' 
port.axi_stream_inf.master - 'axis_data_inf' 
end
