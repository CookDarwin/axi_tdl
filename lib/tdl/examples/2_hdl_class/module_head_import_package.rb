require_relative '../../tdl.rb'
require_relative "package.rb"

TdlBuild.with_package('test_package').head_pkg_module(File.join(__dir__,"tmp")) do 
    output[10] - 'out'
    port.data_inf_c.slaver(dsize: 8)[5]    - 'd_inf'
    tmp = input.test_package.z_ing[9]

    input.test_package.z_ing - 'struct_z'
    input.test_package.z_ing[9] - 'struct_z_l'

    Assign do 
        out <= test_package.NUM
        out <= test_package.data
        struct_z_l[8].op[0] <= 0
    end

    test_package.z_ing.y0

    Assign do 
        y0.op <= 1.b0
        y0.op[0] <= 1.d0
        y0.op[1] <= struct_z.op[1]
        y0.op[y0.op[3,1]] <= struct_z.op
    end

    test_package.z_ing - 'curr_y0'

    Assign do 
        curr_y0 <= struct_z
    end

    ## 
    logic[(test_package.NUM*8).clog2]   - 'clog2_data'
    
end