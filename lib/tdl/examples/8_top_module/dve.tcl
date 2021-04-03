
## 设置时间精度 1ps
gui_set_time_units 1ps

## 创建一个 group 名字为 test_gg
# set _wave_session_group Group1
# set _wave_session_group [gui_sg_generate_new_name -seed test_gg]

# set Group2 "$_wave_session_group"

## 添加信号到 group
## gui_sg_addsignal -group "$_wave_session_group" { {Sim:tb_Mammo_TCP_sim.g1_test_mac_1g_inst.test_fpga_version_inst.ctrl_udp_rd_version} {Sim:tb_Mammo_TCP_sim.rtl_top.fpga_version_verb.to_ctrl_tap_in_inf} {Sim:tb_Mammo_TCP_sim.rtl_top.fpga_version_verb.ctrl_tap_inf} {Sim:tb_Mammo_TCP_sim.g1_test_mac_1g_inst.tcp_udp_proto_workshop_1G_inst.genblk1[0].tcp_data_stack_top_inst.client_port} }
## ==== [add_signal] ===== ##


## 创建波形窗口
if {![info exists useOldWindow]} { 
    set useOldWindow true
}

if {$useOldWindow && [string first "Wave" [gui_get_current_window -view]]==0} { 
    set Wave.3 [gui_get_current_window -view] 
} else {
    set Wave.3 [lindex [gui_get_window_ids -type Wave] 0]
    if {[string first "Wave" ${Wave.3}]!=0} {
        gui_open_window Wave
        set Wave.3 [ gui_get_current_window -view ]
    }
}

set groupExD [gui_get_pref_value -category Wave -key exclusiveSG]
gui_set_pref_value -category Wave -key exclusiveSG -value {false}
set origWaveHeight [gui_get_pref_value -category Wave -key waveRowHeight]
gui_list_set_height -id Wave -height 25
set origGroupCreationState [gui_list_create_group_when_add -wave]
gui_list_create_group_when_add -wave -disable
gui_marker_set_ref -id ${Wave.3}  C1
gui_wv_zoom_timerange -id ${Wave.3} 0 1000000000
## gui_list_add_group -id ${Wave.3} -after {New Group} [list ${Group2}]
## gui_list_add_group -id ${Wave.3}  -after ${Group2} [list ${Group2|tx_inf}]
## gui_list_expand -id ${Wave.3} tb_Mammo_TCP_sim.rtl_top.fpga_version_verb.ctrl_tap_inf
## === [add_signal_wave] === ##


gui_seek_criteria -id ${Wave.3} {Any Edge}


gui_set_pref_value -category Wave -key exclusiveSG -value $groupExD
gui_list_set_height -id Wave -height $origWaveHeight
if {$origGroupCreationState} {
    gui_list_create_group_when_add -wave -enable
}
if { $groupExD } {
    gui_msg_report -code DVWW028
}
gui_list_set_filter -id ${Wave.3} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Wave.3} -text {*}
##gui_list_set_insertion_bar  -id ${Wave.3} -group ${Group2}  -position in
## === [add_bar] === ##


gui_marker_move -id ${Wave.3} {C1} 560248001
gui_view_scroll -id ${Wave.3} -vertical -set 35
gui_show_grid -id ${Wave.3} -enable false
