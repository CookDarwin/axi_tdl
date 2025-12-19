
# add_to_all_file_paths('axis_mirror_to_master','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_mirror_to_master.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_mirror_to_master.sv'
TdlBuild.axis_mirror_to_master do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_mirror_to_master.sv'
self.path = File.expand_path(__FILE__)
parameter.DEPTH   4
port.axi_stream_inf.mirror - 'mirror' 
port.axi_stream_inf.master - 'master' 
end
