
# add_to_all_file_paths('axis_master_empty','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_master_empty.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_master_empty.sv'
TdlBuild.axis_master_empty do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_master_empty.sv'
self.path = File.expand_path(__FILE__)
port.axi_stream_inf.master - 'master' 
end
