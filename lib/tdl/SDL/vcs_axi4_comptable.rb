sm = SdlModule.new(name:File.basename(__FILE__,".rb"))

sm.Parameter("ORIGIN",'master')
sm.Parameter("TO",'slaver')
sm.Input("origin")
sm.Output("to")

sm.origin_sv = true
sm.real_sv_path = File.expand_path(File.join(__dir__, "../../axi/AXI4/vcs_axi4_comptable.sv"))