
# add_to_all_file_paths('data_inf_interconnect_M2S_noaddr','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_interconnect_M2S_noaddr.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_interconnect_M2S_noaddr.sv'
TdlBuild.data_inf_interconnect_M2S_noaddr do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_interconnect_M2S_noaddr.sv'
self.path = File.expand_path(__FILE__)
parameter.NUM   8
parameter.NSIZE   NqString.new('$clog2(NUM)')
parameter.PRIO   "OFF"
input - 'clock' 
input - 'rst_n' 
port.data_inf.slaver[ param.NUM] - 's00' 
port.data_inf.master - 'm00' 
end
