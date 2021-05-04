$__start_time__ = Time.now
# require_relative "./tdlerror"
require_relative './tdlerror/tdlerror'
require_relative './global_scan'
require_relative "./basefunc"
# require_relative "./exlib/element_class_vars" #test
# require_relative "./exlib/global_param"
require_relative "./elements/originclass"
require_relative "./elements/clock"
require_relative "./elements/Reset"
require_relative "./elements/logic"
# require_relative "./elements/data_inf"
# require_relative "./elements/axi_stream"
# require_relative "./elements/axi4"
require_relative "./elements/parameter"
# require_relative "./elements/videoinf"
# require_relative "./elements/axi_lite"
require_relative "./elements/mail_box"
# require_relative "./elements/track_inf"
# require_relative "./elements/common_configure_reg"

# require_relative "./bfm/bfm_lib"

## 引入 ClassHDL 语法
require_relative "./class_hdl/hdl_assign.rb"
require_relative "./class_hdl/hdl_redefine_opertor.rb"
require_relative "./class_hdl/hdl_block_ifelse.rb"
require_relative "./class_hdl/hdl_always_comb.rb"
require_relative "./class_hdl/hdl_always_ff.rb"
require_relative "./class_hdl/hdl_data.rb"
require_relative "./class_hdl/hdl_module_def.rb"
require_relative "./class_hdl/hdl_generate.rb"
require_relative "./class_hdl/hdl_parameter.rb"
require_relative "./class_hdl/hdl_struct.rb"
require_relative "./class_hdl/hdl_package.rb"
require_relative "./class_hdl/hdl_foreach.rb"
require_relative "./class_hdl/hdl_initial.rb"
require_relative "./class_hdl/hdl_verify.rb"
require_relative "./class_hdl/hdl_random.rb"

require_relative "./Logic/logic_latency.rb"
require_relative "./Logic/logic_edge.rb"

# PackClassVars.require_element       # test

# require_relative "./axi_stream/axi_stream_lib"
# require_relative "./axi4/axi4_lib"
# require_relative "./data_inf/path_lib"
# require_relative "./VideoInf/video_lib"
# require_relative "./axi_lite/prj_lib"

# require_relative "./auto_script/autogentdl_a2"
require_relative "./auto_script/autogensdl"
# require_relative "./tdlmodule"
# require_relative "./tdlmodule_ports_define"
# require_relative "./tdlhash"
# require_relative "./bfm/bfm_lib"

require_relative './sdlmodule/sdlmodule.rb'
require_relative './sdlmodule/sdlmodule_port_define.rb'
require_relative './sdlmodule/sdlmodule_draw.rb'
require_relative './sdlmodule/sdlmodule_instance.rb'
require_relative './sdlmodule/sdlmodule_varible.rb'
require_relative "./sdlmodule/sdlmodule_vcs_comptable.rb"
# require_relative './sdlmodule/sdlmodule_varible_ex.rb'
require_relative './sdlmodule/sdlmodule_arraychain.rb'
require_relative './sdlmodule/techbench_module'
require_relative './sdlmodule/top_module'
require_relative './sdlmodule/generator_block_module'

## 补充 sdlmodule_arraychain
require_relative "./class_hdl/hdl_function.rb"
require_relative "./class_hdl/hdl_ex_defarraychain.rb"

## 添加新的重建接口 
require_relative "./rebuild_ele/ele_base.rb"
require_relative "./rebuild_ele/axi_stream.rb"
require_relative "./rebuild_ele/axi4.rb"
require_relative "./rebuild_ele/data_inf.rb"
require_relative "./rebuild_ele/data_inf_c.rb"
require_relative "./rebuild_ele/axi_lite.rb"
require_relative "./rebuild_ele/cm_ram_inf_define.rb"

## 添加axis 流slice功能
require_relative "./exlib/axis_eth_ex.rb"

require_relative "./bfm/axi_stream/axi_stream_bfm.rb"

require_relative "./exlib/constraints"
require_relative "./exlib/constraints_verb"
require_relative "./exlib/itegration"
require_relative "./exlib/itegration_verb"
require_relative "./exlib/parse_argv"
# require_relative "./tdlmodule_ex"
# require_relative "./SDL/path_lib"     # require sdlmodule
## VSC COMPATABLE support 
require_relative "./SDL/vcs_axi4_comptable.rb"
require_relative "./SDL/vcs_data_c_comptable.rb"
require_relative "./SDL/vcs_axis_comptable.rb"

## 添加 M2S方法
require_relative "./axi_stream/axi_stream_interconnect.rb"
require_relative "./data_inf/data_c_interconnect.rb"
require_relative "./axi4/axi4_interconnect_verb.rb"

## add sdl implement
require_relative "./sdlimplement/sdl_impl_param.rb"
require_relative "./sdlimplement/sdl_impl_module.rb"

## 定义直接对 HDL的引用 基于 autogensdl
require_relative "./auto_script/import_hdl.rb"
## 定义直接引用 TDL Module
require_relative "./auto_script/import_sdl.rb"

## 信号添加测试点
require_relative "./exlib/test_point.rb"
## 添加测试用例
# require_relative "./exlib/sdlmodule_sim.rb"
require_relative "./sdlmodule/test_unit_module.rb"

## 添加 DVE TCL 支持
require_relative "./exlib/dve_tcl.rb"

## 添加 verify 
require_relative "./exlib/axis_verify.rb"
require_relative "./exlib/clock_reset_verify.rb"
require_relative "./exlib/logic_verify.rb"


## --- INIT BLOCK Methods -----
# AutoGenSdl.add_inf_parse TrackInf.method(:parse_ports)
# SdlInst.add_inst_t0_method TrackInf.method(:sdlinst_t0)

# AutoGenSdl.add_inf_parse CommonCFGReg.method(:parse_ports)
# SdlInst.add_inst_t0_method CommonCFGReg.method(:sdlinst_t0)

## === INIT BLOCK Methods =====
$argvs_hash = {}
$argvs_hash = Parser.parse($TdlARGV || ARGV) 
TopModule.sim = $argvs_hash[:sim]
TopModule.itgt_implicit_reject = $argvs_hash[:itgt_implicit_reject]
class Tdl

    def self.comment(c="-",info="_____")
        "\n//#{c*4}>> #{info} <<#{c*40}\n"
    end
end

class Tdl
    @@Axi4Path = 'E:\work\AXI'

    def self.Axi4Path
        @@Axi4Path
    end

    def self.Axi4Path=(a)
        TdlError.new("#{a.to_s} is not exist") unless File.exist? a
        @@Axi4Path = a
    end

end

def require_axi4path(a)
    require_relative File.join(Tdl.Axi4Path,a)
end

## second load lib
# require_relative "./bfm/bfm_lib" ## test
# require_relative "./exlib/common_cfg_reg_inf"

class Tdl # add file paths

    def self.add_to_all_file_paths(a,b)

        unless b
            raise TdlError.new("FilePath Path[#{b}] can be nil")
        end

         @@all_file_paths ||= Hash.new
         if @@all_file_paths.keys.include? a
             if @@all_file_paths[a] != b
                 raise TdlError.new("FilePath confuse, Module <<#{a}>> in tow paths <<#{@@all_file_paths[a]}>>,<<#{b}>>")
             end
         else
             @@all_file_paths[a] = b
         end

     end

     def self.all_file_paths
         @@all_file_paths ||= Hash.new
     end


end

# require_relative "./exlib/integral_test/integral_test" #test
# require_relative './exlib/integral_test/clock_itest'  #test
# require_path_and_ignore(File.join(__dir__,'\exlib\integral_test'),File.join(__dir__,'\exlib\integral_test\auto')) #test
# require_relative "./exlib/common_cfg_reg_inf"

class Tdl
    @@puts_enable = $argvs_hash[:info]
    @@build_tdlmodule_collect = []
    @@build_sdlmodule_collect = []
    @@warning_collect = []

    def self.PutsEnable=(a)
        @@puts_enable = a
    end

    def self.PutsEnable
        @@puts_enable
    end

    def self.Puts(*args)
        puts args if @@puts_enable
    end

    def self.Build_TdlModule_Puts(args)
        return unless @@puts_enable
        @@build_tdlmodule_collect << args
    end

    def self.Build_SdlModule_Puts(args)
        return unless @@puts_enable
        @@build_sdlmodule_collect << args
    end

    def self.warning(argv,filename=nil,line=nil)
        # if line
        #     argv = "\n    LINE[#{line}]\n        >>>#{argv}"
        # end

        if filename
            argv = "\n    [FILE] #{filename}(#{line})\n    >>>>#{argv}"
        end

        @@warning_collect << argv
    end

    ## log puts

    def self.log_array(info,ay)
        if ay.any?
            Tdl.Puts pagination(info)
            ay.each_index do |index|
                puts "[#{index}] : #{ay[index].to_s}"
            end
        end
    end

    def self.puts_log
        return unless @@puts_enable
        if @@build_tdlmodule_collect.empty? && @@build_sdlmodule_collect.empty? && @@warning_collect.empty?
            return
        end
        ##
        self.log_array("LOG FOR GEN TDLMOUDLE",@@build_tdlmodule_collect)
        self.log_array("LOG FOR GEN SDLMOUDLE",@@build_sdlmodule_collect)
        self.log_array("LOG OF WARNING",@@warning_collect)
        # puts(page(tag: "SUMMARY" ,body: "RUN @ TIME : #{Time.now}"))
        puts(pagination("TEST POINT")) if TopModule.current
        # puts TdlTestPoint.echo_list
        # puts(pagination("SIM TEST"))
        # puts TdlSimTest::TdlBaseTestUnit.echo_prj_test_list
        puts SdlModule.echo_tracked_by_dve if TopModule.current && TopModule.sim
        puts(pagination("TEST UNIT")) if TopModule.current
        # puts TopModule.current.test_unit.echo_units if TopModule.current
        puts TestUnitModule.echo_be_instanced_by_sim if TopModule.current
        puts(pagination("SUMMARY"))
        puts "#{TopModule.sim ? 'SIM' : 'SYNTH'} RUN SPEND #{Time.now - $__start_time__} sec @ TIME : #{Time.now}"

    end

end

# require_relative "./SDL/path_lib"     # require sdlmodule

at_exit {
    Tdl.puts_log
}
