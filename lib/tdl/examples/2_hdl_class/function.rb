require_relative '../../tdl.rb'


TdlBuild.test_function(File.join(__dir__,"./tmp")) do 
    output  - 'gp'
    input - 'inm'

    enum("IDLE") - 'ctrl'

    function.status(input[8].code,output[16].pl) do 
        IF "89".to_nq do 
            gp <= code
        end
    end

    function('logic').status_xp(input[8].code,output[16].pl) do 
        status_xp   <= (inm != 0) | (inm != 1)
    end

    function(ctrl).pre_status(input[8].code,output[16].pl,input.ctrl.ll) do 
        IF "89".to_nq do 
            gp <= code
            pre_status <= 0
        end
    end

    Assign do 
        gp <= status(67,gp+1,"opop".to_nq)
        gp <= pre_status()
        gp   <= (inm != 0) | (inm != 1)

    end

end
