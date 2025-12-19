# sm = SdlModule.new(name:File.basename(__FILE__,".rb"))

# sm.Parameter("ORIGIN",'master')
# sm.Parameter("TO",'slaver')
# sm.Input("origin")
# sm.Output("to")

# sm.origin_sv = true

sm = TdlBuild.vcs_axis_comptable do 
    parameter.ORIGIN   'master'
    parameter.TO        'slaver'
    input   - 'origin'
    output  - 'to'
end 

sm.real_sv_path = File.expand_path(File.join(__dir__, "../../axi/AXI_stream/vcs_axis_comptable.sv"))