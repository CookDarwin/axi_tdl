
#2018-05-04 14:40:11 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiLite


    def _jtag_to_axilite_wrapper(
        lite:"lite"
    )

        Tdl.add_to_all_file_paths('jtag_to_axilite_wrapper','../../axi/AXI_Lite/common_configure_reg_interface/jtag_to_axilite_wrapper.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['jtag_to_axilite_wrapper','../../axi/AXI_Lite/common_configure_reg_interface/jtag_to_axilite_wrapper.sv'])
        return_stream = self
        
        lite = AxiLite.same_name_socket(:to_down,mix=true,lite,nil,belong_to_module) unless lite.is_a? String
        
        
        


        belong_to_module.AxiLite_draw << _jtag_to_axilite_wrapper_draw(
            lite:lite)
        return return_stream
    end

    private

    def _jtag_to_axilite_wrapper_draw(
        lite:"lite"
    )

        large_name_len(
            lite
        )
        instance_name = "jtag_to_axilite_wrapper_#{signal}_inst"
"
// FilePath:::../../axi/AXI_Lite/common_configure_reg_interface/jtag_to_axilite_wrapper.sv
jtag_to_axilite_wrapper #{instance_name}(
/*  axi_lite_inf.master*/ .lite (#{align_signal(lite,q_mark=false)})
);
"
    end
    
    public

    def self.jtag_to_axilite_wrapper(
        lite:"lite",
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [lite].first.belong_to_module unless belong_to_module
        
        
        belong_to_module.AxiLite_NC._jtag_to_axilite_wrapper(
            lite:lite)
        return return_stream
    end
        

end

