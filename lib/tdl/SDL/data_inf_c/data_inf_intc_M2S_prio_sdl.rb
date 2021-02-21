
# add_to_all_file_paths('data_inf_intc_M2S_prio','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_intc_M2S_prio.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_intc_M2S_prio.sv'
TdlBuild.data_inf_intc_M2S_prio do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_intc_M2S_prio.sv'
self.path = File.expand_path(__FILE__)
parameter.NUM   8
parameter.NSIZE   NqString.new('$clog2(NUM)')
parameter.PRIO   "OFF"
input - 'clock' 
input - 'rst_n' 
port.data_inf.slaver[ param.NUM] - 's00' 
port.data_inf.master - 'm00' 
end
