
# add_to_all_file_paths('axi4_wr_packet_fifo','/home/CookDarwin/work/fpga/axi/AXI4/packet_fifo/axi4_wr_packet_fifo.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/packet_fifo/axi4_wr_packet_fifo.sv'
TdlBuild.axi4_wr_packet_fifo do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/packet_fifo/axi4_wr_packet_fifo.sv'
self.path = File.expand_path(__FILE__)
parameter.PIPE   "OFF"
parameter.DEPTH   4
port.axi_inf.slaver_wr - 'axi_in' 
port.axi_inf.master_wr - 'axi_out' 
end
