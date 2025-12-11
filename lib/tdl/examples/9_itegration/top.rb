require_relative "../../tdl.rb"
require_relative "./A_itgt/itgt_module_a_block.rb"
require_relative "./clock_manage/itgt_module_clock_manage.rb"

TopModule.test_tttop(__dir__) do 
    load_pins File.join(__dir__, 'pins.yml')

    clk_inst = add_itegration('ClockManage',pins_map: :CM)
    add_itegration('ABlock')

    add_test_unit(clk_inst.test_clock_bb)
end