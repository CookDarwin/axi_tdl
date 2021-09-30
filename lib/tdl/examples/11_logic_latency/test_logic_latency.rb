require_relative '../../tdl.rb'
TdlBuild.test_logic_latency(__dir__) do 
    input               - 'data'
    input.clock(100)    - 'clock'
    input.reset('low')  - 'rst_n'
    output.logic        - 'od'

    Assign do 
        od <= data.broaden_and_cross_clk(wclk: clock,rclk: clock)
    end
end