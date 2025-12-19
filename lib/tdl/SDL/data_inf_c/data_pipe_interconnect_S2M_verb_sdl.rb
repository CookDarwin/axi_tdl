
# add_to_all_file_paths('data_pipe_interconnect_S2M_verb','/home/CookDarwin/work/fpga/axi/data_interface/data_pipe_interconnect_S2M_verb.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_pipe_interconnect_S2M_verb.sv'
TdlBuild.data_pipe_interconnect_S2M_verb do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_pipe_interconnect_S2M_verb.sv'
self.path = File.expand_path(__FILE__)
parameter.NUM   8
parameter.NSIZE   NqString.new('$clog2(NUM)')
input - 'clock' 
input - 'rst_n' 
input - 'clk_en' 
input[ param.NSIZE] - 'addr' 
port.data_inf.master[ param.NUM] - 'm00' 
port.data_inf.slaver - 's00' 
end
