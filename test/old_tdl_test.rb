
require 'minitest/autorun'
# require 'tdl.rb'

class CptHDLTest < Minitest::Test

    # def before_setup

        files = []
        files <<  "2_hdl_class/always_comb"
        files <<  "2_hdl_class/always_ff"
        files <<  "2_hdl_class/case"
        files <<  "2_hdl_class/foreach"
        files <<  "2_hdl_class/function"
        files <<  "2_hdl_class/generate"
        files <<  "2_hdl_class/module_def"
        files <<  "2_hdl_class/module_head_import_package"
        files <<  "2_hdl_class/module_instance_test"
        files <<  "2_hdl_class/package"
        files <<  "2_hdl_class/package2"
        files <<  "2_hdl_class/simple_assign"
        files <<  "2_hdl_class/state_case"
        files <<  "2_hdl_class/struct_function"
        files <<  "2_hdl_class/struct"
        files <<  "2_hdl_class/test_initial_assert"
        files <<  "2_hdl_class/test_inst_sugar"
        files <<  "2_hdl_class/test_module_port"
        files <<  "2_hdl_class/test_module_var"
        files <<  "2_hdl_class/vcs_string"

        files.each do |e|
            define_method("test_"+File.basename(e)) do 
                require e 
            end
        end

    # end
        
    def setup 
        ::Tdl.PutsEnable = false
    end

    def test_define_module 
        require "1_define_module/example1"
    end

    def test_hdl_sdl_instance 
        require "3_hdl_sdl_instance/main.rb"
    end

    def test_4_generate
        require "4_generate/example"
    end

    def test_logic_combin 
        require "5_logic_combin/login_combin"
    end

    def test_module_with_interface
        require "6_module_with_interface/example"
        require "6_module_with_interface/inf_collect"
    end

    def test_module_with_package
        require "7_module_with_package/example_pkg"
    end

    def test_top_module 
        require "8_top_module/example"
    end

    def test_itegration_synth
        TopModule.sim = false
        require "9_itegration/top"
    end

    def test_itegration_sim
        TopModule.sim = true
        require "9_itegration/top"
    end

    def test_random 
        require "10_random/exp_random"
    end

    ## dont test unit in old mode
    # def test_tunit
    #     TopModule.sim = true
    #     require "11_test_unit/exp_test_unit"
    # end

    # def test_tunit_1
    #     TopModule.sim = false
    #     require "11_test_unit/exp_test_unit"
    # end


    # def test_hdl_class
        
    # end

    def teardown
    end

end