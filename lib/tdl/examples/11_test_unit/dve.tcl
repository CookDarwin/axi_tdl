
## 设置时间精度 1ps
gui_set_time_units 1ps

## 创建一个 group 名字为 test_gg
# set _wave_session_group Group1
# set _wave_session_group [gui_sg_generate_new_name -seed test_gg]

# set Group2 "$_wave_session_group"

## 添加信号到 group
## gui_sg_addsignal -group "$_wave_session_group" { {Sim:tb_Mammo_TCP_sim.g1_test_mac_1g_inst.test_fpga_version_inst.ctrl_udp_rd_version} {Sim:tb_Mammo_TCP_sim.rtl_top.fpga_version_verb.to_ctrl_tap_in_inf} {Sim:tb_Mammo_TCP_sim.rtl_top.fpga_version_verb.ctrl_tap_inf} {Sim:tb_Mammo_TCP_sim.g1_test_mac_1g_inst.tcp_udp_proto_workshop_1G_inst.genblk1[0].tcp_data_stack_top_inst.client_port} }
## ==== [add_signal] ===== ##

## -------------- sub_md0_logic -------------------------
set _wave_session_group_sub_md0_logic sub_md0_logic
# set _wave_session_group_sub_md0_logic [gui_sg_generate_new_name -seed sub_md0_logic]
if {[gui_sg_is_group -name "$_wave_session_group_sub_md0_logic"]} {
    set _wave_session_group_sub_md0_logic [gui_sg_generate_new_name]
}
set Group2_sub_md0_logic "$_wave_session_group_sub_md0_logic"

## 添加信号到 group
gui_sg_addsignal -group "$_wave_session_group_sub_md0_logic" {  {Sim:tb_exp_test_unit.rtl_top.sub_md0_inst.cnt}  }
## ============== sub_md0_logic =========================
        

## -------------- sub_md0_interface -------------------------
set _wave_session_group_sub_md0_interface sub_md0_interface
# set _wave_session_group_sub_md0_interface [gui_sg_generate_new_name -seed sub_md0_interface]
if {[gui_sg_is_group -name "$_wave_session_group_sub_md0_interface"]} {
    set _wave_session_group_sub_md0_interface [gui_sg_generate_new_name]
}
set Group2_sub_md0_interface "$_wave_session_group_sub_md0_interface"

## 添加信号到 group
gui_sg_addsignal -group "$_wave_session_group_sub_md0_interface" {  {Sim:tb_exp_test_unit.rtl_top.sub_md0_inst.axis_in}  }
## ============== sub_md0_interface =========================
        

## -------------- sub_md0_default -------------------------
set _wave_session_group_sub_md0_default sub_md0_default
# set _wave_session_group_sub_md0_default [gui_sg_generate_new_name -seed sub_md0_default]
if {[gui_sg_is_group -name "$_wave_session_group_sub_md0_default"]} {
    set _wave_session_group_sub_md0_default [gui_sg_generate_new_name]
}
set Group2_sub_md0_default "$_wave_session_group_sub_md0_default"

## 添加信号到 group
gui_sg_addsignal -group "$_wave_session_group_sub_md0_default" {  }
## ============== sub_md0_default =========================
        

## -------------- sub_md0_default.inter_tf -------------------------
## set _wave_session_group_sub_md0_default_inter_tf Group1
## set _wave_session_group_sub_md0_default_inter_tf [gui_sg_generate_new_name -seed inter_tf -parent $_wave_session_group_sub_md0_default ]

set _wave_session_group_sub_md0_default_inter_tf $_wave_session_group_sub_md0_default|
append _wave_session_group_sub_md0_default_inter_tf inter_tf
set sub_md0_default|inter_tf "$_wave_session_group_sub_md0_default_inter_tf"

# set Group2_sub_md0_default_inter_tf "$_wave_session_group_sub_md0_default_inter_tf"

## 添加信号到 group
gui_sg_addsignal -group "$_wave_session_group_sub_md0_default_inter_tf" {  {Sim:tb_exp_test_unit.rtl_top.sub_md0_inst.inter_tf}  }  
## ============== sub_md0_default.inter_tf =========================
        

## -------------- sub_md1_default -------------------------
set _wave_session_group_sub_md1_default sub_md1_default
# set _wave_session_group_sub_md1_default [gui_sg_generate_new_name -seed sub_md1_default]
if {[gui_sg_is_group -name "$_wave_session_group_sub_md1_default"]} {
    set _wave_session_group_sub_md1_default [gui_sg_generate_new_name]
}
set Group2_sub_md1_default "$_wave_session_group_sub_md1_default"

## 添加信号到 group
gui_sg_addsignal -group "$_wave_session_group_sub_md1_default" {  {Sim:tb_exp_test_unit.rtl_top.sub_md1_inst.cnt}  {Sim:tb_exp_test_unit.rtl_top.sub_md1_inst.axis_out}  {Sim:tb_exp_test_unit.rtl_top.sub_md1_inst.enable}  }
## ============== sub_md1_default =========================
        

## -------------- sub_md1_inner -------------------------
set _wave_session_group_sub_md1_inner sub_md1_inner
# set _wave_session_group_sub_md1_inner [gui_sg_generate_new_name -seed sub_md1_inner]
if {[gui_sg_is_group -name "$_wave_session_group_sub_md1_inner"]} {
    set _wave_session_group_sub_md1_inner [gui_sg_generate_new_name]
}
set Group2_sub_md1_inner "$_wave_session_group_sub_md1_inner"

## 添加信号到 group
gui_sg_addsignal -group "$_wave_session_group_sub_md1_inner" {  }
## ============== sub_md1_inner =========================
        

## -------------- sub_md1_inner.inter_tf -------------------------
## set _wave_session_group_sub_md1_inner_inter_tf Group1
## set _wave_session_group_sub_md1_inner_inter_tf [gui_sg_generate_new_name -seed inter_tf -parent $_wave_session_group_sub_md1_inner ]

set _wave_session_group_sub_md1_inner_inter_tf $_wave_session_group_sub_md1_inner|
append _wave_session_group_sub_md1_inner_inter_tf inter_tf
set sub_md1_inner|inter_tf "$_wave_session_group_sub_md1_inner_inter_tf"

# set Group2_sub_md1_inner_inter_tf "$_wave_session_group_sub_md1_inner_inter_tf"

## 添加信号到 group
gui_sg_addsignal -group "$_wave_session_group_sub_md1_inner_inter_tf" {  {Sim:tb_exp_test_unit.rtl_top.sub_md1_inst.inter_tf}  }  
## ============== sub_md1_inner.inter_tf =========================
        

## -------------- exp_test_unit_default -------------------------
set _wave_session_group_exp_test_unit_default exp_test_unit_default
# set _wave_session_group_exp_test_unit_default [gui_sg_generate_new_name -seed exp_test_unit_default]
if {[gui_sg_is_group -name "$_wave_session_group_exp_test_unit_default"]} {
    set _wave_session_group_exp_test_unit_default [gui_sg_generate_new_name]
}
set Group2_exp_test_unit_default "$_wave_session_group_exp_test_unit_default"

## 添加信号到 group
gui_sg_addsignal -group "$_wave_session_group_exp_test_unit_default" {  }
## ============== exp_test_unit_default =========================
        

## -------------- exp_test_unit_default.axis_data_inf -------------------------
## set _wave_session_group_exp_test_unit_default_axis_data_inf Group1
## set _wave_session_group_exp_test_unit_default_axis_data_inf [gui_sg_generate_new_name -seed axis_data_inf -parent $_wave_session_group_exp_test_unit_default ]

set _wave_session_group_exp_test_unit_default_axis_data_inf $_wave_session_group_exp_test_unit_default|
append _wave_session_group_exp_test_unit_default_axis_data_inf axis_data_inf
set exp_test_unit_default|axis_data_inf "$_wave_session_group_exp_test_unit_default_axis_data_inf"

# set Group2_exp_test_unit_default_axis_data_inf "$_wave_session_group_exp_test_unit_default_axis_data_inf"

## 添加信号到 group
gui_sg_addsignal -group "$_wave_session_group_exp_test_unit_default_axis_data_inf" {  {Sim:tb_exp_test_unit.rtl_top.axis_data_inf}  }  
## ============== exp_test_unit_default.axis_data_inf =========================
        

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
## -------------- Group2_sub_md0_logic -------------------------
gui_list_add_group -id ${Wave.3} -after {New Group} [list ${Group2_sub_md0_logic}]
## ============== Group2_sub_md0_logic =========================
## -------------- Group2_sub_md0_interface -------------------------
gui_list_add_group -id ${Wave.3} -after {New Group} [list ${Group2_sub_md0_interface}]
## ============== Group2_sub_md0_interface =========================
## -------------- Group2_sub_md0_default -------------------------
gui_list_add_group -id ${Wave.3} -after {New Group} [list ${Group2_sub_md0_default}]
## ============== Group2_sub_md0_default =========================
## -------------- sub_md0_default|inter_tf -------------------------
gui_list_add_group -id ${Wave.3} -after {New Group} [list ${sub_md0_default|inter_tf}]
## ============== sub_md0_default|inter_tf =========================
## -------------- Group2_sub_md1_default -------------------------
gui_list_add_group -id ${Wave.3} -after {New Group} [list ${Group2_sub_md1_default}]
## ============== Group2_sub_md1_default =========================
## -------------- Group2_sub_md1_inner -------------------------
gui_list_add_group -id ${Wave.3} -after {New Group} [list ${Group2_sub_md1_inner}]
## ============== Group2_sub_md1_inner =========================
## -------------- sub_md1_inner|inter_tf -------------------------
gui_list_add_group -id ${Wave.3} -after {New Group} [list ${sub_md1_inner|inter_tf}]
## ============== sub_md1_inner|inter_tf =========================
## -------------- Group2_exp_test_unit_default -------------------------
gui_list_add_group -id ${Wave.3} -after {New Group} [list ${Group2_exp_test_unit_default}]
## ============== Group2_exp_test_unit_default =========================
## -------------- exp_test_unit_default|axis_data_inf -------------------------
gui_list_add_group -id ${Wave.3} -after {New Group} [list ${exp_test_unit_default|axis_data_inf}]
## ============== exp_test_unit_default|axis_data_inf =========================

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
gui_list_set_insertion_bar  -id ${Wave.3} -group ${Group2_sub_md0_logic}  -position in
gui_list_set_insertion_bar  -id ${Wave.3} -group ${Group2_sub_md0_interface}  -position in
gui_list_set_insertion_bar  -id ${Wave.3} -group ${Group2_sub_md0_default}  -position in
gui_list_set_insertion_bar  -id ${Wave.3} -group ${Group2_sub_md1_default}  -position in
gui_list_set_insertion_bar  -id ${Wave.3} -group ${Group2_sub_md1_inner}  -position in
gui_list_set_insertion_bar  -id ${Wave.3} -group ${Group2_exp_test_unit_default}  -position in

gui_marker_move -id ${Wave.3} {C1} 560248001
gui_view_scroll -id ${Wave.3} -vertical -set 35
gui_show_grid -id ${Wave.3} -enable false
