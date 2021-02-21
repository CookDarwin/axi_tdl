
# add_to_all_file_paths('axis_link_trigger','/home/CookDarwin/work/fpga/axi/AXI_stream/axis_link_trigger.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_link_trigger.sv'
TdlBuild.axis_link_trigger do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axis_link_trigger.sv'
self.path = File.expand_path(__FILE__)
parameter.MODE   "STREAM"
parameter.DSIZE   32
input[ param.DSIZE] - 'data' 
port.axi_stream_inf.mirror - 'mirror' 
port.data_inf_c.master - 'trigger_inf' 
end
