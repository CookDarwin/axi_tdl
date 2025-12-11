require_relative '../../tdl.rb'

TdlBuild.test_axi4_M2S(File.join(__dir__,"tmp")) do 
    input.clock(100)    - 'clock'
    input.reset('low')  -'rst_n'

  
    axi4_inf(dsize: 32,clock: clock,reset: rst_n,idsize: 2,lsize: 10) - 'tmp_axi4_inf'
  
    tmp_axi4_inf.copy(name: 'axi4_sub0')
    tmp_axi4_inf.copy(name: 'axi4_sub1')

    tmp_axi4_inf << axi4_sub0
    tmp_axi4_inf << axi4_sub1

end