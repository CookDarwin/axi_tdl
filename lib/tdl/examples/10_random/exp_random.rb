require_relative '../../tdl.rb'
TdlBuild.exp_random(__dir__) do 
    parameter.PX        67
    output.logic        - 'param_random_b'
    output.logic        - 'int_random_b'
    output.logic[10]    - 'rd_range'

    Initial do 
        param_random_b  <= param.PX.precent_true
        int_random_b    <= 34.precent_false
        rd_range        <= urandom_range(12,1000)
    end
end