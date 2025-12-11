require_relative "./../tdl.rb"
#
AutoGenSdl.new('../../axi/AXI4/axi4_long_to_axi4_wide_verb.sv','../SDL/axi4').auto_rb


# # fifo
out_path = '../SDL/fifo'
file_list = path_scan('../../axi/common_fifo',/.sv$/i)

file_list.each do |e|
    a = AutoGenSdl.new(e,out_path)
    a.auto_rb if a
end


# # Axi4
out_path = '../SDL/axi4'
file_list = path_scan('../../axi/AXI4/',/.sv$/i)

def exist_same_name_sdl(e)
    sdl_file = e.sub(/\.sv$/,".rb")
    File.exist? sdl_file
end

file_list.each do |e|
    unless exist_same_name_sdl(e)
        a = AutoGenSdl.new(e,out_path)
        a.auto_rb if a
    end
end

# # Axi4 Lite
# out_path = '..\SDL\axilite'
# file_list = path_scan('..\..\axi\AXI_Lite',/.sv$/i)
#
# file_list.each do |e|
#     a = AutoGenSdl.new(e,out_path)
#     a.auto_rb if a
# end

# # Axi Stream
out_path = '../SDL/axistream'
file_list = path_scan('../../axi/AXI_stream',/.sv$/i)

file_list.each do |e|
    unless exist_same_name_sdl(e)
        # if (e !~ /_common_frame_/) && (e !~ /parse_/)
        if (e !~ /_common_frame_/)
            a = AutoGenSdl.new(e,out_path)
            a.auto_rb if a
        end
    end
end

# # data_inf_c
out_path = '../SDL/data_inf_c'
file_list = path_scan('../../axi/data_interface',/.sv$/i)

file_list.each do |e|
    a = AutoGenSdl.new(e,out_path)
    a.auto_rb if a
end

# # data_inf
# out_path = '../SDL/data_inf_c'
# file_list = path_scan('../../axi/data_interface',/.sv$/i)

# file_list.each do |e|
#     a = AutoGenSdl.new(e,out_path)
#     a.auto_rb if a
# end

# AutoGenSdl.new('/home/CookDarwin/work/FPGA/NRISC_20200518/git_repo/tpu/RTL/xilinx_hdl_dpram.sv','/home/CookDarwin/work/FPGA/NRISC_20200518/git_repo/tpu/RTL/').auto_rb
