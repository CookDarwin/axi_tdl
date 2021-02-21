
TdlBuild.a_test_md(__dir__) do 
    input.clock(100)            - 'clock'
    input.reset('high')         - 'rst'
    port.axi_stream_inf.master  - 'origin_inf'
end