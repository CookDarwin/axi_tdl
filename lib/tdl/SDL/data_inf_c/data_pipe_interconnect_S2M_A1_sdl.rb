
# add_to_all_file_paths('data_pipe_interconnect_S2M_A1','/home/CookDarwin/work/fpga/axi/data_interface/data_pipe_interconnect_S2M_A1.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_pipe_interconnect_S2M_A1.sv'
TdlBuild.data_pipe_interconnect_S2M_A1 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_pipe_interconnect_S2M_A1.sv'
self.path = File.expand_path(__FILE__)
parameter.DSIZE   8
parameter.NUM   8
parameter.NSIZE   NqString.new('$clog2(NUM)')
parameter.LAZISE   1
input - 'clock' 
input - 'rst_n' 
input - 'clk_en' 
input[ param.NSIZE] - 'addr' 
output[ param.NUM][ param.LAZISE] - 'm00_lazy_data' 
input[ param.LAZISE] - 's00_lazy_data' 
port.data_inf.master[ param.NUM] - 'm00' 
port.data_inf.slaver - 's00' 
end
