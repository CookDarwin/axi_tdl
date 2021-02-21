require_relative '../../tdl.rb'
require_relative 'head_package.rb'
require_relative 'body_package.rb'

TdlBuild.with_package('head_package').example_pkg(__dir__) do 
    input[head_package.HDSIZE]  - 'indata'
    output.logic[32]            - 'odata'

    require_package('body_package')

    logic[body_package.BDSIZE]  - 'gdata'

    head_package.s_head     - 'ss_head'

    Assign do 
        ss_head.idata   <= 4
        ss_head.valid   <= 1.b1
    end

end