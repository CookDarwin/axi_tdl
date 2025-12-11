require_relative '../../tdl.rb'
# require_relative "./../../class_hdl/hdl_struct.rb"
# require_relative "./../../class_hdl/hdl_package.rb"

TdlPackage.test_package(File.join(__dir__,"tmp")) do 

    parameter.NUM   6

    def_struct do 
        logic[32].op
        logic[param.NUM] - "pl"
    end - "s_ing"

    def_struct.z_ing do 
        logic[32].op
        logic[param.NUM] - "pl"
    end

    logic[32] - 'data'

    z_ing - 'zing_v0'

    s_ing.s_ing_v1

    Assign do 
        zing_v0.op[9] <= 0
    end
    
end
