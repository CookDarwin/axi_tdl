require_relative '../../tdl.rb'
add_to_tdl_paths File.join(__dir__, '/modules')

require_sdl 'sub_md0.rb'
require_sdl 'sub_md1.rb'


TopModule.exp_test_unit(__dir__) do 
    input.clock(100)    - 'clock'
    input.reset('low')  - 'rst_n'

    axi_stream_inf(clock: clock, reset: rst_n, dsize: 8)    - 'axis_data_inf'

    sub_md1.sub_md1_inst do |h|
        h.port.axis.master.axis_out     axis_data_inf
        h.output.logic.enable           logic.enable
    end

    sub_md0.sub_md0_inst do |h|
        h.port.axis.slaver.axis_in      axis_data_inf
        h.input.logic.enable            enable
    end

    ## CREATE TEST POINT
    axis_data_inf.create_tp(' top test point',__FILE__,__LINE__)    - 'axis_data_inf'

    TdlTestUnit.tu0(__dir__) do 
        add_to_dve_wave TdlTestPoint.sub_md1.enable_tp
        add_to_dve_wave(TdlTestPoint.sub_md0.tp_axis_in)
        add_to_dve_wave(TdlTestPoint.sub_md1.tp_inter_tf)
    
        test_unit_init do 
            TdlTestPoint.sub_md1.enable_tp.root_ref   <= 1.b1 
            initial_exec("#(1us)")
            TdlTestPoint.sub_md1.enable_tp.root_ref   <= 1.b0 
            initial_exec("#(500us)")
        end
    
    end
    
    TdlTestUnit.tu1(__dir__) do 
        # puts TdlTestPoint.sub_md0.tp_cnt.path_refs
        add_to_dve_wave(TdlTestPoint.sub_md0.tp_cnt)
        add_to_dve_wave(TdlTestPoint.sub_md1.tp_cnt)
    end

    add_test_unit('tu0','tu1')


    ## TESTBENCH CTRL 
    techbench.instance_exec do 
        logic.clock(100)    - 'sys_clk'

        rtl_top['clock']     = sys_clk
        rtl_top['rst_n']     = 1.b1
    end

end
