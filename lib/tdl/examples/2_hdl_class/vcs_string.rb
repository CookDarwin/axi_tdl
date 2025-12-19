require_relative '../../tdl.rb'
TdlBuild.test_vcs_string(File.join(__dir__,'tmp')) do 
    vcs_string(111).INIT_FILE 'ppppppppp'

end