
# add_to_all_file_paths('data_inf_c_interconnect_M2S','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_inf_c_interconnect_M2S.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_inf_c_interconnect_M2S.sv'
TdlBuild.data_inf_c_interconnect_M2S do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/data_inf_c_interconnect_M2S.sv'
self.path = File.expand_path(__FILE__)
parameter.NUM   8
parameter.NSIZE   NqString.new('$clog2(NUM)')
parameter.PRIO   "OFF"
port.data_inf_c.slaver[ param.NUM] - 's00' 
port.data_inf_c.master - 'm00' 
end
