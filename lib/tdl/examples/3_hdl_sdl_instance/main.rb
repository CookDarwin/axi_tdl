require_relative "../../tdl.rb"

add_to_tdl_paths __dir__

require_sdl 'sdl_test.rb'
require_hdl 'hdl_test.sv'

TdlBuild.main_md(__dir__) do 
    input.clock(100)        - 'clock'
    input.reset('low')      - 'rst_n'

    sdl_md.sdl_md_inst do |h| 
        h.input.clock                           clock
        h.input.rst_n                           rst_n
        h.output.logic[8].odata                 ''.to_nq
        h.port.axi_stream_inf.slaver.asi_inf    axi_stream_inf(clock: clock, reset: rst_n, dsize:8 ).tmp_inf
    end

    hdl_md.hdl_md_inst do |h|
        h.param.DSIZE       12
        h.input.clock               clock
        h.input.rst_n               rst_n
        h.output.logic[11,0].odata  output[12].oDdata   
    end

end