
add_to_tdl_paths __dir__

require_sdl 'simple_clock.rb'

class ClockManage < ItegrationVerb

    param   :freqM, 100

    link_explort :clock_100M, :rstn_100M

    top_module_eval do |itgt|

        simple_clock.simple_clock_inst do |h|
            h.input.sys_clk     input(pin_prop:itgt.pins_map[:SYS_CLK]).clock(30.25).global_sys_clk    
            h.output.clock      logic.clock(itgt.freqM).clock_100M
            h.output.rst_n      logic.reset('low').rstn_100M
        end
    end

    top_module_techbench_eval do |itgt|
        logic - 'gl_clk'

        rtl_top[itgt.global_sys_clk.name]  = gl_clk

        Initial do 
            initial_exec("forever begin #(33ns);#{gl_clk} = ~#{gl_clk};end")
        end

    end

    def_test_unit('test_clock_xx',__dir__) do 
        test_unit_init do 

        end
    end

    def_test_unit('test_clock_bb',__dir__) do 
        test_unit_init do 

        end
    end


end

