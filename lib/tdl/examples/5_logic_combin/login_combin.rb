require_relative '../../tdl.rb'

TdlBuild.test_logic_combin(__dir__) do 
    logic[7]    - 'a0'
    logic[5]    - 'a1'
    logic[9]    - 'a2'
    logic[9+5+7]    - 'ca'

    logic[2,8]  - 'b0'
    logic[16]   - 'b1'
    logic[32]   - 'cb'

    logic[1,8]  - 'c0'
    logic[3,8]  - 'c1'
    logic[2,16] - 'cc'

    Assign do 
        ca <= logic_bind_(a0, a1, a2)
        cb <= self.>>(b1, b0)
        cc <= self.<<(c0, c1)
    end
end