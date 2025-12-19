
# add_to_all_file_paths('axi_stream_interconnect_S2M_auto','/home/CookDarwin/work/fpga/axi/AXI_stream/axi_stream_interconnect_S2M_auto.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axi_stream_interconnect_S2M_auto.sv'
TdlBuild.axi_stream_interconnect_S2M_auto do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/axi_stream_interconnect_S2M_auto.sv'
self.path = File.expand_path(__FILE__)
parameter.HEAD_DUMMY   4
parameter.NUM   4
port.axi_stream_inf.slaver - 'slaver' 
port.axi_stream_inf.master[ param.NUM] - 'sub_tx_inf' 
end
