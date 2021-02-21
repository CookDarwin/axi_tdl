# sm = SdlModule.new(name:File.basename(__FILE__,".rb"))

# sm.Parameter("ORIGIN",'master')
# sm.Parameter("TO",'slaver')
# sm.Input("origin")
# sm.Output("to")

# sm.origin_sv = true

TdlBuild.vcs_axis_comptable do 
    parameter.ORIGIN   'master'
    parameter.TO        'slaver'
    input   - 'origin'
    output  - 'to'

end 