TdlPackage.head_package(__dir__) do 
    parameter.HDSIZE        8

    def_struct.s_head do 
        logic[4].idata
        logic.valid 
    end
end