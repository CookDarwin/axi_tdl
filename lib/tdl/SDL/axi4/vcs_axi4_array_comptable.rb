sm = SdlModule.new(name:File.basename(__FILE__,".rb"))

sm.Parameter("ORIGIN",'master')
sm.Parameter("TO",'slaver')
sm.Parameter("NUM",8)
sm.Input("origin")
sm.Output("to")

sm.origin_sv = true