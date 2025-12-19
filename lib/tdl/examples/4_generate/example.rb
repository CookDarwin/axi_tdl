require_relative '../../tdl.rb'

TdlBuild.test_generate(__dir__) do 
    parameter.NUM       8
    input[8]            - 'ain'
    output[8]           - 'bout'

    input[param.NUM,6]  - 'cin'
    output[6,param.NUM] - 'dout'

    input[param.NUM]    - 'ein'
    output[param.NUM]   - 'fout'

    generate(8) do |kk|
        Assign do 
            bout[kk]    <= ain[7-kk]
        end
    end

    generate(param.NUM) do |cc|
        IF cc < 4 do
            Assign do  
                dout[cc]    <= cin[cc]
            end
        end
        ELSE do 
            Assign do 
                dout[cc]    <= cin[cc] + cc 
            end
        end
    end

    generate(param.NUM,6) do |ii,gg|
        Assign do 
            fout[ii][gg]    <= ein[gg][ii]
        end
    end
end