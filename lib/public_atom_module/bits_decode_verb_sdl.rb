
sm = SdlModule.new(name:"bits_decode_nc_verb")
sm.path = File.expand_path(__FILE__)
sm.real_sv_path = File.join(File.expand_path(__dir__),"#{File.basename(__FILE__,'.rb').sub(/_sdl/,'')}.sv")
sm.Parameter("NUM",16)
sm.Parameter("NSIZE",NqString.new('$clog2(NUM)'))
sm.Parameter("MODE","H")
sm.Input("origin_bits",dsize:sm.NUM)
sm.Output("code",dsize:sm.NSIZE)
sm.origin_sv = true



sm = SdlModule.new(name:"bits_decode_verb")
sm.path = File.expand_path(__FILE__)
sm.real_sv_path = File.join(File.expand_path(__dir__),"#{File.basename(__FILE__,'.rb').sub(/_sdl/,'')}.sv")
sm.Parameter("NUM",16)
sm.Parameter("NSIZE",NqString.new('$clog2(NUM)'))
sm.Parameter("MODE","H")
sm.Input 'clock'
sm.Input 'rst_n'
sm.Input("origin_bits",dsize:sm.NUM)
sm.Output("code",dsize:sm.NSIZE)
sm.origin_sv = true
