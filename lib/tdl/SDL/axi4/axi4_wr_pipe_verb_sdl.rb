
# add_to_all_file_paths('axi4_wr_pipe_verb','/home/CookDarwin/work/fpga/axi/AXI4/axi4_pipe/axi4_wr_pipe_verb.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_pipe/axi4_wr_pipe_verb.sv'
TdlBuild.axi4_wr_pipe_verb do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/axi4_pipe/axi4_wr_pipe_verb.sv'
self.path = File.expand_path(__FILE__)
port.axi_inf.slaver_wr - 'slaver' 
port.axi_inf.master_wr - 'master' 
end
