require_relative '../../tdl.rb'
require_relative "package.rb"

TdlBuild.test_package2(File.join(__dir__,"tmp")) do 
    require_package 'test_package'

    output - 'out'

    Assign do 
        out <= test_package.NUM
        out <= test_package.data
    end

    test_package.z_ing.y0

    Assign do 
        y0.op <= 0
        y0.op[0] <= 0
    end
    
end