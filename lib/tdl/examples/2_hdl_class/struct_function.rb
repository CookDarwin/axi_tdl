require_relative '../../tdl.rb'
require_relative "./../../class_hdl/hdl_function.rb"
require_relative "./../../class_hdl/hdl_struct.rb"

TdlBuild.test_struct_function(File.join(__dir__,"tmp")) do 
    parameter.NUM   8
    input           - 'ain'
    output          - 'bout'
    input[32]       - 'in_array'
    output[32]      - "out_array"
    
    logic[32] - 'data'

    def_struct.s_map do 
        logic.op 
        logic.yp
        logic[param.NUM].adata
        logic.data
    end

    s_map - 's_map_a1'

    function(s_map).f_g(input.s_map.fin) do 
        f_g <= fin.op
        f_g.yp <= 1
    end

end