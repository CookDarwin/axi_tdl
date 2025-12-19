
# add_to_all_file_paths('next_prio','/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/next_prio.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/next_prio.sv'
TdlBuild.next_prio do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/data_interface/data_inf_c/next_prio.sv'
self.path = File.expand_path(__FILE__)
parameter.NUM   8
parameter.NSIZE   NqString.new('$clog2(NUM)')
input[ param.NSIZE] - 'curr_addr' 
input[ param.NUM] - 'array' 
output[ param.NSIZE] - 'next_addr' 
end
