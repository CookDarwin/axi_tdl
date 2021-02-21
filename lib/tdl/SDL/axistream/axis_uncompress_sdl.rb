
# add_to_all_file_paths('axis_uncompress','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_uncompress.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_uncompress.sv'
TdlBuild.axis_uncompress do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_uncompress.sv'
self.path = File.expand_path(__FILE__)
parameter.ASIZE   8
parameter.LSIZE   8
port.axi_stream_inf.slaver - 'axis_zip' 
port.axi_stream_inf.master - 'axis_unzip' 
end
