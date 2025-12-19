
# add_to_all_file_paths('gen_big_field_table','/home/CookDarwin/work/fpga/axi/AXI_stream/gen_big_field_table.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/gen_big_field_table.sv'
TdlBuild.gen_big_field_table do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/gen_big_field_table.sv'
self.path = File.expand_path(__FILE__)
parameter.MASTER_MODE   "OFF"
parameter.DSIZE   8
parameter.FIELD_LEN   16*8
parameter.FIELD_NAME   "Big Filed"
input - 'enable' 
input[ param.DSIZE* param.FIELD_LEN] - 'value' 
port.axi_stream_inf.master - 'cm_tb' 
end
