
# add_to_all_file_paths('data_pipe_interconnect_M2S_verb','/home/CookDarwin/work/fpga/axi/data_interface/data_pipe_interconnect_M2S_verb.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_pipe_interconnect_M2S_verb.sv'
TdlBuild.data_pipe_interconnect_M2S_verb do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_pipe_interconnect_M2S_verb.sv'
self.path = File.expand_path(__FILE__)
parameter.DSIZE   8
parameter.NUM   8
parameter.NSIZE   NqString.new('$clog2(NUM)')
input - 'clock' 
input - 'rst_n' 
input - 'clk_en' 
input[ param.NSIZE] - 'addr' 
port.data_inf.slaver[ param.NUM] - 's00' 
port.data_inf.master - 'm00' 
end
