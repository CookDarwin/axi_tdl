
#2018-05-04 14:40:11 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class DataInf


    def _mdio_model(
        reset:"reset",
        mdio:"mdio",
        mdc:"mdc"
    )

        Tdl.add_to_all_file_paths('mdio_model','../../repository/ethernet_protocol/model/mdio_model.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['mdio_model','../../repository/ethernet_protocol/model/mdio_model.sv'])
        return_stream = self
        

        
        
        


        belong_to_module.DataInf_draw << _mdio_model_draw(
            reset:reset,
            mdio:mdio,
            mdc:mdc)
        return return_stream
    end

    private

    def _mdio_model_draw(
        reset:"reset",
        mdio:"mdio",
        mdc:"mdc"
    )

        large_name_len(
            reset,
            mdio,
            mdc
        )
        instance_name = "mdio_model_#{signal}_inst"
"
// FilePath:::../../repository/ethernet_protocol/model/mdio_model.sv
mdio_model #{instance_name}(
/*  input  */ .reset (#{align_signal(reset,q_mark=false)}),
/*  inout  */ .mdio  (#{align_signal(mdio,q_mark=false)}),
/*  input  */ .mdc   (#{align_signal(mdc,q_mark=false)})
);
"
    end
    
    public

    def self.mdio_model(
        reset:"reset",
        mdio:"mdio",
        mdc:"mdc",
        belong_to_module:nil
        )
        return_stream = nil
        
        
        
        belong_to_module.DataInf_NC._mdio_model(
            reset:reset,
            mdio:mdio,
            mdc:mdc)
        return return_stream
    end
        

end

