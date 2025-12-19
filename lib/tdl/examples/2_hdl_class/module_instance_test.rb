require_relative '../../tdl.rb'
require_relative "./struct_function.rb"

TdlBuild.module_instance_test(File.join(__dir__,"tmp")) do 

    test_struct_function.test_struct_function_inst do |h|
        h.param.NUM             8
        h.port.input.ain                    'ain'.to_nq
        h.port.output.bout                  'bout'.to_nq
        h.port.input[32].in_array           'in_array'.to_nq
        h.port.output[32].out_array         "out_array".to_nq
    end
end