module TdlSpace 
    def self.dve_tcl_temp(add_signal, add_signal_wave, add_bar)
        %Q{
## 设置时间精度 1ps
gui_set_time_units 1ps

## 创建一个 group 名字为 test_gg
# set _wave_session_group Group1
# set _wave_session_group [gui_sg_generate_new_name -seed test_gg]

# set Group2 "$_wave_session_group"

## 添加信号到 group
## gui_sg_addsignal -group "$_wave_session_group" { {Sim:tb_Mammo_TCP_sim.g1_test_mac_1g_inst.test_fpga_version_inst.ctrl_udp_rd_version} {Sim:tb_Mammo_TCP_sim.rtl_top.fpga_version_verb.to_ctrl_tap_in_inf} {Sim:tb_Mammo_TCP_sim.rtl_top.fpga_version_verb.ctrl_tap_inf} {Sim:tb_Mammo_TCP_sim.g1_test_mac_1g_inst.tcp_udp_proto_workshop_1G_inst.genblk1[0].tcp_data_stack_top_inst.client_port} }
## ==== [add_signal] ===== ##
#{add_signal}

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
#{add_signal_wave}

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
#{add_bar}

gui_marker_move -id ${Wave.3} {C1} 560248001
gui_view_scroll -id ${Wave.3} -vertical -set 35
gui_show_grid -id ${Wave.3} -enable false
}
    end

    def self.dev_signals_to_tcl(flag: gname ,signals: [])
        sst = %Q{
## -------------- #{flag} -------------------------
set _wave_session_group_#{flag} #{flag}
# set _wave_session_group_#{flag} [gui_sg_generate_new_name -seed #{flag}]
if {[gui_sg_is_group -name "$_wave_session_group_#{flag}"]} {
    set _wave_session_group_#{flag} [gui_sg_generate_new_name]
}
set Group2_#{flag} "$_wave_session_group_#{flag}"

## 添加信号到 group
gui_sg_addsignal -group "$_wave_session_group_#{flag}" { #{signals.map{|e| " {#{e}} "}.join("") } }
## ============== #{flag} =========================
        }
    end

    def self.dev_interface_to_tcl(flag: gname, iname: '' , signals: [])
        sst = %Q{
## -------------- #{flag}.#{iname} -------------------------
## set _wave_session_group_#{flag}_#{iname} Group1
## set _wave_session_group_#{flag}_#{iname} [gui_sg_generate_new_name -seed #{iname} -parent $_wave_session_group_#{flag} ]

set _wave_session_group_#{flag}_#{iname} $_wave_session_group_#{flag}|
append _wave_session_group_#{flag}_#{iname} #{iname}
set #{flag}|#{iname} "$_wave_session_group_#{flag}_#{iname}"

# set Group2_#{flag}_#{iname} "$_wave_session_group_#{flag}_#{iname}"

## 添加信号到 group
gui_sg_addsignal -group "$_wave_session_group_#{flag}_#{iname}" { #{signals.map{|e| " {#{e}} "}.join("") } }  
## ============== #{flag}.#{iname} =========================
        }
    end

    def self.gui_list_add_group(flag: gname)
        "## -------------- #{flag} -------------------------\ngui_list_add_group -id ${Wave.3} -after {New Group} [list ${#{flag}}]\n## ============== #{flag} ========================="
    end

    def self.gui_list_set_insertion_bar(flag: gname)
        "gui_list_set_insertion_bar  -id ${Wave.3} -group ${Group2_#{flag}}  -position in"
    end

    def self.gen_dev_wave_tcl(khash) # {group_name : [*signal]}
        add_ss = []
        add_list = []
        add_bar = []
        khash.each do |k,v|
            base_elms = []
            intf_elms = []
            v.each do |e|
                if e.is_a?(BaseElm) || e.is_a?(ClassHDL::EnumStruct) || e.is_a?(ClassHDL::StructVar)
                    base_elms   << e 
                elsif e.is_a? TdlSpace::TdlBaseInterface
                    if e.modport_type
                        base_elms   << e 
                    else
                        intf_elms   << e 
                    end
                end
            end
            signals = base_elms.map do |e| 
                unless e.tp_instance.filter_block
                    e.root_ref.sub("$root.","Sim:") 
                else
                    e.root_ref(&e.tp_instance.filter_block).sub("$root.","Sim:") 
                end
            end

            add_ss  << dev_signals_to_tcl(flag: k, signals: signals )

            intf_elms.each do |e|

                unless e.tp_instance.filter_block
                    signalx = e.root_ref.sub("$root.","Sim:") 
                else
                    signalx = e.root_ref(&e.tp_instance.filter_block).sub("$root.","Sim:") 
                end

                add_ss << dev_interface_to_tcl(flag: k, iname: e.inst_name ,signals: [ signalx ])
            end
            add_list << gui_list_add_group(flag: "Group2_#{k}")
            add_bar  << gui_list_set_insertion_bar(flag: k)

            intf_elms.each do |e|
                add_list <<  gui_list_add_group(flag: "#{k}|#{e.inst_name}")
            end
        end

        dve_tcl_temp(add_ss.join("\n"), add_list.join("\n"), add_bar.join("\n") )

    end

end