
# add_to_all_file_paths('parse_big_field_table_A2','/home/CookDarwin/work/fpga/axi/AXI_stream/parse_big_field_table_A2.sv')
# real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/parse_big_field_table_A2.sv'
TdlBuild.parse_big_field_table_A2 do 
self.real_sv_path = '/home/CookDarwin/work/fpga/axi/AXI_stream/parse_big_field_table_A2.sv'
self.path = File.expand_path(__FILE__)
parameter.DSIZE   8
parameter.FIELD_LEN   16*8
parameter.FIELD_NAME   "Big Filed"
parameter.TRY_PARSE   "OFF"
input - 'enable' 
output['(0+1- param.DSIZE* param.FIELD_LEN-1)'] - 'value' 
output - 'out_valid' 
port.axi_stream_inf.slaver - 'cm_tb_s' 
port.axi_stream_inf.master - 'cm_tb_m' 
port.axi_stream_inf.mirror - 'cm_mirror' 
end
