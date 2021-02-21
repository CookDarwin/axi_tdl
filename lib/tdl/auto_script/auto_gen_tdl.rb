require_relative "./../Tdl"

# axi stream
out_path = '..\..\tdl\axi_stream'
file_list = path_scan('..\..\axi\AXI_stream',/.sv/i)

file_list.each do |e|
    a = AutoGenTdl.new(e,out_path)
    a.auto_rb if a
end
#
# axi4
out_path = '..\..\tdl\axi4'
file_list = path_scan('..\..\axi\AXI4',/.sv/i)

file_list.each do |e|
    a = AutoGenTdl.new(e,out_path)
    a.auto_rb if a
end
#
# # data inf
out_path = '..\..\tdl\data_inf'
AutoGenTdl.new('..\..\axi\common_fifo\common_fifo.sv',out_path).auto_rb
AutoGenTdl.new('..\..\axi\common_fifo\independent_clock_fifo.sv',out_path).auto_rb
file_list = path_scan('..\..\axi\data_interface',/.sv/i)

file_list.each do |e|
    a = AutoGenTdl.new(e,out_path)
    a.auto_rb if a
end
# #
# out_path = '..\..\tdl\axi_stream'
# AutoGenTdl.new('..\..\axi\AXI_stream\axis_length_fill.sv',out_path).auto_rb
# AutoGenTdl.new('..\..\axi\AXI_stream\parse_big_field_table_A2.sv',out_path).auto_rb
#
# AutoGenTdl.new('..\..\axi\AXI4\axi4_combin_wr_rd_batch.sv','..\..\tdl\axi4').auto_rb
# AutoGenTdl.new('..\..\axi\AXI4\axi4_direct_A1.sv','..\..\tdl\axi4').auto_rb
#
AutoGenTdl.new('..\..\axi\AXI_Lite\axi_lite_master_empty.sv','..\..\tdl\axi_lite').auto_rb
AutoGenTdl.new('..\..\axi\AXI_Lite\axi_lite_slaver_empty.sv','..\..\tdl\axi_lite').auto_rb
#
# AutoGenTdl.new('..\..\axi\AXI_stream\stream_cache\axi_stream_cache_B1.sv','..\..\tdl\axi_stream').auto_rb
AutoGenTdl.new('..\..\axi\AXI_stream\axis_connect_pipe.sv','..\..\tdl\axi_stream').auto_rb
#
AutoGenTdl.new('..\..\axi\AXI_Lite\common_configure_reg_interface\jtag_to_axilite_wrapper.sv','..\..\tdl\axi_lite').auto_rb
# AutoGenTdl.new('..\..\axi\AXI4\axi4_direct_verb.sv','..\..\tdl\axi4').auto_rb
# AutoGenTdl.new('..\..\axi\AXI4\axi4_long_to_axi4_wide_verb.sv','..\..\tdl\axi4').auto_rb
# AutoGenTdl.new('..\..\axi\data_interface\data_inf_c\data_c_direct_mirror.sv','..\..\tdl\data_inf').auto_rb

