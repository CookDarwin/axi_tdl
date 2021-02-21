require_relative '../../tdl.rb'

TdlBuild.test_module_var(File.join(__dir__,"tmp")) do 
    input.clock(100)    - 'clock'
    input.reset('low')  -'rst_n'

    axi_stream_inf(dsize: 8 ,clock: clock,reset: rst_n)     - 'tmp_axis_inf'
    axis(dsize: 8 ,clock: clock,reset: rst_n)               - 'tmp_axis0_inf'
    axi4_inf(dsize: 32,clock: clock,reset: rst_n,idsize: 2) - 'tmp_axi4_inf'
    data_inf(dsize: 5)  - 'tmp_data_inf'
    data_inf_c(dsize: 3,clock: clock,reset: rst_n)          - 'tmp_data_inf_c'

    parameter.DSIZE     10 
    localparam.ASIZE    20


    tmp_data_inf_c.inherited(name: "opopopopo")
end