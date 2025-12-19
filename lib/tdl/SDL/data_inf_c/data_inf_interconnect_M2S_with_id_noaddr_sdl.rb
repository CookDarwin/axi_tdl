
# add_to_all_file_paths('data_inf_interconnect_M2S_with_id_noaddr','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_interconnect_M2S_with_id_noaddr.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_interconnect_M2S_with_id_noaddr.sv'
TdlBuild.data_inf_interconnect_M2S_with_id_noaddr do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_interconnect_M2S_with_id_noaddr.sv'
self.path = File.expand_path(__FILE__)
parameter.NUM   8
parameter.IDSIZE   4
parameter.PRIO   "OFF"
parameter.NSIZE   NqString.new('$clog2(NUM)')
input - 'clock' 
input - 'rst_n' 
input[ param.NUM][ param.IDSIZE] - 'sid' 
output[ param.IDSIZE] - 'mid' 
port.data_inf.slaver[ param.NUM] - 's00' 
port.data_inf.master - 'm00' 
end
