require_relative '../../tdl.rb'

TdlBuild.test_struct(File.join(__dir__,"tmp")) do 
    parameter.NUM   6

    def_struct.union do 
        logic[32].op
        logic[param.NUM] - "pl"
    end - "s_ing"

    def_struct.packed.z_ing do 
        logic[32].op
        logic[param.NUM] - "pl"
    end


    z_ing - 'zing_v0'

    s_ing.s_ing_v1

    z_ing[9][32] - 'zingx_v0'

    # puts z_ing.class

end