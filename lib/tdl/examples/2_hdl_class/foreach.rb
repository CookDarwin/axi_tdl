require_relative '../../tdl.rb'
TdlBuild.test_foreach(File.join(__dir__,"tmp")) do 
    parameter.NUM   10
    logic[32][32]   - 'data'

    always_comb do 
        FOREACH(data) do |i|
            IF i == param.NUM*(4-i) do
                data[i] <= 0.A 
            end 
            # ELSE do 
            #     FOREACH data[i] do |ii|
            #         data[i][ii] <= 1.A 
            #     end
            # end

            # puts ClassHDL::AssignDefOpertor.curr_assign_block.opertor_chains
        end
    end

end