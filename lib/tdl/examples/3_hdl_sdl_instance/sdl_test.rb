TdlBuild.sdl_md(__dir__) do 
    input.clock(100)            - 'clock'
    input.reset('low')          - 'rst_n'
    output.logic[8]             - 'odata'
    port.axi_stream_inf.slaver  - 'asi_inf'

    

end