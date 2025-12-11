require_relative '../../tdl.rb'
TdlBuild.test_initial_assert(File.join(__dir__,"tmp")) do 
    logic - 'ppx'
    initial do 
        assert(9) do 
            assert_error("iiiiiiiiiiiii")
        end
        ppx <= 1.b0
    end

end