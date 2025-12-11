
TdlBuild.simple_clock(__dir__) do 
    input.clock(30)         - 'sys_clk'
    output.clock(100)       - 'clock'
    output.reset('low')     - 'rst_n'

end