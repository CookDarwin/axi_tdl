
# add_to_all_file_paths('id_record','/home/CookDarwin/work/fpga/axi/AXI4/id_record.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/id_record.sv'
TdlBuild.id_record do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI4/id_record.sv'
self.path = File.expand_path(__FILE__)
parameter.LEN   16
parameter.IDSIZE   NqString.new('$clog2(LEN)')
input - 'clock' 
input - 'rst_n' 
input[ param.IDSIZE] - 'set_id' 
input - 'set_vld' 
input[ param.IDSIZE] - 'clear_id' 
input - 'clear_vld' 
input[ param.IDSIZE] - 'read_id' 
input - 'read_en' 
output - 'result' 
output - 'full' 
end
