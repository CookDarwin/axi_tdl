
# add_to_all_file_paths('axi4_rd_burst_track','/home/CookDarwin/work/fpga/axi/AXI4/axi4_rd_burst_track.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_rd_burst_track.sv'
TdlBuild.axi4_rd_burst_track do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_rd_burst_track.sv'
self.path = File.expand_path(__FILE__)
parameter.MAX_LEN   16
parameter.MAX_CYCLE   1000
port.axi_inf.mirror_rd - 'axi4_mirror' 
end
